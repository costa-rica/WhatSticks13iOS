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
//        print("--- we should see something in UserVcFindAppleHealthPermissionsView <-----")
//        self.backgroundColor = .green
        lblTitle.accessibilityIdentifier="lblTitle-UserVcFindAppleHealthPermissionsView"
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.text = "Apple Health Permissions"
        lblTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblTitle.numberOfLines=0
        self.addSubview(lblTitle)
//        lblTitle.backgroundColor = .colorRow1
        
        lblDescription.accessibilityIdentifier="lblDescription-UserVcFindAppleHealthPermissionsView"
        lblDescription.translatesAutoresizingMaskIntoConstraints=false
        let text_for_message = "Go to Settings > Health > Data Access & Devices > WhatSticks to grant access.\n\nFor this app to work properly please make sure all data types are allowed."
        lblDescription.text = text_for_message
        lblDescription.numberOfLines = 0
        self.addSubview(lblDescription)
//        lblDescription.backgroundColor = .colorRow2
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
            lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            lblDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -5))
        ])
    }
    
}


class UserVcLocationDayWeather: UIView {
    
    weak var delegate: UserVcLocationDayWeatherDelegate?
    
    var userStore: UserStore!
    var locationFetcher: LocationFetcher!
    let lblLocationDayWeatherTitle = UILabel()
    let lblLocationDayWeatherDetails = UILabel()
    // old name: LocationDayWeatherSwitch
    let stckVwLocTrackReoccurring=UIStackView()
    let lblLocTrackReoccurringSwitch=UILabel()
    let swtchLocTrackReoccurring = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        setup_views()
        print("- in UserVcLocationDayWeather")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_views()
    }
    
    
    private func setup_views(){
        
        userStore = UserStore.shared
        locationFetcher = LocationFetcher.shared
        lblLocationDayWeatherTitle.accessibilityIdentifier="lblLocationDayWeatherTitle"
        lblLocationDayWeatherTitle.text = "Location Weather Tracking"
        lblLocationDayWeatherTitle.translatesAutoresizingMaskIntoConstraints=false
        lblLocationDayWeatherTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblLocationDayWeatherTitle.numberOfLines = 0
        self.addSubview(lblLocationDayWeatherTitle)
        
        lblLocationDayWeatherDetails.accessibilityIdentifier="lblLocationDayWeatherDetails"
        lblLocationDayWeatherDetails.text = "Allow What Sticks (WS) to collect your location to provide weather and timezone calculations for impacts on sleep and exercise. \n\nTurning this on will allow WS to collect your location daily."
        lblLocationDayWeatherDetails.translatesAutoresizingMaskIntoConstraints=false
        lblLocationDayWeatherDetails.numberOfLines = 0
        self.addSubview(lblLocationDayWeatherDetails)
        
        stckVwLocTrackReoccurring.accessibilityIdentifier="stckVwLocationDayWeather"
        stckVwLocTrackReoccurring.translatesAutoresizingMaskIntoConstraints=false
        stckVwLocTrackReoccurring.spacing = 5
        stckVwLocTrackReoccurring.axis = .horizontal
        self.addSubview(stckVwLocTrackReoccurring)
        
        lblLocTrackReoccurringSwitch.accessibilityIdentifier="lblLocationDayWeatherSwitch"
        lblLocTrackReoccurringSwitch.translatesAutoresizingMaskIntoConstraints=false
        stckVwLocTrackReoccurring.addArrangedSubview(lblLocTrackReoccurringSwitch)
        
        swtchLocTrackReoccurring.accessibilityIdentifier = "swtchLocationDayWeather"
//        swtchLocTrackReoccurring.translatesAutoresizingMaskIntoConstraints = false
        swtchLocTrackReoccurring.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        stckVwLocTrackReoccurring.addArrangedSubview(swtchLocTrackReoccurring)
        
        
//        setLocationSwitchLabelText()
        
        NSLayoutConstraint.activate([
            lblLocationDayWeatherTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 2)),
            lblLocationDayWeatherTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lblLocationDayWeatherTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            lblLocationDayWeatherDetails.topAnchor.constraint(equalTo: lblLocationDayWeatherTitle.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblLocationDayWeatherDetails.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lblLocationDayWeatherDetails.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            stckVwLocTrackReoccurring.topAnchor.constraint(equalTo: lblLocationDayWeatherDetails.bottomAnchor, constant: heightFromPct(percent: 2)),
            stckVwLocTrackReoccurring.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: widthFromPct(percent: -2)),
            stckVwLocTrackReoccurring.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -2))
        ])
    }

    private func manageLocationCollection(){
        print("- accessed manageLocationCollection")
        if locationFetcher.userLocationManagerAuthStatus == "Authorized Always"{
            locationFetcher.fetchLocation { locationExists in
                if locationExists{
                    if let unwp_lat = self.locationFetcher.currentLocation?.latitude,
                       let unwp_lon = self.locationFetcher.currentLocation?.longitude{
                        let updateDict = ["latitude":String(unwp_lat),"longitude":String(unwp_lon),"location_permission_device":"True","location_permission_ws":"True"]
                        print("-Scenario 1: locationExists and there are longitude and latitude; status = Authorized Always")
                        self.sendUpdateDictToApi(updateDict: updateDict)// <-- start print statements here
                    }
                    else {
                        print("-Scenario 2: locationExists BUT there are no longitude and latitude; status = Authorized Always ")
                        let updateDict = ["location_permission_device":"True","location_permission_ws":"True"]
                        self.sendUpdateDictToApi(updateDict: updateDict)
                        
                    }
                }
                else {
                    print("-Scenario 3: NO locationExists; status = Authorized Always")
                    let updateDict = ["location_permission_device":"True","location_permission_ws":"True"]
                    self.sendUpdateDictToApi(updateDict: updateDict)
                }
            }
        }
        else if locationFetcher.userLocationManagerAuthStatus == "Authorized When In Use" {
            locationFetcher.fetchLocation { locationExists in
                if locationExists{
                    if let unwp_lat = self.locationFetcher.currentLocation?.latitude,
                       let unwp_lon = self.locationFetcher.currentLocation?.longitude{
                        let updateDict = ["latitude":String(unwp_lat),"longitude":String(unwp_lon),"location_permission_device":"True","location_permission_ws":"False"]
                        print("-Scenario 4: NO locationExists; status = Authorized When In Use")
                        self.sendUpdateDictToApi(updateDict: updateDict)
                    }
                }
            }
        }
        
        else {
            self.delegate?.removeSpinner()
            self.swtchLocTrackReoccurring.isOn=false
            // Set Location Label
            self.setLocationSwitchLabelText()
            self.delegate?.templateAlert(alertTitle: "", alertMessage: "For better calculations go to Setting and set Location permissions to Always", backScreen: false)
        }
        
    }
    func setLocationSwitchLabelText(){
        print("- in setLocationSwitchLabelText")       
        
        guard let location_permission_device = userStore.user.location_permission_device,
              let location_permission_ws = userStore.user.location_permission_ws
        else {
            print("* No userStore.user.location_permission_device")
            return
        }

        print("--- location_permission_device: \(location_permission_device)")
        print("--- location_permission_ws: \(location_permission_ws)")


        swtchLocTrackReoccurring.isOn = location_permission_ws
        if swtchLocTrackReoccurring.isOn{
            if locationFetcher.userLocationManagerAuthStatus == "Authorized Always"{
                lblLocTrackReoccurringSwitch.text = "Track Location (Once Daily): "
                self.locationFetcher.startMonitoringLocationChanges()
            }
            else if let unwp_last_date = userStore.user.last_location_date,
                    let unwp_timezone = userStore.user.timezone {
                if unwp_timezone != "Etc/GMT"{
                    lblLocTrackReoccurringSwitch.text = "Track Location (\(unwp_last_date)): "
                } else {
                    lblLocTrackReoccurringSwitch.text = "Track Location (Restricted): "
                }
            } else {
                lblLocTrackReoccurringSwitch.text = "Track Location (Restricted): "
            }
        } else {
            lblLocTrackReoccurringSwitch.text = "Track Location (off): "
            locationFetcher.stopMonitoringLocationChanges()
        }
    }
    
    private func sendUpdateDictToApi(updateDict:[String:String]){
        self.userStore.callUpdateUser(endPoint: .update_user_location_with_lat_lon, updateDict: updateDict) { resultString in
            switch resultString{
            case .success(_):
                DispatchQueue.main.async{
                    self.delegate?.removeSpinner()
                    self.swtchLocTrackReoccurring.isOn=true
                    self.setLocationSwitchLabelText()
                }
                
                self.delegate?.templateAlert(alertTitle: "Success!", alertMessage: "", backScreen: false)
                
            case let .failure(userStoreError):
                switch userStoreError {
                case .failedToReceiveExpectedResponse:
                    DispatchQueue.main.async{
                        self.delegate?.removeSpinner()
                        self.switchErrorSwitchBack()
                        self.delegate?.templateAlert(alertTitle: "Unexpected response", alertMessage: "Restart the app",backScreen: false)
                    }
                    print("- UserVcLocationDayWeather failure ok ")
                default:
                    DispatchQueue.main.async{
                        self.delegate?.removeSpinner()
                        self.switchErrorSwitchBack()
                        self.delegate?.templateAlert(alertTitle: "Unsuccessful update", alertMessage: userStoreError.localizedDescription,backScreen: false)
                    }
                    print("- UserVcLocationDayWeather failure ok ")
                }
                print("- step 2")
            }
            print("- step 3")
        }
        print("- step 4")
    }
    
    private func switchErrorSwitchBack(){
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
            self.delegate?.showSpinner()
            manageLocationCollection()
            
        } else {
            // Are you sure alert; if yes, then sends notification to WSAPI
            alertTurnOffLocationTrackingConfirmation()
        }
    }
    
    // Used for delete user
    @objc func alertTurnOffLocationTrackingConfirmation() {
        let alertController = UIAlertController(title: "Are you sure?", message: "Turning off location tracking will reduce accuracy.", preferredStyle: .alert)
        // 'Yes' action
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            // Handle the 'Yes' action here
            self?.delegate?.showSpinner()
            self?.locationFetcher.stopMonitoringLocationChanges()
            
            // Send API permission to track off
            var updateDict = ["location_permission_device":"False","location_permission_ws":"False"]
            if self!.locationFetcher.userLocationManagerAuthStatus == "Authorized Always" || self!.locationFetcher.userLocationManagerAuthStatus == "Authorized When In Use" ||  self!.locationFetcher.userLocationManagerAuthStatus == "Restricted"{
                updateDict["location_permission_device"]="True"
            }
            // in case we need it here is a sampel of user_locations
            // user locations: [["20240708-1325", "37.785834", "-122.406417"], ["20240709-1345", "37.785834", "-122.406417"]]
            self!.userStore.callUpdateUser(endPoint: .update_user_location_with_lat_lon, updateDict: updateDict) { resultString in
                switch resultString{
                case .success(_):
                    print("-successfully updated")
                    DispatchQueue.main.async{
                        self?.delegate?.removeSpinner()
                        
                        self?.swtchLocTrackReoccurring.isOn=false
                        // Set Location Label
                        let initialSwitchStateText = (self?.swtchLocTrackReoccurring.isOn)! ? "on" : "off"
                        self?.lblLocTrackReoccurringSwitch.text = "Track Location (\(initialSwitchStateText)): "
                    }
                case .failure(_):
                    print("-failed to update user status")
                    DispatchQueue.main.async{
                        self?.delegate?.removeSpinner()
                        
                        self?.delegate?.templateAlert(alertTitle: "Unsuccessful update", alertMessage: "Try again or email nrodrig1@gmail.com.", backScreen: false)
                        
                        self?.swtchLocTrackReoccurring.isOn=true
                        // Set Location Label
                        let initialSwitchStateText = (self?.swtchLocTrackReoccurring.isOn)! ? "on" : "off"
                        self?.lblLocTrackReoccurringSwitch.text = "Track Location (\(initialSwitchStateText)): "
                    }

                }
            }
        }
        // 'No' action
        let noAction = UIAlertAction(title: "No", style: .cancel) {[weak self] _ in
            self?.swtchLocTrackReoccurring.isOn=true
            self?.setLocationSwitchLabelText()
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
//        present(alertController, animated: true, completion: nil)
        self.delegate?.presentAlertController(alertController)
    }
    
}

// Protocol definition
protocol UserVcLocationDayWeatherDelegate: AnyObject {
    //    func didUpdateWeatherInfo(_ weatherInfo: String)
    func removeSpinner()
    func showSpinner()
    func templateAlert(alertTitle:String,alertMessage: String,  backScreen: Bool)
    func presentAlertController(_ alertController: UIAlertController)
}






/* Probably Delete when ready */

class TestViewWithSwitch: UIView {
    let label1 = UILabel()
    let label2 = UILabel()
    let weatherSwitch = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        weatherSwitch.translatesAutoresizingMaskIntoConstraints = false
        weatherSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        self.addSubview(weatherSwitch)
        NSLayoutConstraint.activate([
            weatherSwitch.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        print("Switch value changed: \(sender.isOn)")
    }
}




//
//class UserVcAccountView: UIView {
//    let lblRegisterUser = UILabel()
//    let stckVwUser = UIStackView()
//    let stckVwUsername = UIStackView()
//    let stckVwRecordCount = UIStackView()
//    let lblUsername = UILabel()
////    let lblUsernameFilled = UILabel()
//    let btnUsernameFilled = UIButton()
//    let lblRecordCount = UILabel()
//    let btnRecordCountFilled = UIButton()
////    let lblRecordCountFilled = UILabel()
//    var userStore: UserStore!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        // This triggers as soon as the app starts
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        
//        setup_views()
//    }
//    
//    func setup_views(){
//        userStore = UserStore.shared
//        
//        
//        lblRegisterUser.accessibilityIdentifier="lblRegisterUser"
//        lblRegisterUser.text = "Register an account"
//        lblRegisterUser.translatesAutoresizingMaskIntoConstraints=false
//        lblRegisterUser.font = UIFont(name: "ArialRoundedMTBold", size: 25)
//        lblRegisterUser.numberOfLines = 0
//        self.addSubview(lblRegisterUser)
//        
//        
//        
//        stckVwUser.accessibilityIdentifier = "stckVwUser"
//        stckVwUser.translatesAutoresizingMaskIntoConstraints=false
//        
//        stckVwUser.axis = .vertical
//        stckVwUser.alignment = .fill
//        stckVwUser.distribution = .fillEqually
//        stckVwUser.spacing = 10
//        
//        stckVwUsername.accessibilityIdentifier = "stckVwUser"
//        stckVwUsername.translatesAutoresizingMaskIntoConstraints=false
//        stckVwUsername.axis = .horizontal
//        stckVwUsername.alignment = .fill
//        stckVwUsername.distribution = .fill
//        stckVwUsername.spacing = 10
//        
//        stckVwRecordCount.accessibilityIdentifier = "stckVwRecordCount"
//        stckVwRecordCount.translatesAutoresizingMaskIntoConstraints=false
//        stckVwRecordCount.axis = .horizontal
//        stckVwRecordCount.alignment = .fill
//        stckVwRecordCount.distribution = .fill
//        stckVwRecordCount.spacing = 10
//        
//        
//        lblUsername.accessibilityIdentifier="lblUsername"
//        lblUsername.text = "username"
//        lblUsername.font = UIFont(name: "ArialRoundedMTBold", size: 15)
//        lblUsername.translatesAutoresizingMaskIntoConstraints=false
//        lblUsername.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
//        /* there is also setContentCompressionResistancePriority */
//        
//        btnUsernameFilled.accessibilityIdentifier="btnUsernameFilled"
//        btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
//        if let font = UIFont(name: "ArialRoundedMTBold", size: 17) {
//            btnUsernameFilled.titleLabel?.font = font
//        }
//        btnUsernameFilled.backgroundColor = UIColor(named: "ColorRow3Textfields")
//        btnUsernameFilled.setTitleColor(UIColor(named: "lineColor"), for: .normal)
//        btnUsernameFilled.layer.borderWidth = 1
//        btnUsernameFilled.layer.cornerRadius = 5
//        btnUsernameFilled.translatesAutoresizingMaskIntoConstraints = false
//        btnUsernameFilled.accessibilityIdentifier="btnUsernameFilled"
//        
//        
//        stckVwUsername.addArrangedSubview(lblUsername)
//        stckVwUsername.addArrangedSubview(btnUsernameFilled)
//        
//        
//        
//        stckVwRecordCount.accessibilityIdentifier = "stckVwUser"
//        stckVwRecordCount.translatesAutoresizingMaskIntoConstraints=false
//        
//        lblRecordCount.accessibilityIdentifier="lblRecordCount"
//        lblRecordCount.text = "record count"
//        lblRecordCount.font = UIFont(name: "ArialRoundedMTBold", size: 15)
//        lblRecordCount.translatesAutoresizingMaskIntoConstraints=false
//        lblRecordCount.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
//        
//        
//        btnRecordCountFilled.accessibilityIdentifier="btnRecordCountFilled"
//        btnRecordCountFilled.setTitle("0", for: .normal)
//        if let font = UIFont(name: "ArialRoundedMTBold", size: 17) {
//            btnRecordCountFilled.titleLabel?.font = font
//        }
//        btnRecordCountFilled.setTitleColor(UIColor(named: "lineColor"), for: .normal)
//        btnRecordCountFilled.backgroundColor = UIColor(named: "ColorRow3Textfields")
//        btnRecordCountFilled.layer.borderWidth = 1
//        btnRecordCountFilled.layer.cornerRadius = 5
//        btnRecordCountFilled.translatesAutoresizingMaskIntoConstraints = false
//        btnRecordCountFilled.accessibilityIdentifier="btnRecordCountFilled"
//        
//
//        stckVwRecordCount.addArrangedSubview(lblRecordCount)
//        stckVwRecordCount.addArrangedSubview(btnRecordCountFilled)
//        
//        
//        stckVwUser.addArrangedSubview(stckVwUsername)
//        stckVwUser.addArrangedSubview(stckVwRecordCount)
//        
//        self.addSubview(stckVwUser)
//
//        
//        
//        NSLayoutConstraint.activate([
//            
//            lblRegisterUser.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 5)),
//            lblRegisterUser.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: 2)),
//            lblRegisterUser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
//            
//            
//            stckVwUser.topAnchor.constraint(equalTo: self.topAnchor),
//            stckVwUser.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            stckVwUser.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            stckVwUser.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            
//            btnUsernameFilled.widthAnchor.constraint(lessThanOrEqualTo: btnRecordCountFilled.widthAnchor)
//            ])
//        
//
//        
//    }
//    
//}
//
//class UserVcCurrentlyOfflineView: UIView {
//    
//    var userStore: UserStore!
//    let vwLine = UIView()
//    let lblTitle = UILabel()
//    let lblDescription = UILabel()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        // This triggers as soon as the app starts
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup_labels()
//    }
//    func setup_labels(){
// 
//        setup_vwLine()
//        lblTitle.accessibilityIdentifier="lblTitle"
//        lblTitle.translatesAutoresizingMaskIntoConstraints = false
//        lblTitle.text = "Apple Health Permissions"
//        lblTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
//        lblTitle.numberOfLines=0
//        self.addSubview(lblTitle)
//        
//        lblDescription.accessibilityIdentifier="lblDescription"
//        lblDescription.translatesAutoresizingMaskIntoConstraints=false
//        let text_for_message = "Go to Settings > Health > Data Access & Devices > WhatSticks to grant access.\n\nFor this app to work properly please make sure all data types are allowed."
//        lblDescription.text = text_for_message
//        lblDescription.numberOfLines = 0
//        self.addSubview(lblDescription)
//        
//        NSLayoutConstraint.activate([
//            lblTitle.topAnchor.constraint(equalTo: vwLine.bottomAnchor, constant: heightFromPct(percent: 3)),
//            lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
//            lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
//            
//            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: heightFromPct(percent: 5)),
//            lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
//            lblDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
//        ])
//    }
//    
//    func setup_vwLine(){
//        vwLine.backgroundColor = UIColor(named: "lineColor")
//        self.addSubview(vwLine)
//        vwLine.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            vwLine.bottomAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 5)),
//            vwLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            vwLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            vwLine.heightAnchor.constraint(equalToConstant: 1), // Set line thickness
//            ])
//    }
//    
//}



