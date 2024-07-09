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
    var localizedDescription: String {
        switch self {
        case .failedDecode: return "Failed to decode response."
        case .fileNotFound: return "What Sticks API could not find the dashboard data on the server."
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
    var isOffline = true
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
    

    
    func connectDevice(){
        print("- in connectDevice() ")

//        UserDefaults.standard.removeObject(forKey: "userName")
        
        if UserDefaults.standard.string(forKey: "userName") == nil || UserDefaults.standard.string(forKey: "userName") == "new_user"  {
            self.user.username = "new_user"
            UserDefaults.standard.set("new_user", forKey: "userName")
            // register user ambivalent_elf_####
            callRegisterGenericUser { result_string_string_dict in
                switch result_string_string_dict{
                case .success(_):
                    print("response dict: success :)")
                    print("user's token: \(self.user.token!)")
                    self.requestStore.token = self.user.token
                    if let unwp_email = self.user.email{
                        print("user email: \(unwp_email)")
                    } else {
                        print("email is null")
                    }
                    UserDefaults.standard.set(self.user.username!, forKey: "userName")
                    self.isOffline=false
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
                print("login generic user")
                callLoginGenericUser(user: self.user) { result_dict_string_any_or_error in
                    switch result_dict_string_any_or_error {
                    case  .success(_):
                        print("--- Success! : token \(self.user.token!)")
                        self.isOffline=false
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

    func callConvertGenericAccountToCustomAccount(email: String?, username:String?, password: String?, completion: @escaping (Result<[String: String], Error>) -> Void) {
        var parameters: [String: String] = ["ws_api_password": Config.ws_api_password]
        
        if let email = email {
            parameters["new_email"] = email
        }
        
        if let username = username {
            parameters["new_username"] = username
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
                    completion(.failure(error))
                    return
                }
                // Ensure data is not nil, otherwise, complete with a custom error.
                guard let unwrappedData = data else {
                    print("No data response")
                    completion(.failure(UserStoreError.failedToReceiveServerResponse))
                    return
                }
                do {
                    // Attempt to decode the JSON response.
                    if let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [String: String] {
                        print("JSON serialized well")
                        // Ensure completion handler is called on the main queue.
                        DispatchQueue.main.async {
                            completion(.success(jsonResult))
                        }
                    } else {
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
            print("* error encodeing from reqeustStore.callRegisterNewUser")
            OperationQueue.main.addOperation {
                completion(.failure(error))
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
                    
//                    let jsonDecoder = JSONDecoder()
                    if let jsonResult = try JSONSerialization.jsonObject(with: unwrapped_data, options: []) as? [String: Any] {
                        print("JSON dictionary: \(jsonResult)")

                        // Assuming the JSON contains a "user" object, you can decode it into a User object
                        if let userData = try? JSONSerialization.data(withJSONObject: jsonResult["user"] ?? [:], options: []) {
                            let decoder = JSONDecoder()
                            let user = try decoder.decode(User.self, from: userData)

                            self.user = user
                        }
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
                
//                    let jsonDecoder = JSONDecoder()
                if let jsonResult = try JSONSerialization.jsonObject(with: unwrapped_data, options: []) as? [String: Any] {
                    print("JSON dictionary: \(jsonResult)")
                    
                    // Assuming the JSON contains a "user" object, you can decode it into a User object
                    if let userData = try? JSONSerialization.data(withJSONObject: jsonResult["user"] ?? [:], options: []) {
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(User.self, from: userData)
                        self.user = user
                        self.requestStore.token=self.user.token
                    }
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
                        
                        if let user_key_val = jsonResult["user"],
                           let userData = try? JSONSerialization.data(withJSONObject: user_key_val, options: []), let message = jsonResult["alert_message"] as? String {
                            
                            let decoder = JSONDecoder()
                            let user = try decoder.decode(User.self, from: userData)
                            self.user = user
                            OperationQueue.main.addOperation {
                                print("--> successful callUpdateUser api response")
                                completion(.success(message))
                            }
                            
                        } else {
                            print("- Failed to get a user back from API response < -----")
                            completion(.failure(UserStoreError.failedToReceiveExpectedResponse))
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

