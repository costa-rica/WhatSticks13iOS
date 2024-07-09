//
//  UserVC.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class UserVC: TemplateVC, UserVcLocationDayWeatherDelegate {
    //    let lblScreenName = UILabel()
    var name:String?
    let scrollView = UIScrollView()
    let contentView = UIView()
    let vwFindAppleHealthPermissions = UserVcFindAppleHealthPermissionsView()
    let vwUserVcLine01=UIView()
    let vwLocationDayWeather = UserVcLocationDayWeather()
    let vwUserVcLine02=UIView()
    
    let testLabelsView = TestLabelsView()
    let vwUserVcLineTest=UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        name = "UserVC"
        // Do any additional setup after loading the view.
        vwLocationDayWeather.delegate = self // Assign the delegate
        let userStore = UserStore.shared
        self.setup_TopSafeBar()
        setupScrollView()
        setupContentView()
        setup_vwFindAppleHealthPermissions()
        setup_vwUserVcLine01()
        setup_vwLocationDayWeather()
        setup_vwUserVcLine02()
               
        
        // Tests //
        setupTestLabelsView()
        setup_vwUserVcLineTest()
        setupSwitchWithLabel()

    }
    func setupScrollView() {
        // Set up the scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Set up constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupContentView() {
        // Set up the content view inside the scroll view
        contentView.accessibilityIdentifier = "contentView"
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Set up constraints for the content view
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // This ensures vertical scrolling
        ])
    }
    
    func setup_vwFindAppleHealthPermissions(){
        vwFindAppleHealthPermissions.accessibilityIdentifier = "vwFindAppleHealthPermissions"
        vwFindAppleHealthPermissions.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwFindAppleHealthPermissions)
        
        // Set up constraints for the test labels view
        NSLayoutConstraint.activate([
            vwFindAppleHealthPermissions.topAnchor.constraint(equalTo: contentView.topAnchor),
            vwFindAppleHealthPermissions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwFindAppleHealthPermissions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
    
    func setup_vwUserVcLine01(){
        vwUserVcLine01.accessibilityIdentifier = "vwUserVcLine01"
        vwUserVcLine01.translatesAutoresizingMaskIntoConstraints = false
        vwUserVcLine01.backgroundColor = UIColor(named: "lineColor")
        contentView.addSubview(vwUserVcLine01)
        NSLayoutConstraint.activate([
            vwUserVcLine01.topAnchor.constraint(equalTo: vwFindAppleHealthPermissions.bottomAnchor),
            vwUserVcLine01.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserVcLine01.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserVcLine01.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

    func setup_vwLocationDayWeather(){
        vwLocationDayWeather.accessibilityIdentifier = "vwLocationDayWeather"
        vwLocationDayWeather.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwLocationDayWeather)
        
        // Set up constraints for the test labels view
        NSLayoutConstraint.activate([
            vwLocationDayWeather.topAnchor.constraint(equalTo: vwUserVcLine01.topAnchor),
            vwLocationDayWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwLocationDayWeather.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
    
    func setup_vwUserVcLine02(){
        vwUserVcLine02.accessibilityIdentifier = "vwUserVcLine02"
        vwUserVcLine02.translatesAutoresizingMaskIntoConstraints = false
        vwUserVcLine02.backgroundColor = UIColor(named: "lineColor")
        contentView.addSubview(vwUserVcLine02)
        NSLayoutConstraint.activate([
            vwUserVcLine02.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwUserVcLine02.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserVcLine02.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserVcLine02.heightAnchor.constraint(equalToConstant: 1),
            
        ])
    }
    
    
    
    
    
    // Testing methods
    
    
    func setupTestLabelsView() {
        // Set up the test labels view
        testLabelsView.accessibilityIdentifier = "testLabelsView"
        testLabelsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(testLabelsView)
        
        // Set up constraints for the test labels view
        NSLayoutConstraint.activate([
            testLabelsView.topAnchor.constraint(equalTo: vwUserVcLine02.topAnchor),
            testLabelsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            testLabelsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
    
    func setup_vwUserVcLineTest(){
        vwUserVcLineTest.accessibilityIdentifier = "vwUserVcLine01"
        vwUserVcLineTest.translatesAutoresizingMaskIntoConstraints = false
        vwUserVcLineTest.backgroundColor = UIColor(named: "lineColor")
        contentView.addSubview(vwUserVcLineTest)
        NSLayoutConstraint.activate([
            vwUserVcLineTest.topAnchor.constraint(equalTo: testLabelsView.bottomAnchor),
            vwUserVcLineTest.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserVcLineTest.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserVcLineTest.heightAnchor.constraint(equalToConstant: 1),
            
        ])
    }
    
    
    func setupSwitchWithLabel() {
        let testLabel = UILabel()
        testLabel.accessibilityIdentifier = "testLabel"
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.text = "Test Switch"
        testLabel.textAlignment = .center
        testLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        let testSwitch = UISwitch()
        testSwitch.accessibilityIdentifier = "testSwitch"
        testSwitch.translatesAutoresizingMaskIntoConstraints = false
        testSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        
        contentView.addSubview(testLabel)
        contentView.addSubview(testSwitch)
        
        // Set up constraints for the test label
        NSLayoutConstraint.activate([
            testLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            testLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            testLabel.topAnchor.constraint(equalTo: vwUserVcLineTest.bottomAnchor, constant: 16),
            testLabel.heightAnchor.constraint(equalToConstant: 50),
//            testLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        // Set up constraints for the test switch
        NSLayoutConstraint.activate([
            testSwitch.leadingAnchor.constraint(equalTo: testLabel.trailingAnchor, constant: 16),
            testSwitch.centerYAnchor.constraint(equalTo: testLabel.centerYAnchor),
            testSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            testSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc func switchToggled(_ sender: UISwitch) {
        print("Switch is now \(sender.isOn ? "ON" : "OFF")")
    }
    
}








class ScrollViewControllerModified02: TemplateVC {

    let scrollView = UIScrollView()
    let contentView = UIView()
    let testLabelsView = TestLabelsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setup_TopSafeBar()
        setupScrollView()
        setupContentView()
        setupTestLabelsView()
        setupSwitchWithLabel()
    }
    
    func setupScrollView() {
        // Set up the scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Set up constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupContentView() {
        // Set up the content view inside the scroll view
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Set up constraints for the content view
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // This ensures vertical scrolling
        ])
    }
    
    func setupTestLabelsView() {
        // Set up the test labels view
        testLabelsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(testLabelsView)
        
        // Set up constraints for the test labels view
        NSLayoutConstraint.activate([
            testLabelsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            testLabelsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            testLabelsView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    func setupSwitchWithLabel() {
        let testLabel = UILabel()
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.text = "Test Switch"
        testLabel.textAlignment = .center
        testLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        let testSwitch = UISwitch()
        testSwitch.translatesAutoresizingMaskIntoConstraints = false
        testSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        
        contentView.addSubview(testLabel)
        contentView.addSubview(testSwitch)
        
        // Set up constraints for the test label
        NSLayoutConstraint.activate([
            testLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            testLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            testLabel.topAnchor.constraint(equalTo: testLabelsView.bottomAnchor, constant: 16),
            testLabel.heightAnchor.constraint(equalToConstant: 50),
//            testLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        // Set up constraints for the test switch
        NSLayoutConstraint.activate([
            testSwitch.leadingAnchor.constraint(equalTo: testLabel.trailingAnchor, constant: 16),
            testSwitch.centerYAnchor.constraint(equalTo: testLabel.centerYAnchor),
            testSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            testSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc func switchToggled(_ sender: UISwitch) {
        print("Switch is now \(sender.isOn ? "ON" : "OFF")")
    }
}

class TestLabelsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabels()
    }
    
    private func setupLabels() {
        var previousLabel: UILabel? = nil
        for i in 1...20 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Label \(i)"
            label.textAlignment = .center
            label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            addSubview(label)
            
            // Set up constraints for the label
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                label.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            if let previous = previousLabel {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 16).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
            }
            
            previousLabel = label
        }
        
        // Set the bottom constraint of the last label to the bottom anchor of the view
        if let lastLabel = previousLabel {
            lastLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        }
    }
}



