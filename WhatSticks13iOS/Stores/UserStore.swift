//
//  UserStore.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 29/06/2024.
//

import Foundation


enum UserStoreError: Error {
    case failedDecode
    case failedToLogin
    case failedToRegister
    case failedToUpdateUser
    case failedToReceiveServerResponse
    case failedToReceiveExpectedResponse
    case fileNotFound
    case noApiPasswordIncludedInRequest
    case userHasNoUsername
    case noInternetConnection
    case requestStoreError
    case serverError(statusCode: Int)
    case generalError(Error)
    var localizedDescription: String {
        switch self {
        case .failedDecode: return "Failed to decode response."
        case .fileNotFound: return "What Sticks API could not find the dashboard data on the server."
        case .generalError(let error): return "Caught in UserStore, error: \(error.localizedDescription)"
        default: return "What Sticks main server is not responding."
        }
    }
}

class UserStore {
    
    static let shared = UserStore()

    let fileManager:FileManager
    let documentsURL:URL
    var user=User()
    var arryDataSourceObjects:[DataSourceObject]?
    var boolDashObjExists:Bool!
    var boolMultipleDashObjExist:Bool!
    var arryDashboardTableObjects=[DashboardTableObject](){
        didSet{
            guard let unwp_pos = currentDashboardObjPos else {return}
            if arryDashboardTableObjects.count > currentDashboardObjPos{
                currentDashboardObject = arryDashboardTableObjects[unwp_pos]
                // error occurs line above. Error: out of range
            }
        }
    }
    var currentDashboardObject:DashboardTableObject?
    var currentDashboardObjPos: Int!
    var existing_emails = [String]()
    var urlStore:URLStore!
    var requestStore:RequestStore!
    var rememberMe = false
    var hasLaunchedOnce = false
    var isOnline = false
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    

    init() {
        //        self.user = User()
        self.fileManager = FileManager.default
        self.documentsURL = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //        checkAndSetDefaultUsername()

    }
    
    func deleteUserDefaults_User(){
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "admin_permission")
        UserDefaults.standard.removeObject(forKey: "location_permission_device")
        UserDefaults.standard.removeObject(forKey: "location_permission_ws")
    }
    
    func assignUser(dictUser:[String:Any]){
        print("---- in assignUser() ")
        do {
            if let userData = try? JSONSerialization.data(withJSONObject: dictUser["user"] ?? [:], options: []) {
                print("--- successfully decodeed step 1")
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: userData)
                self.user = user
                if let unwp_username = self.user.username{
                    UserDefaults.standard.set(unwp_username, forKey: "userName")
                    print("--- successfully decodeed step 2")
                }
                if let unwp_email = self.user.email{
                    UserDefaults.standard.set(unwp_email, forKey: "email")
                    print("--- successfully decodeed step 3")
                }

                if let unwp_id = self.user.id {
                    UserDefaults.standard.set(unwp_id, forKey: "id")
                    print("id saved as: \(unwp_id) -- step 5")
                }
                if let unwp_admin_permission = self.user.admin_permission {
                    UserDefaults.standard.set(unwp_admin_permission, forKey: "admin_permission")
                    print("unwp_admin_permission saved as: \(unwp_admin_permission) -- step 6")
                }
                if let unwp_location_permission_device = self.user.location_permission_device {
                    UserDefaults.standard.set(unwp_location_permission_device, forKey: "location_permission_device")
                    print("unwp_location_permission_device saved as: \(unwp_location_permission_device) -- step 7")
                }
                if let unwp_location_permission_ws = self.user.location_permission_ws {
                    UserDefaults.standard.set(unwp_location_permission_ws, forKey: "location_permission_ws")
                    print("unwp_location_permission_ws saved as: \(unwp_location_permission_ws) -- step 8")
                }
            }
        }
        catch {
            print("There was an error decoding User in the response")
        }
    }
    func checkUser(){
        if UserDefaults.standard.string(forKey: "userName") == nil || UserDefaults.standard.string(forKey: "userName") == "new_user"  {
            deleteUserDefaults_User()
            self.user.username = "new_user"
            UserDefaults.standard.set("new_user", forKey: "userName")
        } else {
            user.email = UserDefaults.standard.string(forKey: "email")
            user.username = UserDefaults.standard.string(forKey: "userName")
            user.password = UserDefaults.standard.string(forKey: "password")
            user.id = UserDefaults.standard.string(forKey: "id")
            user.admin_permission = UserDefaults.standard.bool(forKey: "admin_permission")
            user.location_permission_device = UserDefaults.standard.bool(forKey: "location_permission_device")
            user.location_permission_ws = UserDefaults.standard.bool(forKey: "location_permission_ws")
        }
    }
    
    func connectDevice(completion: @escaping () -> Void){
        print("- in connectDevice(completion) ")
//        deleteUserDefaults_User()
        checkUser()

        // Condition #1: Register user ambivalent_elf_####
        if UserDefaults.standard.string(forKey: "userName") == nil || UserDefaults.standard.string(forKey: "userName") == "new_user"  {
            callRegisterGenericUser { result_string_string_dict in
                switch result_string_string_dict{
                case .success(_):
                    self.requestStore.token = self.user.token
                    if let unwp_email = self.user.email{
                        print("user email: \(unwp_email)")
                    } else {
                        print("email is null")
                    }
                    UserDefaults.standard.set(self.user.username!, forKey: "userName")
                    self.isOnline=true
                    completion()
                case .failure(_):
                    print("--- Off line mode ")
                    completion()
                }
            }
        } 
        // Condition #2: Login with Generic Elf
        else if UserDefaults.standard.string(forKey: "email") == nil  {
            self.user.username  = UserDefaults.standard.string(forKey: "userName")
            // login user
            // call /login
            if UserDefaults.standard.string(forKey: "userEmail") == nil {
                callLoginGenericUser(user: self.user) { result_dict_string_any_or_error in
                    switch result_dict_string_any_or_error {
                    case  .success(_):
                        print("--- Success! : token \(self.user.token!)")
                        self.isOnline=true
                        self.requestStore.token = self.user.token
                        completion()
                    case .failure(_):
                        print("--- Off line mode ")
                        completion()
                    }
                }
            } else {
                print("login real user")
                completion()
            }
        }
        // Condition #3: Login with account
        else {
            print("---- Login with email and password ---")
            callLogin(user: self.user) { result_dict_or_error in
                switch result_dict_or_error {
                case let .success(jsonDict):
                    self.isOnline=true
                    completion()
                case let .failure(error):
                    print("error: \(error)")
                    completion()
                }
            }
        }
    }

    func callConvertGenericAccountToCustomAccount(email: String?, username:String?, password: String?, completion: @escaping (Result<[String: String], UserStoreError>) -> Void) {
        var parameters: [String: String] = ["ws_api_password": Config.ws_api_password]
        
        if let email = email {
            parameters["email"] = email
        }
        
        if let username = username {
            parameters["username"] = username
        }
        
        if let password = password {
            parameters["password"] = password
        }
        //        let request = requestStore.createRequestWithBody(endPoint: .register,token:true, body: parameters)
        let result = requestStore.createRequestWithTokenAndBodyWithAuth(endPoint: .convert_generic_account_to_custom_account,token:true, stringDict: parameters)
        
        switch result {
        case .success(let request):
            
            let task = session.dataTask(with: request) { data, response, error in
                // Check for an error. If there is one, complete with failure.
                if let error = error {
                    print("Network request error: \(error.localizedDescription)")
                    completion(.failure(UserStoreError.noInternetConnection))
                    return
                }
                // Ensure data is not nil, otherwise, complete with a custom error.
                guard let unwrappedData = data else {
                    print("No data response")
                    completion(.failure(UserStoreError.failedToReceiveServerResponse))
                    return
                }
                do {
                    print("- there is a response - 1 ")
                    // Attempt to decode the JSON response.
                    if let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [String: Any] {
                        print("JSON serialized well")
                        let keysToExtract = ["alert_title", "alert_message"]
                        var dictModifiedResponse: [String: String] = [:]

                        for key in keysToExtract {
                            if let value = jsonResult[key] as? String {
                                dictModifiedResponse[key] = value
                            }
                        }
                        self.assignUser(dictUser: jsonResult)
                        
                        // Ensure completion handler is called on the main queue.
                        DispatchQueue.main.async {
                            completion(.success(dictModifiedResponse))
                        }
                    } else {
                        print("- there is a response - 2 ")
                        // If decoding fails due to not being a [String: String]
                        DispatchQueue.main.async {
                            completion(.failure(UserStoreError.failedToReceiveExpectedResponse))
                        }
                    }
                } catch {
                    // Handle any errors that occurred during the JSON decoding.
                    print("---- UserStore.registerNewUser: Failed to read response")
                    DispatchQueue.main.async {
                        completion(.failure(UserStoreError.failedDecode))
                    }
                }
            }
            task.resume()
        case .failure(let error):
            print("* error encodeing from requestStore.callRegisterNewUser: \(error)")
            OperationQueue.main.addOperation {
                completion(.failure(UserStoreError.requestStoreError))
            }
        }
    }
    
    func callRegisterGenericUser(completion: @escaping (Result<[String:Any], Error>) -> Void) {

        guard let unwp_email = user.username else {
            completion(.failure(UserStoreError.userHasNoUsername))
            return
        }
        let result = requestStore.createRequestWithTokenAndBody(endPoint: .register_generic_account, token: false, body: ["new_username": unwp_email, "ws_api_password":Config.ws_api_password])
        
        
        switch result {
        case .success(let request):
            let task = session.dataTask(with: request) { (data, response, error) in
                // Handle the task's completion here as before
                guard let unwrapped_data = data else {
                    OperationQueue.main.addOperation {
                        completion(.failure(UserStoreError.failedToReceiveServerResponse))
                        print("failed to recieve response")
                    }
                    return
                }
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: unwrapped_data, options: []) as? [String: Any] {
                        print("JSON dictionary: \(jsonResult)")

                        self.assignUser(dictUser: jsonResult)
                        OperationQueue.main.addOperation {
                            completion(.success(jsonResult))
                        }
                    }

                } catch {
                    OperationQueue.main.addOperation {
                        print("--- Failed in callRegisterGenericUser")
                        completion(.failure(UserStoreError.failedToLogin))
                    }
                }
            }
            task.resume()
            
        case .failure(let error):
            // Handle the error here
            print("* error encodeing from reqeustStore.createRequestLogin")
            OperationQueue.main.addOperation {
                completion(.failure(error))
            }
        }
    }
    
    func callLoginGenericUser(user:User, completion: @escaping(Result<[String:Any],Error>) ->Void){
        print("- in callLoginGenericUser -")
        var parameters: [String: String] = ["ws_api_password": Config.ws_api_password]
        if let username = user.username {
            parameters["username"] = username
        } else {
            completion(.failure(UserStoreError.failedToLogin))
            return
        }
        let request = requestStore.createRequestWithUsername(endPoint: .login_generic_account,body: parameters)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network request error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No data response or invalid response")
                completion(.failure(UserStoreError.failedToReceiveServerResponse))
                return
            }
            
            // Handle the 400 status code specifically
            if httpResponse.statusCode == 400 {
                print("Received 400 Bad Request")
                completion(.failure(UserStoreError.userHasNoUsername))
                return
            }

            // Ensure data is not nil, otherwise, complete with a custom error.
            guard let unwrapped_data = data else {
                print("No data response")
                completion(.failure(UserStoreError.failedToReceiveServerResponse))
                return
            }
        
            do {
                
                if let jsonResult = try JSONSerialization.jsonObject(with: unwrapped_data, options: []) as? [String: Any] {
                    print("JSON dictionary: \(jsonResult)")
                    self.assignUser(dictUser: jsonResult)
                    OperationQueue.main.addOperation {
                        completion(.success(jsonResult))
                    }
                }

            } catch {
                OperationQueue.main.addOperation {
                    print("Failed to decode user or find a user in API response: \(UserStoreError.failedToLogin)")
                    completion(.failure(UserStoreError.failedToLogin))
                }
            }
            
        }
        task.resume()
    }
    
    
    func callLogin(user:User, completion: @escaping(Result<[String:Any],UserStoreError>) ->Void){
        print("- in callLoginUser -")
        var parameters: [String: String] = ["ws_api_password": Config.ws_api_password]
        if let username = user.email,
           let password = user.password{
            parameters["email"] = username
            parameters["password"] = password
        } else {
            completion(.failure(UserStoreError.failedToLogin))
            return
        }
        let result = requestStore.createRequestWithTokenAndBodyWithAuth(endPoint: .login,token:false, stringDict: parameters)
        
        switch result {
        case .success(let request):
            
            let task = session.dataTask(with: request) { data, response, error in
                // Check for an error. If there is one, complete with failure.
                if let error = error {
                    print("Network request error: \(error.localizedDescription)")
                    completion(.failure(UserStoreError.noInternetConnection))
                    return
                }
                // Ensure data is not nil, otherwise, complete with a custom error.
                guard let unwrappedData = data else {
                    print("No data response")
                    completion(.failure(UserStoreError.failedToReceiveServerResponse))
                    return
                }
                do {
                    print("- there is a response - 1 ")
                    // Attempt to decode the JSON response.
                    if let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [String: Any] {
                        print("JSON serialized well")
                        let keysToExtract = ["alert_title", "alert_message"]
                        var dictModifiedResponse: [String: String] = [:]

                        for key in keysToExtract {
                            if let value = jsonResult[key] as? String {
                                dictModifiedResponse[key] = value
                            }
                        }
                        self.assignUser(dictUser: jsonResult)
                        
                        // Ensure completion handler is called on the main queue.
                        DispatchQueue.main.async {
                            completion(.success(dictModifiedResponse))
                        }
                    } else {
                        print("- there is a response - 2 ")
                        // If decoding fails due to not being a [String: String]
                        DispatchQueue.main.async {
                            completion(.failure(UserStoreError.failedToReceiveExpectedResponse))
                        }
                    }
                } catch {
                    // Handle any errors that occurred during the JSON decoding.
                    print("---- UserStore.registerNewUser: Failed to read response")
                    DispatchQueue.main.async {
                        completion(.failure(UserStoreError.failedDecode))
                    }
                }
            }
            task.resume()
        case .failure(let error):
            print("* error encodeing from requestStore.callRegisterNewUser: \(error)")
            OperationQueue.main.addOperation {
                completion(.failure(UserStoreError.requestStoreError))
            }
        }
    }
    
    func callDeleteUser(completion: @escaping (Result<[String: String], UserStoreError>) -> Void) {
        print("- in callDeleteAppleHealthData")
        let request = requestStore.createRequestWithToken(endpoint: .delete_user)
        let task = requestStore.session.dataTask(with: request) { data, response, error in
            // Handle potential error from the data task
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(UserStoreError.generalError(error)))
                    print("- callDeleteUser: failure response")
                    print("\(UserStoreError.generalError(error).localizedDescription)")
                }
                return
            }
            guard let unwrapped_data = data else {
                // No data scenario
                DispatchQueue.main.async {
//                    completion(.failure(URLError(.badServerResponse)))
                    completion(.failure(UserStoreError.generalError(URLError(.badServerResponse))))
                    print("- callDeleteUser: failure response: \(URLError(.badServerResponse))")
                }
                return
            }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: unwrapped_data, options: []) as? [String: String] {
                    DispatchQueue.main.async {
                        self.deleteUserDefaults_User()
                        completion(.success(jsonResult))
                        print("- callDeleteUser: Successful response: \(jsonResult)")
                    }
                } else {
                    // Data is not in the expected format
                    DispatchQueue.main.async {
//                        completion(.failure(URLError(.cannotParseResponse)))
                        completion(.failure(UserStoreError.generalError(URLError(.cannotParseResponse))))
                        print("- callDeleteUser: failure response: \(URLError(.cannotParseResponse))")
                    }
                }
            } catch {
                // Data parsing error
                DispatchQueue.main.async {
                    completion(.failure(UserStoreError.generalError(error)))
                    print("- callDeleteUser: failure response: \(error)")
                }
            }
        }
        task.resume()
    }
    
}

/* Good For now */
extension UserStore {
    func callUpdateUser(endPoint: EndPoint, updateDict: [String:String], completion: @escaping (Result<String, UserStoreError>) -> Void) {
        var updateDictWithApiPassword = updateDict
        updateDictWithApiPassword["ws_api_password"]=Config.ws_api_password
        let result = requestStore.createRequestWithTokenAndBody(endPoint: endPoint,token:true, body: updateDictWithApiPassword)
        switch result {
        case .success(let request):
            let task = session.dataTask(with: request) { data, response, error in
                guard let unwrappedData = data else {
                    print("no data response")
                    completion(.failure(UserStoreError.failedToReceiveServerResponse))
                    return
                }
                
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("No data response or invalid response")
                    completion(.failure(UserStoreError.failedToReceiveServerResponse))
                    return
                }
                
                // Handle the 400 status code specifically
                if httpResponse.statusCode == 400 {
                    print("Received 400 Bad Request")
                    completion(.failure(UserStoreError.userHasNoUsername))
                    return
                }
                if httpResponse.statusCode == 401 {
                    print("Received 401 Bad Request")
                    completion(.failure(UserStoreError.noApiPasswordIncludedInRequest))
                    return
                }
                
                
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [String: Any] {
                        self.assignUser(dictUser: jsonResult)
                        
                        if let message = jsonResult["alert_message"] as? String {
                            OperationQueue.main.addOperation {
                                print("--> successful callUpdateUser api response")
                                completion(.success(message))
                            }
                        }
                        
                    } else {
                        throw UserStoreError.failedDecode
                    }
                } catch {
                    print("---- UserStore.failedToUpdateUser: Failed to read response")
                    completion(.failure(UserStoreError.failedDecode))
                }
            }
            task.resume()
        case .failure(let error):
            print("Failed to make request: \(error)")
            completion(.failure(UserStoreError.requestStoreError))
        }
    }
    
    func callSendUserLocation(dictSendUserLocation:DictSendUserLocation, completion: @escaping(Result<Bool,Error>) ->Void) -> Void{
        
        let result = requestStore.createRequestWithTokenAndBody(endPoint: .update_user_location_with_user_location_json, token: true, body: dictSendUserLocation)
        
        switch result {
        case .success(let request):
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("UserStore.callSendUserLocationJsonData received an error. Error: \(error)")
                    DispatchQueue.main.async {
                        completion(.failure(UserStoreError.failedToReceiveExpectedResponse))
                    }
                    return
                }
                guard let unwrapped_data = data else {
                    // No data scenario
                    DispatchQueue.main.async {
                        completion(.failure(UserStoreError.failedToReceiveExpectedResponse))
                        print("UserStore.callSendUserLocationJsonData received unexpected json response from WSAPI. URLError(.badServerResponse): \(URLError(.badServerResponse))")
                    }
                    return
                }
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: unwrapped_data, options: []) as? [String: String] {
                        print("-- successful send of user_location.json data --")
                        print(jsonResult)
                        DispatchQueue.main.async {
                            completion(.success(true))
                        }
                        if jsonResult["alert_title"] == "Success!"{
                            //                        self.deleteJsonFile(filename: "user_location.json")
                            UserDefaults.standard.removeObject(forKey: "user_location")
                        }
                    } else {
                        // Data is not in the expected format
                        DispatchQueue.main.async {
                            completion(.failure(UserStoreError.failedToReceiveExpectedResponse))
                            print("UserStore.callSendUserLocationJsonData received unexpected json response from WSAPI. URLError(.cannotParseResponse): \(URLError(.cannotParseResponse))")
                        }
                    }
                } catch {
                    // Data parsing error
                    DispatchQueue.main.async {
                        completion(.failure(UserStoreError.failedDecode))
                        print("UserStore.callSendUserLocationJsonData produced an error while parsing. Error: \(error)")
                    }
                }
            }
            
            task.resume()
        case .failure(let error):
            print("Failed to make request: \(error)")
            
        }
        
    }
    
    
}

/* OBE */
extension UserStore {
    func connectDevice(){
        print("- in connectDevice() ")

//        UserDefaults.standard.removeObject(forKey: "userName")
        deleteUserDefaults_User()
        
        if UserDefaults.standard.string(forKey: "userName") == nil || UserDefaults.standard.string(forKey: "userName") == "new_user"  {
            self.user.username = "new_user"
            UserDefaults.standard.set("new_user", forKey: "userName")
            // register user ambivalent_elf_####
            callRegisterGenericUser { result_string_string_dict in
                switch result_string_string_dict{
                case .success(_):
                    self.requestStore.token = self.user.token
                    if let unwp_email = self.user.email{
                        print("user email: \(unwp_email)")
                    } else {
                        print("email is null")
                    }
                    UserDefaults.standard.set(self.user.username!, forKey: "userName")
                    self.isOnline=true
                case .failure(_):
                    print("--- Off line mode ")
                }
            }
        } // Register Generic Elf
        else {
            self.user.username  = UserDefaults.standard.string(forKey: "userName")
            // login user
            // call /login
            if UserDefaults.standard.string(forKey: "userEmail") == nil {
                callLoginGenericUser(user: self.user) { result_dict_string_any_or_error in
                    switch result_dict_string_any_or_error {
                    case  .success(_):
                        print("--- Success! : token \(self.user.token!)")
                        self.isOnline=true
                        self.requestStore.token = self.user.token
                    case .failure(_):
                        print("--- Off line mode ")
                    }
                }
            } else {
                print("login real user")
            }
        } // Login Generic Elf
        if UserDefaults.standard.string(forKey: "hasLaunchedOnce") == nil {
            UserDefaults.standard.set(true, forKey: "hasLaunchedOnce")
            self.hasLaunchedOnce = true
        }
    }
}
