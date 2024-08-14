//
//  ManageDataVC.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 14/07/2024.
//

import UIKit

class ManageDataVC: TemplateVC {
    var userStore: UserStore!
    var appleHealthDataFetcher:AppleHealthDataFetcher!
    var healthDataStore: HealthDataStore!
    let lblManageDataVcTitle = UILabel()
    
    let stckVwManageData = UIStackView()

    let stckVwRecordCount = UIStackView()
    let lblRecordCountFilled = UILabel()
    let btnRecordCountFilled = UIButton()
    
    let stckVwEarliestDate = UIStackView()
    let lblEarliestDateFilled = UILabel()
    let btnEarliestDateFilled = UIButton()

    let datePicker = UIDatePicker()
    var dtUserHistory:Date?
    
    let btnConnectData = UIButton()
    
    var arryStepsDict = [AppleHealthQuantityCategory](){
        didSet{
            actionGetSleepData()
        }
    }
    var arrySleepDict = [AppleHealthQuantityCategory](){
        didSet{
//            arrySleepDict=[AppleHealthQuantityCategory]()
            actionGetHeartRateData()
        }
    }
    var arryHeartRateDict = [AppleHealthQuantityCategory](){
        didSet{
            actionGetExerciseTimeData()
        }
    }
    var arryExerciseTimeDict = [AppleHealthQuantityCategory](){
        didSet{
            //            necessaryDataCollected()
            actionGetWorkoutData()
        }
    }
    var arryWorkoutDict = [AppleHealthWorkout](){
        didSet{
            sendAppleWorkouts()
        }
    }
    
    var strStatusMessage=String()
    
    override func viewDidLoad() {
        userStore = UserStore.shared
        appleHealthDataFetcher = AppleHealthDataFetcher.shared
        healthDataStore = HealthDataStore.shared
        appleHealthDataFetcher.authorizeHealthKit()
        
        setup_TopSafeBar()
        setup_ManageDataVcTitle()
        setup_UserVcAccountView()
//        setupDatePicker()
//        setup_btnConnectData()
        view.backgroundColor = UIColor(named: "ColorAppBackground")
    }
    
    private func setup_ManageDataVcTitle(){
        lblManageDataVcTitle.accessibilityIdentifier="lblManageDataVcTitle"
        lblManageDataVcTitle.translatesAutoresizingMaskIntoConstraints = false
        lblManageDataVcTitle.text = "Manage Data"
        lblManageDataVcTitle.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        lblManageDataVcTitle.numberOfLines=0
        view.addSubview(lblManageDataVcTitle)
                
        NSLayoutConstraint.activate([
            lblManageDataVcTitle.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor, constant: heightFromPct(percent: 3)),
            lblManageDataVcTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblManageDataVcTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),

        ])
    }
    
    private func setup_UserVcAccountView(){
        userStore = UserStore.shared

        stckVwManageData.accessibilityIdentifier = "stckVwManageData"
        stckVwManageData.translatesAutoresizingMaskIntoConstraints=false

        stckVwManageData.axis = .vertical
        stckVwManageData.alignment = .fill
        stckVwManageData.distribution = .fillEqually
        stckVwManageData.spacing = 10

        stckVwRecordCount.accessibilityIdentifier = "stckVwRecordCount"
        stckVwRecordCount.translatesAutoresizingMaskIntoConstraints=false
        stckVwRecordCount.axis = .horizontal
        stckVwRecordCount.alignment = .fill
        stckVwRecordCount.distribution = .fill
        stckVwRecordCount.spacing = 10

        stckVwEarliestDate.accessibilityIdentifier = "stckVwEarliestDate"
        stckVwEarliestDate.translatesAutoresizingMaskIntoConstraints=false
        stckVwEarliestDate.axis = .horizontal
        stckVwEarliestDate.alignment = .fill
        stckVwEarliestDate.distribution = .fill
        stckVwEarliestDate.spacing = 10

        lblRecordCountFilled.accessibilityIdentifier="lblRecordCountFilled"
        lblRecordCountFilled.text = "Record count:"
        lblRecordCountFilled.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblRecordCountFilled.translatesAutoresizingMaskIntoConstraints=false
        lblRecordCountFilled.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        /* there is also setContentCompressionResistancePriority */

        btnRecordCountFilled.accessibilityIdentifier="btnRecordCountFilled"
        if let font = UIFont(name: "ArialRoundedMTBold", size: 17) {
            btnRecordCountFilled.titleLabel?.font = font
        }
        btnRecordCountFilled.backgroundColor = UIColor(named: "ColorRow3Textfields")
        btnRecordCountFilled.setTitleColor(UIColor(named: "lineColor"), for: .normal)
        btnRecordCountFilled.layer.borderWidth = 1
        btnRecordCountFilled.layer.cornerRadius = 5
        btnRecordCountFilled.translatesAutoresizingMaskIntoConstraints = false
//        btnRecordCountFilled.accessibilityIdentifier="btnRecordCountFilled"

        stckVwRecordCount.addArrangedSubview(lblRecordCountFilled)
        stckVwRecordCount.addArrangedSubview(btnRecordCountFilled)

        stckVwEarliestDate.accessibilityIdentifier = "stckVwEarliestDate"
        stckVwEarliestDate.translatesAutoresizingMaskIntoConstraints=false

        lblEarliestDateFilled.accessibilityIdentifier="lblEarliestDateFilled"
        lblEarliestDateFilled.text = "Earliest date:"
        lblEarliestDateFilled.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblEarliestDateFilled.translatesAutoresizingMaskIntoConstraints=false
        lblEarliestDateFilled.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)

        btnEarliestDateFilled.accessibilityIdentifier="btnEarliestDateFilled"
//        btnRecordCountFilled.setTitle("0", for: .normal)
        if let font = UIFont(name: "ArialRoundedMTBold", size: 17) {
            btnEarliestDateFilled.titleLabel?.font = font
        }
        btnEarliestDateFilled.setTitleColor(UIColor(named: "lineColor"), for: .normal)
        btnEarliestDateFilled.backgroundColor = UIColor(named: "ColorRow3Textfields")
        btnEarliestDateFilled.layer.borderWidth = 1
        btnEarliestDateFilled.layer.cornerRadius = 5
        btnEarliestDateFilled.translatesAutoresizingMaskIntoConstraints = false
//        btnEarliestDateFilled.accessibilityIdentifier="btnRecordCountFilled"

        stckVwEarliestDate.addArrangedSubview(lblEarliestDateFilled)
        stckVwEarliestDate.addArrangedSubview(btnEarliestDateFilled)

        stckVwManageData.addArrangedSubview(stckVwRecordCount)
        stckVwManageData.addArrangedSubview(stckVwEarliestDate)

        view.addSubview(stckVwManageData)


        NSLayoutConstraint.activate([


            stckVwManageData.topAnchor.constraint(equalTo: lblManageDataVcTitle.bottomAnchor,constant: heightFromPct(percent: 2)),
            stckVwManageData.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -30)),
            stckVwManageData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 3)),
//            stckVwManageData.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: heightFromPct(percent: -3)),
            btnRecordCountFilled.widthAnchor.constraint(lessThanOrEqualTo: btnEarliestDateFilled.widthAnchor)
            ])
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: stckVwManageData.bottomAnchor, constant: heightFromPct(percent: 2)).isActive = true
    }
    
    func setup_btnConnectData(){
        btnConnectData.accessibilityIdentifier = "btnConnectData"
        btnConnectData.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnConnectData)
        btnConnectData.setTitle("Connect Data", for: .normal)
        btnConnectData.layer.borderColor = UIColor.systemBlue.cgColor
        btnConnectData.layer.borderWidth = 2
        btnConnectData.backgroundColor = .systemBlue
        btnConnectData.layer.cornerRadius = 10
        
        btnConnectData.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnConnectData.addTarget(self, action: #selector(touchUpInsideStartCollectingAppleHealth(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            btnConnectData.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: heightFromPct(percent: 2)),
            btnConnectData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 3)),
            btnConnectData.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -3))
        ])
    }
    
    func setup_manageDataVcOffline(){
        datePicker.removeFromSuperview()
        btnConnectData.removeFromSuperview()
    }
    func setup_manageDataVcOnline(){
        setupDatePicker()
        setup_btnConnectData()
    }
    
    @objc func touchUpInsideStartCollectingAppleHealth(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        print(" send data")
        dtUserHistory = datePicker.date
        
        let calendar = Calendar.current
        // Strip off time components from both dates
        let selectedDate = calendar.startOfDay(for: datePicker.date)
        let currentDate = calendar.startOfDay(for: Date())
        // Check if selectedDate is today or in the future
        if selectedDate >= currentDate {
            self.templateAlert(alertMessage: "You must pick a day in the past.")
            return
        }
//        self.templateAlert(alertMessage: "\(dtUserHistory)")
        actionGetStepsData()
    }
}



/* Sending Apple Health Data */
extension ManageDataVC{
    @objc func actionGetStepsData() {

//        if swtchAllHistoryIsOn {
//            dtUserHistory = nil
//        } else {
            dtUserHistory = datePicker.date
            
            let calendar = Calendar.current
            // Strip off time components from both dates
            let selectedDate = calendar.startOfDay(for: datePicker.date)
            let currentDate = calendar.startOfDay(for: Date())
            // Check if selectedDate is today or in the future
            if selectedDate >= currentDate {
                self.templateAlert(alertMessage: "You must pick a day in the past.")
                return
            }
//        }
        self.showSpinner()
        self.appleHealthDataFetcher.fetchStepsAndOtherQuantityType(quantityTypeIdentifier: .stepCount, startDate: self.dtUserHistory) { fetcherResult in
            switch fetcherResult{
            case let .success(arryStepsDict):
                print("succesfully collected - arryStepsDict - from healthFetcher class")
                self.arryStepsDict = arryStepsDict
                let formatted_arryStepsDictCount = formatWithCommas(number: self.arryStepsDict.count)
                self.spinnerScreenLblMessage(message: "Retrieved \(formatted_arryStepsDictCount) Steps records")

            case let .failure(error):
                self.templateAlert(alertTitle: "Alert", alertMessage: "This app will not function correctly without steps data. Go to Settings > Health > Data Access & Devices > WhatSticks11iOS to grant access")
                print("There was an error getting steps: \(error)")
                self.removeSpinner()
            }
        }
    }
    func actionGetSleepData(){
        self.appleHealthDataFetcher.fetchSleepDataAndOtherCategoryType(categoryTypeIdentifier:.sleepAnalysis, startDate: self.dtUserHistory) { fetcherResult in
            switch fetcherResult{
            case let .success(arrySleepDict):
                print("succesfully collected - arrySleepDict - from healthFetcher class")
                self.arrySleepDict = arrySleepDict
                let formatted_arrySleepDictCount = formatWithCommas(number: arrySleepDict.count)
                if let unwp_message = self.lblMessage.text {
                    self.lblMessage.text = unwp_message + "," + "\n \(formatted_arrySleepDictCount) Sleep records"
                }

            case let .failure(error):
                self.templateAlert(alertTitle: "Alert", alertMessage: "This app will not function correctly without sleep data. Go to Settings > Health > Data Access & Devices > WhatSticks11iOS to grant access")
                print("There was an error getting sleep: \(error)")
                self.removeSpinner()
                
            }
        }
    }
    func actionGetHeartRateData(){
        self.appleHealthDataFetcher.fetchStepsAndOtherQuantityType(quantityTypeIdentifier: .heartRate, startDate: self.dtUserHistory) { fetcherResult in
            switch fetcherResult{
            case let .success(arryHeartRateDict):
                print("succesfully collected - arryHeartRateDict - from healthFetcher class")
                self.arryHeartRateDict = arryHeartRateDict
                let formatted_arryHeartRateDictCount = formatWithCommas(number: arryHeartRateDict.count)
                if let unwp_message = self.lblMessage.text {
                    self.lblMessage.text = unwp_message + "," + "\n \(formatted_arryHeartRateDictCount) Heart Rate records"
                }
            case let .failure(error):
                print("There was an error getting heart rate: \(error)")
                self.removeSpinner()
            }
        }
    }
    func actionGetExerciseTimeData(){
        self.appleHealthDataFetcher.fetchStepsAndOtherQuantityType(quantityTypeIdentifier: .appleExerciseTime, startDate: self.dtUserHistory) { fetcherResult in
            switch fetcherResult{
            case let .success(arryExerciseTimeDict):
                print("succesfully collected - arryExerciseTimeDict - from healthFetcher class")
                self.arryExerciseTimeDict = arryExerciseTimeDict
//                self.removeLblMessage()
                let formatted_arryExerciseTimeDictCount = formatWithCommas(number: arryExerciseTimeDict.count)
//                self.spinnerScreenLblMessage(message: "Retrieved \(formatted_arryExerciseTimeDictCount) Exercise Time records")
                if let unwp_message = self.lblMessage.text {
                    self.lblMessage.text = unwp_message + "," + "\n \(formatted_arryExerciseTimeDictCount) Exerciese records"
                }
            case let .failure(error):
                print("There was an error getting heart rate: \(error)")
                self.removeSpinner()
            }
        }
    }
    func actionGetWorkoutData(){
        self.appleHealthDataFetcher.fetchWorkoutData( startDate: self.dtUserHistory) { fetcherResult in
            switch fetcherResult{
            case let .success(arryWorkoutDict):
                print("succesfully collected - arryWorkoutDict - from healthFetcher class")
                self.arryWorkoutDict = arryWorkoutDict
//                self.removeLblMessage()
                let formatted_arryWorkoutDictCount = formatWithCommas(number: arryWorkoutDict.count)
//                self.spinnerScreenLblMessage(message: "Retrieved \(formatted_arryWorkoutDictCount) Workout records")
                if let unwp_message = self.lblMessage.text {
                    self.lblMessage.text = unwp_message + "," + "\n \(formatted_arryWorkoutDictCount) Workout records"
                }
            case let .failure(error):
                print("There was an error getting heart rate: \(error)")
                self.removeSpinner()
            }
        }
    }
    

    func sendAppleWorkouts(){
        
        print("- in sendAppleWorkouts")
        let dateStringTimeStamp = timeStampsForFileNames()
        // dateStringTimeStamp --> important for file name used by WSAPI/WSAS
        guard let user_id = userStore.user.id else {
            self.templateAlert(alertMessage: "No user id. check ManageAppleHealthVC sendAppleHealthData.")
            return}
        let qty_cat_and_workouts_count = arrySleepDict.count + arryStepsDict.count + arryHeartRateDict.count + arryExerciseTimeDict.count + arryWorkoutDict.count
        if qty_cat_and_workouts_count > 0 {
            self.removeLblMessage()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let formatted_qty_cat_and_workouts_count = formatWithCommas(number: qty_cat_and_workouts_count)
                self.spinnerScreenLblMessage(message: "Sending Apple Health \(formatted_qty_cat_and_workouts_count) records to \nWhat Sticks API")
            }
        }
            self.healthDataStore.callReceiveAppleWorkoutsData(userId: user_id,dateStringTimeStamp:dateStringTimeStamp, arryAppleWorkouts: arryWorkoutDict) { resultResponse in
                switch resultResponse{
                case .success(_):
                    self.sendAppleHealthData(userMessage:"updated apple workouts", dateStringTimeStamp:dateStringTimeStamp)
                    self.strStatusMessage = "1) Workouts sent succesfully"
                case .failure(_):
                    self.strStatusMessage = "1) Workouts NOT sent successfully"
                    self.sendAppleHealthData(userMessage:"updated apple workouts", dateStringTimeStamp:dateStringTimeStamp)
                }
            }
        
    }
    func sendAppleHealthData(userMessage:String, dateStringTimeStamp:String){
        print("- in sendAppleHealthData")
        guard let user_id = userStore.user.id else {
            self.templateAlert(alertMessage: "No user id. check ManageAppleHealthVC sendAppleHealthData.")
            return}
//        let qty_cat_data_count = arrySleepDict.count + arryStepsDict.count + arryHeartRateDict.count + arryExerciseTimeDict.count
            let arryQtyCatData = arrySleepDict + arryStepsDict + arryHeartRateDict + arryExerciseTimeDict

            /* Send apple works outs first */
            self.healthDataStore.sendChunksToWSAPI(userId:user_id,dateStringTimeStamp:dateStringTimeStamp ,arryAppleHealthData: arryQtyCatData) { responseResult in
                self.removeSpinner()
                switch responseResult{
                case .success(_):
                    self.strStatusMessage = self.strStatusMessage + "\n" + "2) Quantity and Category data sent successfully."
                    self.templateAlert(alertTitle: "Success!",alertMessage: "")
                    print("*** MangeAppleHealhtVC.sendAppleHealthData successful! ** ")

                case .failure(_):
                    print("---- MangeAppleHealhtVC.sendAppleHealthData failed :( ---- ")
                    self.strStatusMessage = self.strStatusMessage + "\n" + "2) Quantity and Category data NOT sent successfully."

                    self.templateAlert(alertTitle: "Failed to Send",alertMessage: self.strStatusMessage)
                }
            }
    }
}
