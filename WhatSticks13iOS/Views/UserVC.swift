//
//  UserVC.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class UserVC: TemplateVC, UserVcLocationDayWeatherDelegate {

    let scrollView = UIScrollView()
    let contentView = UIView()
    let vwFindAppleHealthPermissions = UserVcFindAppleHealthPermissionsView()
    let vwUserVcLine01=UIView()
    let vwLocationDayWeather = UserVcLocationDayWeather()
//    let vwUserVcLine02=UIView()
    
    var vwUserStatus:UserVcUserStatusView!
    var vwOffline:UserVcOffline!


    override func viewDidLoad() {
        super.viewDidLoad()
//        name = "UserVC"
        // Do any additional setup after loading the view.
        vwLocationDayWeather.delegate = self // Assign the delegate
//        let userStore = UserStore.shared
        self.setup_TopSafeBar()
        setupScrollView()
        setupContentView()
        setup_vwFindAppleHealthPermissions()
        setup_vwUserVcLine01()
        setup_vwLocationDayWeather()

    }
    
    
    
    func setupScrollView() {
        // Set up the scroll view
        scrollView.accessibilityIdentifier = "scrollView-UserVC"
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
       
    
    func setup_vwUserStatus(){
        vwUserStatus.accessibilityIdentifier = "vwUserStatus"
        vwUserStatus.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwUserStatus)
        
        // Set up constraints for the test labels view
        NSLayoutConstraint.activate([
            vwUserStatus.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwUserStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserStatus.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setup_vwOffline(){
        vwOffline.accessibilityIdentifier = "vwOffline"
        vwOffline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwOffline)
        
        // Set up constraints for the test labels view
        NSLayoutConstraint.activate([
            vwOffline.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwOffline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwOffline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwOffline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
    }
    


    
}






