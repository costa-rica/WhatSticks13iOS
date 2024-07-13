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
        print("- (in sendUpdateDictToApi) sending user location to api ")
        self.userStore.callUpdateUser(endPoint: .update_user_location_with_lat_lon, updateDict: updateDict) { resultString in
            switch resultString{
            case .success(_):
                print(" (in sendUpdateDictToApi) success")
                DispatchQueue.main.async{
                    self.delegate?.removeSpinner()
                    self.swtchLocTrackReoccurring.isOn=true
                    self.setLocationSwitchLabelText()
                }
                
                self.delegate?.templateAlert(alertTitle: "Success!", alertMessage: "", backScreen: false)
                
            case let .failure(userStoreError):
                print(" (in sendUpdateDictToApi) fail")
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



class UserVcOffline: UIView {
    
    var showLine:Bool!
    let vwOfflineLine = UIView()
    
    let lblOfflineTitle = UILabel()
    let btnConnectDevice = UIButton()
    let lblDescriptionTitle = UILabel()
    let lblDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        showLine=false
        setup_UserVcOfflineViews()
    }
    // New initializer
    init(frame: CGRect, showLine: Bool) {
        self.showLine = showLine
        super.init(frame: frame)
        setup_UserVcOfflineViews_lineOption()
        setup_UserVcOfflineViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_UserVcOfflineViews()
    }
    
    private func setup_UserVcOfflineViews_lineOption(){
        vwOfflineLine.accessibilityIdentifier = "vwOfflineLine"
        vwOfflineLine.translatesAutoresizingMaskIntoConstraints = false
        vwOfflineLine.backgroundColor = UIColor(named: "lineColor")
        self.addSubview(vwOfflineLine)
        NSLayoutConstraint.activate([
            vwOfflineLine.topAnchor.constraint(equalTo: self.topAnchor),
            vwOfflineLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vwOfflineLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vwOfflineLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    private func setup_UserVcOfflineViews(){
        lblOfflineTitle.accessibilityIdentifier="lblOfflineTitle"
        lblOfflineTitle.translatesAutoresizingMaskIntoConstraints = false
        lblOfflineTitle.text = "Currently offline"
        lblOfflineTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblOfflineTitle.numberOfLines=0
        self.addSubview(lblOfflineTitle)
        
        btnConnectDevice.accessibilityIdentifier = "btnConnectDevice"
        btnConnectDevice.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnConnectDevice)
        btnConnectDevice.setTitle("Connect device", for: .normal)
        btnConnectDevice.layer.borderColor = UIColor.systemBlue.cgColor
        btnConnectDevice.layer.borderWidth = 2
        btnConnectDevice.backgroundColor = .systemBlue
        btnConnectDevice.layer.cornerRadius = 10
        
        lblDescriptionTitle.accessibilityIdentifier="lblDescriptionTitle"
        lblDescriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        lblDescriptionTitle.text = "Why do I want to connect device?"
        lblDescriptionTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblDescriptionTitle.numberOfLines=0
        self.addSubview(lblDescriptionTitle)
        
        lblDescription.accessibilityIdentifier="lblDescription"
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.text = "If you would like to see your dashboard you will need to connect your device so your data can be processed."
        lblDescription.numberOfLines=0
        self.addSubview(lblDescription)
        
        if showLine{
            lblOfflineTitle.topAnchor.constraint(equalTo: vwOfflineLine.bottomAnchor, constant: heightFromPct(percent: 5)).isActive=true
        } else {
            lblOfflineTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 5)).isActive=true
        }
        
        NSLayoutConstraint.activate([
//            lblOfflineTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 5)),
            lblOfflineTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblOfflineTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            btnConnectDevice.topAnchor.constraint(equalTo: lblOfflineTitle.bottomAnchor, constant: heightFromPct(percent: 5)),
            btnConnectDevice.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            btnConnectDevice.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            lblDescriptionTitle.topAnchor.constraint(equalTo: btnConnectDevice.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblDescriptionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblDescriptionTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            lblDescription.topAnchor.constraint(equalTo: lblDescriptionTitle.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lblDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: heightFromPct(percent: -2))
            
        ])
        
    }
    
}


class UserVcUserStatusView: UIView {

    var showLine:Bool!
    let vwUserStatusLine = UIView()
    
    var userStore: UserStore!
    let lblTitleUserStatus = UILabel()

    let stckVwUser = UIStackView()

    let stckVwUsername = UIStackView()
    let lblUsername = UILabel()
    let btnUsernameFilled = UIButton()
    
    let stckVwRecordCount = UIStackView()
    let lblRecordCount = UILabel()
    let btnRecordCountFilled = UIButton()
    
    var constraints_NO_VwRegisterButton = [NSLayoutConstraint]()
    
    let vwRegisterButton = UserVcRegisterButton()
    var constraints_YES_VwRegisterButton = [NSLayoutConstraint]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        self.showLine = false
        setup_UserVcAccountView()
    }
    init(frame: CGRect, showLine: Bool) {
        self.showLine = showLine
        super.init(frame: frame)
        setup_UserVcAccountView_lineOption()
        setup_UserVcAccountView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_UserVcAccountView()
    }
    
    private func setup_UserVcAccountView_lineOption(){
        vwUserStatusLine.accessibilityIdentifier = "vwUserStatusLine"
        vwUserStatusLine.translatesAutoresizingMaskIntoConstraints = false
        vwUserStatusLine.backgroundColor = UIColor(named: "lineColor")
        self.addSubview(vwUserStatusLine)
        NSLayoutConstraint.activate([
            vwUserStatusLine.topAnchor.constraint(equalTo: self.topAnchor),
            vwUserStatusLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vwUserStatusLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vwUserStatusLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    

    private func setup_UserVcAccountView(){
        userStore = UserStore.shared

        lblTitleUserStatus.accessibilityIdentifier="lblTitleUserStatus"
        lblTitleUserStatus.text = "Current account status"
        lblTitleUserStatus.translatesAutoresizingMaskIntoConstraints=false
        lblTitleUserStatus.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblTitleUserStatus.numberOfLines = 0
        self.addSubview(lblTitleUserStatus)

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
        stckVwUsername.distribution = .fill
        stckVwUsername.spacing = 10

        stckVwRecordCount.accessibilityIdentifier = "stckVwRecordCount"
        stckVwRecordCount.translatesAutoresizingMaskIntoConstraints=false
        stckVwRecordCount.axis = .horizontal
        stckVwRecordCount.alignment = .fill
        stckVwRecordCount.distribution = .fill
        stckVwRecordCount.spacing = 10

        lblUsername.accessibilityIdentifier="lblUsername"
        lblUsername.text = "username"
        lblUsername.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblUsername.translatesAutoresizingMaskIntoConstraints=false
        lblUsername.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        /* there is also setContentCompressionResistancePriority */

        btnUsernameFilled.accessibilityIdentifier="btnUsernameFilled"
        btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
        if let font = UIFont(name: "ArialRoundedMTBold", size: 17) {
            btnUsernameFilled.titleLabel?.font = font
        }
        btnUsernameFilled.backgroundColor = UIColor(named: "ColorRow3Textfields")
        btnUsernameFilled.setTitleColor(UIColor(named: "lineColor"), for: .normal)
        btnUsernameFilled.layer.borderWidth = 1
        btnUsernameFilled.layer.cornerRadius = 5
        btnUsernameFilled.translatesAutoresizingMaskIntoConstraints = false
        btnUsernameFilled.accessibilityIdentifier="btnUsernameFilled"

        stckVwUsername.addArrangedSubview(lblUsername)
        stckVwUsername.addArrangedSubview(btnUsernameFilled)

        stckVwRecordCount.accessibilityIdentifier = "stckVwUser"
        stckVwRecordCount.translatesAutoresizingMaskIntoConstraints=false

        lblRecordCount.accessibilityIdentifier="lblRecordCount"
        lblRecordCount.text = "record count"
        lblRecordCount.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblRecordCount.translatesAutoresizingMaskIntoConstraints=false
        lblRecordCount.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)


        btnRecordCountFilled.accessibilityIdentifier="btnRecordCountFilled"
        btnRecordCountFilled.setTitle("0", for: .normal)
        if let font = UIFont(name: "ArialRoundedMTBold", size: 17) {
            btnRecordCountFilled.titleLabel?.font = font
        }
        btnRecordCountFilled.setTitleColor(UIColor(named: "lineColor"), for: .normal)
        btnRecordCountFilled.backgroundColor = UIColor(named: "ColorRow3Textfields")
        btnRecordCountFilled.layer.borderWidth = 1
        btnRecordCountFilled.layer.cornerRadius = 5
        btnRecordCountFilled.translatesAutoresizingMaskIntoConstraints = false
        btnRecordCountFilled.accessibilityIdentifier="btnRecordCountFilled"

        stckVwRecordCount.addArrangedSubview(lblRecordCount)
        stckVwRecordCount.addArrangedSubview(btnRecordCountFilled)

        stckVwUser.addArrangedSubview(stckVwUsername)
        stckVwUser.addArrangedSubview(stckVwRecordCount)

        self.addSubview(stckVwUser)

        
        if showLine{
            lblTitleUserStatus.topAnchor.constraint(equalTo: vwUserStatusLine.bottomAnchor, constant: heightFromPct(percent: 5)).isActive=true
        } else {
            lblTitleUserStatus.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 5)).isActive=true
        }
        
        
        NSLayoutConstraint.activate([

//            lblTitleUserStatus.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 5)),
            lblTitleUserStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: 2)),
            lblTitleUserStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),


            stckVwUser.topAnchor.constraint(equalTo: lblTitleUserStatus.bottomAnchor,constant: heightFromPct(percent: 2)),
            stckVwUser.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            stckVwUser.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stckVwUser.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            btnUsernameFilled.widthAnchor.constraint(lessThanOrEqualTo: btnRecordCountFilled.widthAnchor)
            ])
        
        
        constraints_NO_VwRegisterButton = [
            stckVwUser.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        constraints_YES_VwRegisterButton = [

        ]
        

        
        
    }
    
    
    

}


class UserVcRegisterButton: UIView {

    
    let lblWhyUsernameTitle = UILabel()
    let lblWhyUsernameDescription = UILabel()
    
    let btnRegister = UIButton()
    
    let lblWhyRegisterTitle = UILabel()
    let lblWhyRegisterDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        setup_UserVcRegisterButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup_UserVcRegisterButton()
    }
    
    
    private func setup_UserVcRegisterButtonViewDisclaimer(){
        lblWhyUsernameTitle.accessibilityIdentifier="lblWhyUsernameTitle"
        lblWhyUsernameTitle.translatesAutoresizingMaskIntoConstraints = false
        lblWhyUsernameTitle.text = "Why do I have a username?"
        lblWhyUsernameTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblWhyUsernameTitle.numberOfLines=0
        self.addSubview(lblWhyUsernameTitle)
        
        lblWhyUsernameDescription.accessibilityIdentifier="lblWhyUsernameDescription"
        lblWhyUsernameDescription.translatesAutoresizingMaskIntoConstraints = false
        lblWhyUsernameDescription.text = "This ID is used to keep track of the analyzed data. It does not have any personal information."
        lblWhyUsernameDescription.numberOfLines=0
        self.addSubview(lblWhyUsernameDescription)
        NSLayoutConstraint.activate([
            lblWhyUsernameTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 5)),
            lblWhyUsernameTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblWhyUsernameTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            lblWhyUsernameDescription.topAnchor.constraint(equalTo: lblWhyUsernameTitle.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblWhyUsernameDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblWhyUsernameDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            ])
    }
    
    private func setup_UserVcRegisterButton(){

        btnRegister.accessibilityIdentifier = "btnRegister"
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnRegister)
        btnRegister.setTitle("Register", for: .normal)
        btnRegister.layer.borderColor = UIColor.systemBlue.cgColor
        btnRegister.layer.borderWidth = 2
        btnRegister.backgroundColor = .systemBlue
        btnRegister.layer.cornerRadius = 10
        
        lblWhyRegisterTitle.accessibilityIdentifier="lblWhyRegisterTitle"
        lblWhyRegisterTitle.translatesAutoresizingMaskIntoConstraints = false
        lblWhyRegisterTitle.text = "Why Register?"
        lblWhyRegisterTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblWhyRegisterTitle.numberOfLines=0
        self.addSubview(lblWhyRegisterTitle)
        
        lblWhyRegisterDescription.accessibilityIdentifier="lblWhyRegisterDescription"
        lblWhyRegisterDescription.translatesAutoresizingMaskIntoConstraints = false
        lblWhyRegisterDescription.text = "Creating an account will allow you to access your user page on the what-sticks.com website where you can download files with the daily values for each variable used to calculate your correlations."
        lblWhyRegisterDescription.numberOfLines=0
        self.addSubview(lblWhyRegisterDescription)
        
        NSLayoutConstraint.activate([

            btnRegister.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 5)),
            btnRegister.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            btnRegister.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            lblWhyRegisterTitle.topAnchor.constraint(equalTo: btnRegister.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblWhyRegisterTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblWhyRegisterTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            lblWhyRegisterDescription.topAnchor.constraint(equalTo: lblWhyRegisterTitle.bottomAnchor, constant: heightFromPct(percent: 5)),
            lblWhyRegisterDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lblWhyRegisterDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lblWhyRegisterDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: heightFromPct(percent: -2))
            
        ])
        
    }
    
}





