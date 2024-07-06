//
//  UserVC.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class UserVC: TemplateVC {
//    let lblScreenName = UILabel()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var lblFindSettingsScreenForAppleHealthPermission = UILabel()
    var lblPermissionsTitle = UILabel()
    
    let vwLineLocationDayWeather=UIView()
    let lblLocationDayWeatherTitle = UILabel()
    let lblLocationDayWeatherDetails = UILabel()
    // old name: LocationDayWeatherSwitch
    let stckVwLocTrackReoccurring=UIStackView()
    let lblLocTrackReoccurringSwitch=UILabel()
    let swtchLocTrackReoccurring = UISwitch()
    var btnUpdate = UIButton()
    var updateDict:[String:String] = [:]
    
    let lineViewUserCredentials = UIView()
    
    let lineViewUserAcct = UIView()
    let lblDeleteUser=UILabel()
    var btnDeleteUser=UIButton()
    
    let vwUserVcAccount = UserVcAccount()
    
    let lblRegisterUser=UILabel()
    var btnRegisterUser=UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let userStore = UserStore.shared
        self.setup_TopSafeBar()
        setup_scrollView()
        setupContent()
        setup_lblFindSettingsScreenForAppleHealthPermission()
        setup_locationDayWeather()
        setup_userLineView()
        print("user name is \(userStore.user.username!) -- UserVC")
        if userStore.user.email == nil {
            print("register user")
            setup_btnRegisterUser()
            
        }else {
            setup_btnDeleteUser()
        }
    }
    func setup_scrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints=false
        scrollView.accessibilityIdentifier = "scrollView"
        view.addSubview(scrollView)

        // Add constraints to the scrollView to respect the safe area
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupContent() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Example content view constraints
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
            // Important for horizontal scrolling
            // Set the contentView's height constraint to be greater than or equal to the scrollView's height for vertical scrolling if needed
        ])
    }


    
    func setup_lblFindSettingsScreenForAppleHealthPermission(){
        
        lblPermissionsTitle.accessibilityIdentifier="lblPermissionsTitle"
        lblPermissionsTitle.translatesAutoresizingMaskIntoConstraints = false
        lblPermissionsTitle.text = "Apple Health Permissions"
        lblPermissionsTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblPermissionsTitle.numberOfLines=0
        contentView.addSubview(lblPermissionsTitle)
        
        lblFindSettingsScreenForAppleHealthPermission.accessibilityIdentifier="lblFindSettingsScreenForAppleHealthPermission"
        lblFindSettingsScreenForAppleHealthPermission.translatesAutoresizingMaskIntoConstraints=false
        let text_for_message = "Go to Settings > Health > Data Access & Devices > WhatSticks to grant access.\n\nFor this app to work properly please make sure all data types are allowed."
        lblFindSettingsScreenForAppleHealthPermission.text = text_for_message
        lblFindSettingsScreenForAppleHealthPermission.numberOfLines = 0
        contentView.addSubview(lblFindSettingsScreenForAppleHealthPermission)
        
        NSLayoutConstraint.activate([
            lblPermissionsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: heightFromPct(percent: 3)),
            lblPermissionsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblPermissionsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthFromPct(percent: 2)),
            
            lblFindSettingsScreenForAppleHealthPermission.topAnchor.constraint(equalTo: lblPermissionsTitle.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblFindSettingsScreenForAppleHealthPermission.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblFindSettingsScreenForAppleHealthPermission.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthFromPct(percent: 2)),
        ])
    }
    
    private func setup_locationDayWeather() {
        vwLineLocationDayWeather.accessibilityIdentifier = "vwLineLocationDayWeather"
        vwLineLocationDayWeather.translatesAutoresizingMaskIntoConstraints = false
        vwLineLocationDayWeather.backgroundColor = UIColor(named: "lineColor")
        contentView.addSubview(vwLineLocationDayWeather)
        
        lblLocationDayWeatherTitle.accessibilityIdentifier="lblLocationDayWeatherTitle"
        lblLocationDayWeatherTitle.text = "Location Weather Tracking"
        lblLocationDayWeatherTitle.translatesAutoresizingMaskIntoConstraints=false
        lblLocationDayWeatherTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblLocationDayWeatherTitle.numberOfLines = 0
        contentView.addSubview(lblLocationDayWeatherTitle)
        
        lblLocationDayWeatherDetails.accessibilityIdentifier="lblLocationDayWeatherDetails"
        lblLocationDayWeatherDetails.text = "Allow What Sticks (WS) to collect your location to provide weather and timezone calculations for impacts on sleep and exercise. \n\nTurning this on will allow WS to collect your location daily."
        lblLocationDayWeatherDetails.translatesAutoresizingMaskIntoConstraints=false
        lblLocationDayWeatherDetails.numberOfLines = 0
        contentView.addSubview(lblLocationDayWeatherDetails)
        
        stckVwLocTrackReoccurring.accessibilityIdentifier="stckVwLocationDayWeather"
        stckVwLocTrackReoccurring.translatesAutoresizingMaskIntoConstraints=false
        stckVwLocTrackReoccurring.spacing = 5
        stckVwLocTrackReoccurring.axis = .horizontal
        contentView.addSubview(stckVwLocTrackReoccurring)
        
        lblLocTrackReoccurringSwitch.accessibilityIdentifier="lblLocationDayWeatherSwitch"
        lblLocTrackReoccurringSwitch.translatesAutoresizingMaskIntoConstraints=false
        stckVwLocTrackReoccurring.addArrangedSubview(lblLocTrackReoccurringSwitch)
        
        swtchLocTrackReoccurring.accessibilityIdentifier = "swtchLocationDayWeather"
        swtchLocTrackReoccurring.translatesAutoresizingMaskIntoConstraints = false
        swtchLocTrackReoccurring.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        stckVwLocTrackReoccurring.addArrangedSubview(swtchLocTrackReoccurring)
        
//        print("----> locationFetcher.userLocationManagerAuthStatus: \(locationFetcher.userLocationManagerAuthStatus)")
//
//        if locationFetcher.userLocationManagerAuthStatus == "Denied"{
//            print("*** accessed ?")
//            swtchLocTrackReoccurring.isOn=false
//            locationFetcher.stopMonitoringLocationChanges()
//
//        } else {
//            // Set Location Switch
//            if let unwp_user_loc_permission = userStore.user.location_reoccuring_permission  {
//                swtchLocTrackReoccurring.isOn = unwp_user_loc_permission
//                if unwp_user_loc_permission{
//                    if locationFetcher.userLocationManagerAuthStatus == "Authorized Always"{
//                        locationFetcher.startMonitoringLocationChanges()
//                    } else {
//                        locationFetcher.stopMonitoringLocationChanges()
//                    }
//                }
//            }
//        }

        setLocationSwitchLabelText()
        
        NSLayoutConstraint.activate([
            vwLineLocationDayWeather.topAnchor.constraint(equalTo: lblFindSettingsScreenForAppleHealthPermission.bottomAnchor, constant: heightFromPct(percent: 15)),
            vwLineLocationDayWeather.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwLineLocationDayWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwLineLocationDayWeather.heightAnchor.constraint(equalToConstant: 1),
            
            lblLocationDayWeatherTitle.topAnchor.constraint(equalTo: vwLineLocationDayWeather.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblLocationDayWeatherTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lblLocationDayWeatherTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            lblLocationDayWeatherDetails.topAnchor.constraint(equalTo: lblLocationDayWeatherTitle.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblLocationDayWeatherDetails.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lblLocationDayWeatherDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            stckVwLocTrackReoccurring.topAnchor.constraint(equalTo: lblLocationDayWeatherDetails.bottomAnchor, constant: heightFromPct(percent: 2)),
            stckVwLocTrackReoccurring.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: widthFromPct(percent: -2)),
        ])
    }
    
    func setup_userCredentials(){
        lineViewUserCredentials.backgroundColor = UIColor(named: "lineColor")
        contentView.addSubview(lineViewUserCredentials)
        lineViewUserAcct.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setup_userLineView(){
        lineViewUserAcct.backgroundColor = UIColor(named: "lineColor")
        contentView.addSubview(lineViewUserAcct)
        lineViewUserAcct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineViewUserAcct.bottomAnchor.constraint(equalTo: swtchLocTrackReoccurring.bottomAnchor, constant: heightFromPct(percent: 5)),
            lineViewUserAcct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineViewUserAcct.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineViewUserAcct.heightAnchor.constraint(equalToConstant: 1), // Set line thickness
            ])
    }
    

    
    
    func setup_btnRegisterUser(){

        
        lblRegisterUser.accessibilityIdentifier="lblRegisterUser"
        lblRegisterUser.text = "Register an account"
        lblRegisterUser.translatesAutoresizingMaskIntoConstraints=false
        lblRegisterUser.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblRegisterUser.numberOfLines = 0
        contentView.addSubview(lblRegisterUser)
        
        vwUserVcAccount.setup_views()
        vwUserVcAccount.accessibilityIdentifier = "vwUserVcAccount"
        vwUserVcAccount.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwUserVcAccount)
               
        
        btnRegisterUser.translatesAutoresizingMaskIntoConstraints=false
        btnRegisterUser.accessibilityIdentifier="btnRegisterUser"
        btnRegisterUser.addTarget(self, action: #selector(self.touchDown(_:)), for: .touchDown)
        btnRegisterUser.addTarget(self, action: #selector(touchUpInside_btnRegisterUser(_:)), for: .touchUpInside)
        btnRegisterUser.backgroundColor = .systemBlue
        btnRegisterUser.layer.cornerRadius = 10
        btnRegisterUser.setTitle(" Register Account ", for: .normal)
        contentView.addSubview(btnRegisterUser)
        
        NSLayoutConstraint.activate([
            lblRegisterUser.topAnchor.constraint(equalTo: lineViewUserAcct.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblRegisterUser.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: widthFromPct(percent: 2)),
            lblRegisterUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthFromPct(percent: 2)),
            
            
            vwUserVcAccount.topAnchor.constraint(equalTo: lblRegisterUser.bottomAnchor, constant: smallPaddingTop),
            vwUserVcAccount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: smallPaddingSide),
            vwUserVcAccount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -smallPaddingSide),
            vwUserVcAccount.heightAnchor.constraint(equalToConstant: 50),
            
            
            btnRegisterUser.topAnchor.constraint(equalTo: vwUserVcAccount.bottomAnchor, constant: heightFromPct(percent:4)),
            btnRegisterUser.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: widthFromPct(percent: -2)),
            btnRegisterUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnRegisterUser.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -2)),
        ])
    }
    func setup_btnDeleteUser(){
        lblDeleteUser.accessibilityIdentifier="lblDeleteUser"
        lblDeleteUser.text = "Delete Account"
        lblDeleteUser.translatesAutoresizingMaskIntoConstraints=false
        lblDeleteUser.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblDeleteUser.numberOfLines = 0
        contentView.addSubview(lblDeleteUser)
        
        btnDeleteUser.translatesAutoresizingMaskIntoConstraints=false
        btnDeleteUser.accessibilityIdentifier="btnDeleteUser"
//        btnDeleteUser.addTarget(self, action: #selector(self.touchDown(_:)), for: .touchDown)
        btnDeleteUser.addTarget(self, action: #selector(touchUpInside_btnDeleteUser(_:)), for: .touchUpInside)
        btnDeleteUser.backgroundColor = .systemRed
        btnDeleteUser.layer.cornerRadius = 10
        btnDeleteUser.setTitle(" Delete Account ", for: .normal)
        contentView.addSubview(btnDeleteUser)
        
        NSLayoutConstraint.activate([
            lblDeleteUser.topAnchor.constraint(equalTo: lineViewUserAcct.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblDeleteUser.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: widthFromPct(percent: 2)),
            lblDeleteUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthFromPct(percent: 2)),
            
            btnDeleteUser.topAnchor.constraint(equalTo: lblDeleteUser.bottomAnchor, constant: heightFromPct(percent:4)),
            btnDeleteUser.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: widthFromPct(percent: -2)),
            btnDeleteUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnDeleteUser.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -2)),
        ])
    }
    
    func manageLocationCollection(){
        print("- accessed manageLocationCollection")
  
        
    }
    func setLocationSwitchLabelText(){

        if swtchLocTrackReoccurring.isOn{
            lblLocTrackReoccurringSwitch.text = "Track Location (Once Daily): "
//            if locationFetcher.userLocationManagerAuthStatus == "Authorized Always"{
//                lblLocTrackReoccurringSwitch.text = "Track Location (Once Daily): "
//                self.locationFetcher.startMonitoringLocationChanges()
//            }
//            else if let unwp_last_date = userStore.user.last_location_date,
//                    let unwp_timezone = userStore.user.timezone {
//                if unwp_timezone != "Etc/GMT"{
//                    lblLocTrackReoccurringSwitch.text = "Track Location (\(unwp_last_date)): "
//                } else {
//                    lblLocTrackReoccurringSwitch.text = "Track Location (Restricted): "
//                }
//            } else {
//                lblLocTrackReoccurringSwitch.text = "Track Location (Restricted): "
//            }
        } else {
            lblLocTrackReoccurringSwitch.text = "Track Location (off): "
//            locationFetcher.stopMonitoringLocationChanges()
        }
    }
    
    
    func sendUpdateDictToApi(updateDict:[String:String]){
        
        print("sendUpdateDictToApi")
//        self.userStore.callUpdateUser(endPoint: .update_user_location_with_lat_lon, updateDict: updateDict) { resultString in
//            switch resultString{
//            case .success(_):
//                DispatchQueue.main.async{
//                    self.removeSpinner()
//                    self.swtchLocTrackReoccurring.isOn=true
//                    self.setLocationSwitchLabelText()
//                }
//
//                self.templateAlert(alertTitle: "Success!", alertMessage: "")
//            case let .failure(error):
//                DispatchQueue.main.async{
//                    self.removeSpinner()
//                    self.switchErrorSwitchBack()
//                    self.templateAlert(alertTitle: "Unsuccessful update", alertMessage: error.localizedDescription)
//                }
//            }
//        }
    }
    
    func switchErrorSwitchBack(){
        if self.swtchLocTrackReoccurring.isOn==true{
            self.swtchLocTrackReoccurring.isOn=false
        } else {
            self.swtchLocTrackReoccurring.isOn=true
        }
        self.setLocationSwitchLabelText()
    }
    
    
    /* Objc Methods*/
    @objc private func switchValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
//            self.showSpinner()
            manageLocationCollection()
            print("switchValueChanged")
            
        } else {
            // Are you sure alert; if yes, then sends notification to WSAPI
//            alertTurnOffLocationTrackingConfirmation()
            print("alertTurnOffLocationTrackingConfirmation")
        }
    }
    
    
    @objc func touchUpInside_btnDeleteUser(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        print("delete user api call")
        print("alertDeleteConfirmation()")
        
    }
    
    @objc func touchUpInside_btnRegisterUser(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        print("regisert user api call")

        let registerVC = RegModalVC()

        // Set the modal presentation style
        registerVC.modalPresentationStyle = .overCurrentContext
        registerVC.modalTransitionStyle = .crossDissolve

        // Present the registerVC
        self.present(registerVC, animated: true, completion: nil)
        
    }

}


class UserVcAccount: UIView {
    let stckVwUser = UIStackView()
    let stckVwUsername = UIStackView()
    let stckVwRecordCount = UIStackView()
    let lblUsername = UILabel()
    let lblUsernameFilled = UILabel()
    let lblRecordCount = UILabel()
    let lblRecordCountFilled = UILabel()
    var userStore: UserStore!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup_views()
    }
    
    func setup_views(){
        userStore = UserStore.shared
        stckVwUser.accessibilityIdentifier = "stckVwUser"
        stckVwUser.translatesAutoresizingMaskIntoConstraints=false
        
        stckVwUser.axis = .vertical
        stckVwUser.alignment = .fill
        stckVwUser.distribution = .fillEqually
        stckVwUser.spacing = 10
        
        stckVwUsername.accessibilityIdentifier = "stckVwUser"
        stckVwUsername.translatesAutoresizingMaskIntoConstraints=false
        stckVwUsername.axis = .horizontal
        stckVwUsername.alignment = .fill
        stckVwUsername.distribution = .fillEqually
        stckVwUsername.spacing = 10
        

        
        lblUsername.accessibilityIdentifier="lblUsername"
        lblUsername.text = "username"
        lblUsername.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblUsername.translatesAutoresizingMaskIntoConstraints=false
        lblUsernameFilled.accessibilityIdentifier="lblUsernameFilled"
        lblUsernameFilled.text = userStore.user.username
        
//        lblUsernameFilled.text = "userStore.user.username"
        lblUsernameFilled.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblUsernameFilled.translatesAutoresizingMaskIntoConstraints=false
        stckVwUsername.addArrangedSubview(lblUsername)
        stckVwUsername.addArrangedSubview(lblUsernameFilled)
        
        
        
        stckVwRecordCount.accessibilityIdentifier = "stckVwUser"
        stckVwRecordCount.translatesAutoresizingMaskIntoConstraints=false
        
        lblRecordCount.accessibilityIdentifier="lblRecordCount"
        lblRecordCount.text = "record count"
        lblRecordCount.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblRecordCount.translatesAutoresizingMaskIntoConstraints=false
        lblRecordCountFilled.accessibilityIdentifier="lblRecordCountFilled"
        lblRecordCountFilled.text = userStore.user.username
        lblRecordCountFilled.text = "0"
        lblRecordCountFilled.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblRecordCountFilled.backgroundColor = .brown
        lblRecordCountFilled.translatesAutoresizingMaskIntoConstraints=false
        stckVwRecordCount.addArrangedSubview(lblRecordCount)
        stckVwRecordCount.addArrangedSubview(lblRecordCountFilled)
        
        
        stckVwUser.addArrangedSubview(stckVwUsername)
        stckVwUser.addArrangedSubview(stckVwRecordCount)
        
        self.addSubview(stckVwUser)

        
        NSLayoutConstraint.activate([
            stckVwUser.topAnchor.constraint(equalTo: self.topAnchor),
            stckVwUser.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stckVwUser.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stckVwUser.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
    }
    
}

class UserVcAccount_OBE: UIView {
    let stckVwUser: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()

    let stckVwUsername: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    let lblUsername: UILabel = {
        let label = UILabel()
        label.text = "username"
        return label
    }()

    let txtUsername: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    let stckVwRecordCount: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    let lblRecordCount: UILabel = {
        let label = UILabel()
        label.text = "record count"
        return label
    }()

    let txtRecordCount: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(stckVwUser)
        stckVwUser.translatesAutoresizingMaskIntoConstraints = false
        stckVwUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stckVwUser.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stckVwUser.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        stckVwUser.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true

        stckVwUser.addArrangedSubview(stckVwUsername)
        stckVwUser.addArrangedSubview(stckVwRecordCount)

        stckVwUsername.addArrangedSubview(lblUsername)
        stckVwUsername.addArrangedSubview(txtUsername)

        stckVwRecordCount.addArrangedSubview(lblRecordCount)
        stckVwRecordCount.addArrangedSubview(txtRecordCount)
    }
}




