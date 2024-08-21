//
//  UserVcComponents.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 07/07/2024.
//

import UIKit


class UserVcFindAppleHealthPermissionsView: UIView {
    let lblTitle = UILabel()
    let lblDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        setup_labels()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_labels()
    }
    func setup_labels(){
        lblTitle.accessibilityIdentifier="lblTitle-UserVcFindAppleHealthPermissionsView"
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.text = "Apple Health Permissions"
        lblTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblTitle.numberOfLines=0
        self.addSubview(lblTitle)
        
        lblDescription.accessibilityIdentifier="lblDescription-UserVcFindAppleHealthPermissionsView"
        lblDescription.translatesAutoresizingMaskIntoConstraints=false
        let text_for_message = "Go to Settings > Health > Data Access & Devices > WhatSticks to grant access.\n\nFor this app to work properly please make sure all data types are allowed."
        lblDescription.text = text_for_message
        lblDescription.numberOfLines = 0
        self.addSubview(lblDescription)
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
            lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 3)),
            lblDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -5))
        ])
    }
    
}




/* Maintanence -- for delete */

class UserStatusDevelopmentView: UIView {
    weak var delegate: UserStatusDevelopmentViewDelegate?
    let userStore = UserStore.shared
    var showLine:Bool!
    let vwUserStatusTemporaryLine = UIView()
    var viewTopAnchor:NSLayoutAnchor<NSLayoutYAxisAnchor>!
    let lblUserStatusTemporaryViewTitle = UILabel()
    
    let btnUserStatusTemporaryView = UIButton()
    let btnCheckUserDefaultUserLocation = UIButton()
    let btnCheckArryDataSourceObjects = UIButton()
    let btnCheckArryDashboardTableObjects = UIButton()
    let btnDeleteUserDefaults = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        self.showLine = false
        setup_UserStatusTemporaryView()
        setup_btnCheckUserDeafultUserLocaiton()
        setup_btnCheckArryDataSourceObjects()
        setup_btnCheckArrayDashboardTableObjects()
        setup_btnDeleteUserDefaults()
    }
    init(frame: CGRect, showLine: Bool) {
        self.showLine = showLine
        super.init(frame: frame)
        setup_UserStatusTemporaryView_lineOption()
        setup_UserStatusTemporaryView()
        setup_btnCheckUserDeafultUserLocaiton()
        setup_btnCheckArryDataSourceObjects()
        setup_btnCheckArrayDashboardTableObjects()
        setup_btnDeleteUserDefaults()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup_UserStatusTemporaryView_lineOption(){
        vwUserStatusTemporaryLine.accessibilityIdentifier = "vwUserStatusTemporaryLine"
        vwUserStatusTemporaryLine.translatesAutoresizingMaskIntoConstraints = false
        vwUserStatusTemporaryLine.backgroundColor = UIColor(named: "lineColor")
        self.addSubview(vwUserStatusTemporaryLine)
        NSLayoutConstraint.activate([
            vwUserStatusTemporaryLine.topAnchor.constraint(equalTo: self.topAnchor),
            vwUserStatusTemporaryLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vwUserStatusTemporaryLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vwUserStatusTemporaryLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    private func setup_UserStatusTemporaryView(){
        lblUserStatusTemporaryViewTitle.accessibilityIdentifier="lblUserStatusTemporaryViewTitle"
        lblUserStatusTemporaryViewTitle.translatesAutoresizingMaskIntoConstraints = false
        lblUserStatusTemporaryViewTitle.text = "🚧 For Development Testing 🚧"
        lblUserStatusTemporaryViewTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblUserStatusTemporaryViewTitle.numberOfLines=0
        self.addSubview(lblUserStatusTemporaryViewTitle)
        
        btnUserStatusTemporaryView.accessibilityIdentifier = "btnUserStatusTemporaryView"
        btnUserStatusTemporaryView.translatesAutoresizingMaskIntoConstraints = false
        btnUserStatusTemporaryView.setTitle("User values", for: .normal)
        let ui_color_btnTmpVw = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        btnUserStatusTemporaryView.layer.borderColor = ui_color_btnTmpVw.cgColor
        btnUserStatusTemporaryView.layer.borderWidth = 2
        btnUserStatusTemporaryView.backgroundColor = ui_color_btnTmpVw
        btnUserStatusTemporaryView.layer.cornerRadius = 10
        self.addSubview(btnUserStatusTemporaryView)
        
        btnUserStatusTemporaryView.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        btnUserStatusTemporaryView.addTarget(self, action: #selector(touchUpInside_User(_:)), for: .touchUpInside)
        
        if showLine{
            viewTopAnchor = vwUserStatusTemporaryLine.bottomAnchor
        } else {
            viewTopAnchor = self.topAnchor
        }
        
        NSLayoutConstraint.activate([
            lblUserStatusTemporaryViewTitle.topAnchor.constraint(equalTo: viewTopAnchor, constant: heightFromPct(percent: 3)),
            lblUserStatusTemporaryViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            lblUserStatusTemporaryViewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -1)),
            
            btnUserStatusTemporaryView.topAnchor.constraint(equalTo: lblUserStatusTemporaryViewTitle.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnUserStatusTemporaryView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 3)),
            btnUserStatusTemporaryView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: widthFromPct(percent: -3)),
        ])
    }
    private func setup_btnCheckUserDeafultUserLocaiton(){
        btnCheckUserDefaultUserLocation.accessibilityIdentifier = "btnCheckUserDefaultUserLocation"
        btnCheckUserDefaultUserLocation.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnCheckUserDefaultUserLocation)
        btnCheckUserDefaultUserLocation.setTitle("User Location", for: .normal)
        let ui_color_btnUserLoc = UIColor(red: 0.8, green: 0.5, blue: 0.5, alpha: 1.0)
        btnCheckUserDefaultUserLocation.layer.borderColor = ui_color_btnUserLoc.cgColor
        btnCheckUserDefaultUserLocation.layer.borderWidth = 2
        btnCheckUserDefaultUserLocation.backgroundColor = ui_color_btnUserLoc
        btnCheckUserDefaultUserLocation.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            btnCheckUserDefaultUserLocation.topAnchor.constraint(equalTo: btnUserStatusTemporaryView.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnCheckUserDefaultUserLocation.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnCheckUserDefaultUserLocation.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -1)),
        ])
        btnCheckUserDefaultUserLocation.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        btnCheckUserDefaultUserLocation.addTarget(self, action: #selector(touchUpInside_location(_:)), for: .touchUpInside)
    }
    private func setup_btnCheckArryDataSourceObjects(){
        btnCheckArryDataSourceObjects.accessibilityIdentifier = "btnCheckArryDataSourceObjects"
        btnCheckArryDataSourceObjects.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnCheckArryDataSourceObjects)
        btnCheckArryDataSourceObjects.setTitle("Data Source Objects", for: .normal)
        let ui_color_btnDataSourceObj = UIColor(red: 0.8, green: 0.8, blue: 0.5, alpha: 1.0)
        btnCheckArryDataSourceObjects.layer.borderColor = ui_color_btnDataSourceObj.cgColor
        btnCheckArryDataSourceObjects.layer.borderWidth = 2
        btnCheckArryDataSourceObjects.backgroundColor = ui_color_btnDataSourceObj
        btnCheckArryDataSourceObjects.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            btnCheckArryDataSourceObjects.topAnchor.constraint(equalTo: btnCheckUserDefaultUserLocation.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnCheckArryDataSourceObjects.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnCheckArryDataSourceObjects.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -1)),
//            btnCheckArryDataSourceObjects.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: heightFromPct(percent: -5))
        ])
        btnCheckArryDataSourceObjects.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        btnCheckArryDataSourceObjects.addTarget(self, action: #selector(touchUpInside_DataSourceObj(_:)), for: .touchUpInside)
    }
    private func setup_btnCheckArrayDashboardTableObjects(){
        btnCheckArryDashboardTableObjects.accessibilityIdentifier = "btnCheckArryDashboardTableObjects"
        btnCheckArryDashboardTableObjects.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnCheckArryDashboardTableObjects)
        btnCheckArryDashboardTableObjects.setTitle("Dashboard Table Objects", for: .normal)
        let ui_color_btnDashTableObj = UIColor(red: 0.8, green: 0.8, blue: 0.6, alpha: 1.0)
        btnCheckArryDashboardTableObjects.layer.borderColor = ui_color_btnDashTableObj.cgColor
        btnCheckArryDashboardTableObjects.layer.borderWidth = 2
        btnCheckArryDashboardTableObjects.backgroundColor = ui_color_btnDashTableObj
        btnCheckArryDashboardTableObjects.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            btnCheckArryDashboardTableObjects.topAnchor.constraint(equalTo: btnCheckArryDataSourceObjects.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnCheckArryDashboardTableObjects.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnCheckArryDashboardTableObjects.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -1)),
        ])
        btnCheckArryDashboardTableObjects.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        btnCheckArryDashboardTableObjects.addTarget(self, action: #selector(touchUpInside_DashTableObj(_:)), for: .touchUpInside)
    }
    private func setup_btnDeleteUserDefaults(){
        btnDeleteUserDefaults.accessibilityIdentifier = "btnDeleteUserDefaults"
        btnDeleteUserDefaults.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnDeleteUserDefaults)
        btnDeleteUserDefaults.setTitle("Clear UserDefaults", for: .normal)
        let ui_color_btnDataSourceObj = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        btnDeleteUserDefaults.layer.borderColor = ui_color_btnDataSourceObj.cgColor
        btnDeleteUserDefaults.layer.borderWidth = 2
        btnDeleteUserDefaults.backgroundColor = ui_color_btnDataSourceObj
        btnDeleteUserDefaults.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            btnDeleteUserDefaults.topAnchor.constraint(equalTo: btnCheckArryDashboardTableObjects.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnDeleteUserDefaults.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnDeleteUserDefaults.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -1)),
            btnDeleteUserDefaults.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: heightFromPct(percent: -5))
        ])
        btnDeleteUserDefaults.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        btnDeleteUserDefaults.addTarget(self, action: #selector(touchUpInside_DeleteUserDefaults(_:)), for: .touchUpInside)
    }
    
    
    
    
    /* user Button */
    @objc private func buttonTouchDown(_ sender: UIButton) {
        delegate?.touchDown(sender)
    }
    
    @objc func touchUpInside_User(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        let email = userStore.user.email ?? "nil"
        let username = userStore.user.username ?? "nil"
        let id = userStore.user.id ?? "nil"
        let token = userStore.user.token ?? "nil"
        let adminPermission = userStore.user.admin_permission ?? false
        let locationPermissionDevice = userStore.user.location_permission_device
        let locationPermissionWS = userStore.user.location_permission_ws ?? false

        let concatenatedString = """
        ---- UserStore.user ----
        email: \(email)
        username: \(username)
        id: \(id)
        token: \(token)
        admin_permission: \(adminPermission)
        location_permission_device: \(locationPermissionDevice)
        location_permission_ws: \(locationPermissionWS)
        """

        print(concatenatedString)

        let email_ud = UserDefaults.standard.string(forKey: "email") ?? "nil"
        let userName_ud = UserDefaults.standard.string(forKey: "userName") ?? "nil"
        let id_ud = UserDefaults.standard.string(forKey: "id") ?? "nil"
        let token_ud = UserDefaults.standard.string(forKey: "token") ?? "nil"
        let adminPermission_ud = UserDefaults.standard.string(forKey: "admin_permission") ?? "nil"
        let locationPermissionDevice_ud = UserDefaults.standard.string(forKey: "location_permission_device") ?? "nil"
        let locationPermissionWS_ud = UserDefaults.standard.string(forKey: "location_permission_ws") ?? "nil"

        let concatenatedString_ud = """
        ---- UserDefaults ----
        email_ud: \(email_ud)
        userName_ud: \(userName_ud)
        id_ud: \(id_ud)
        token_ud: \(token_ud)
        admin_permission_ud: \(adminPermission_ud)
        location_permission_device_ud: \(locationPermissionDevice_ud)
        location_permission_ws_ud: \(locationPermissionWS_ud)
        """
        print(concatenatedString_ud)
//        self.delegate?.templateAlert(alertTitle: "User i:", alertMessage: "\(concatenatedString) \n\n\n\n \(concatenatedString_ud) ",backScreen: false,dismissView: false)
        
        self.delegate?.templateAlert(alertTitle: "User i:", alertMessage: "\(concatenatedString) \n\n\n\n \(concatenatedString_ud) ", completion: nil)
        
    }
    
    @objc func touchUpInside_location(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        
        if let encodedData = UserDefaults.standard.data(forKey: "arryUserLocation") {
            do {
                let decodedArray = try JSONDecoder().decode([UserLocation].self, from: encodedData)
                self.delegate?.templateAlert(alertTitle: "User Location Array", alertMessage: "\(decodedArray)", completion: nil)
            } catch {
                print("*** (1) This should occur on first Launch: \(error) ***")
                self.delegate?.templateAlert(alertTitle: "NO User Location Array", alertMessage: "", completion: nil)
            }
        }
    }
    
    @objc func touchUpInside_DataSourceObj(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        let name_dso = userStore.arryDataSourceObjects?[0].name ?? "nil"
        let recordCount_dso = userStore.arryDataSourceObjects?[0].recordCount ?? "nil"
        let earliestRecordDate_dso = userStore.arryDataSourceObjects?[0].earliestRecordDate ?? "nil"
        
        let concatenatedString_dso = "name: \(name_dso) \n" + "recordCount: \(recordCount_dso) \n" + "earliestRecorededDate: \(earliestRecordDate_dso)"
        print("data source object: \(concatenatedString_dso)")
        
        self.delegate?.templateAlert(alertTitle: "Data Source Objects", alertMessage: concatenatedString_dso, completion: nil)
        
    }
    @objc func touchUpInside_DashTableObj(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        let count_of_obj = userStore.arryDashboardTableObjects.count
        let firstDepVarNam = userStore.arryDashboardTableObjects[0].dependentVarName ?? "nil"
        let firstDepVarIndepVarName = userStore.arryDashboardTableObjects[0].arryIndepVarObjects?[0].independentVarName ?? "nil"

        
        let concatenatedString_dso = "count_of_obj: \(count_of_obj) \n" + "firstDepVarNam: \(firstDepVarNam) \n" + "firstDepVarIndepVarName: \(firstDepVarIndepVarName)"
        print("count_of_obj: \(count_of_obj)")

        self.delegate?.templateAlert(alertTitle: "Dashboard Table Objects", alertMessage: concatenatedString_dso, completion: nil)
    }
    
    @objc func touchUpInside_DeleteUserDefaults(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)

        self.delegate?.templateAlertMultipleChoice(alertTitle: "Are you sure you want to delete all UserDefaults?", alertMessage: "", choiceOne: "Yes", choiceTwo: "No", completion: { responseYesNo in
            switch responseYesNo {
            case "Yes":
                UserStore.shared.deleteUserDefaults_User()
                self.delegate?.templateAlert(alertTitle: "Deleted UserDefaults", alertMessage: nil, completion: nil)
            default:
                print("")
            }
        })
    }
    
}

protocol UserStatusDevelopmentViewDelegate: AnyObject {
    func removeSpinner()
    func showSpinner()
//    func templateAlert(alertTitle:String,alertMessage: String,  backScreen: Bool, dismissView:Bool)
//    func presentAlertController(_ alertController: UIAlertController)
    func touchDown(_ sender: UIButton)
    func presentNewView(_ uiViewController: UIViewController)
    func templateAlert(alertTitle:String?,alertMessage:String?,completion: (() ->Void)?)
    func templateAlertMultipleChoice(alertTitle:String,alertMessage:String,choiceOne:String,choiceTwo:String, completion: ((String) -> Void)?)
}


