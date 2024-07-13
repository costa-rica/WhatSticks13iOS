//
//  UserVC.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class UserVC: TemplateVC, UserVcLocationDayWeatherDelegate, UserVcOfflineDelegate, UserVcRegisterButtonDelegate, UserVcDeleteDelegate, RegModalVcDelegate{

    var userStore: UserStore!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
        
    let vwFindAppleHealthPermissions = UserVcFindAppleHealthPermissionsView()
//    let vwUserVcLine01=UIView()
    let vwLocationDayWeather = UserVcLocationDayWeather(frame: CGRect.zero, showLine: true)

    let vwOffline = UserVcOffline(frame: CGRect.zero, showLine: true)
    var constraints_Offline_NoEmail = [NSLayoutConstraint]()

    let vwUserStatus = UserVcUserStatusView(frame: CGRect.zero, showLine: true)
    var constraints_Online_NoEmail = [NSLayoutConstraint]()
    
    
    let vwUserDeleteAccount = UserVcDelete(frame: CGRect.zero, showLine: true)
    var constraints_Online_YesEmail = [NSLayoutConstraint]()
    
    var constraints_Offline_YesEmail = [NSLayoutConstraint]()

    override func viewDidLoad() {
        print("- in UserVC viewDidLoad -")
        super.viewDidLoad()
        vwOffline.delegate = self
        vwUserStatus.vwRegisterButton.delegate = self
        vwLocationDayWeather.delegate = self
        vwUserDeleteAccount.delegate = self
        userStore = UserStore.shared

        self.setup_TopSafeBar()
        setupScrollView()
        setupContentView()
        setup_vwFindAppleHealthPermissions()

        constraints_Offline_NoEmail = [
            vwOffline.topAnchor.constraint(equalTo: vwFindAppleHealthPermissions.bottomAnchor),
            vwOffline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwOffline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwOffline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -10)),
        ]
        constraints_Online_NoEmail = [
            vwLocationDayWeather.topAnchor.constraint(equalTo: vwFindAppleHealthPermissions.bottomAnchor),
            vwLocationDayWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwLocationDayWeather.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            vwUserStatus.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwUserStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserStatus.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -10)),
        ]
        constraints_Online_YesEmail = [
            vwLocationDayWeather.topAnchor.constraint(equalTo: vwFindAppleHealthPermissions.bottomAnchor),
            vwLocationDayWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwLocationDayWeather.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            vwUserStatus.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwUserStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            vwUserDeleteAccount.topAnchor.constraint(equalTo: vwUserStatus.bottomAnchor),
            vwUserDeleteAccount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserDeleteAccount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwUserDeleteAccount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -10)),
        ]
        constraints_Offline_YesEmail = [
            vwUserStatus.topAnchor.constraint(equalTo: vwLocationDayWeather.bottomAnchor),
            vwUserStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwUserStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            vwOffline.topAnchor.constraint(equalTo: vwUserStatus.bottomAnchor),
            vwOffline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwOffline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vwOffline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -10)),
        ]

        if !userStore.isOnline, userStore.user.email == nil {
            case_option_1_Offline_and_generic_name()
        }else if userStore.isOnline, userStore.user.email == nil{
            case_option_2_Online_and_generic_name()
        } else if userStore.isOnline, userStore.user.email != nil{
            case_option_3_Online_and_custom_email()
        } else if !userStore.isOnline, userStore.user.email != nil {
            case_option_4_Offline_and_custom_email()
        }
    }
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func setupContentView() {
        contentView.accessibilityIdentifier = "contentView"
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
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
        NSLayoutConstraint.activate([
            vwFindAppleHealthPermissions.topAnchor.constraint(equalTo: contentView.topAnchor),
            vwFindAppleHealthPermissions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vwFindAppleHealthPermissions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
//    func setup_vwUserVcLine01(){
//        vwUserVcLine01.accessibilityIdentifier = "vwUserVcLine01"
//        vwUserVcLine01.translatesAutoresizingMaskIntoConstraints = false
//        vwUserVcLine01.backgroundColor = UIColor(named: "lineColor")
//        contentView.addSubview(vwUserVcLine01)
//        NSLayoutConstraint.activate([
//            vwUserVcLine01.topAnchor.constraint(equalTo: vwFindAppleHealthPermissions.bottomAnchor),
//            vwUserVcLine01.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            vwUserVcLine01.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            vwUserVcLine01.heightAnchor.constraint(equalToConstant: 1),
//        ])
//    }
    func setup_vwLocationDayWeather(){
        vwLocationDayWeather.accessibilityIdentifier = "vwLocationDayWeather"
        vwLocationDayWeather.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwLocationDayWeather)

    }
    func setup_vwOffline(){
        print("-- adding vwOffline")
        vwOffline.accessibilityIdentifier = "vwOffline"
        vwOffline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwOffline)
    }

    func setup_vwUserStatus(){
        print("-- adding vwUserStatus")
        vwUserStatus.accessibilityIdentifier = "vwUserStatus"
        vwUserStatus.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwUserStatus)
    }
    
    func setup_vwUserDeleteAccount(){
        print("-- adding vwUserStatus")
        vwUserDeleteAccount.accessibilityIdentifier = "vwUserDeleteAccount"
        vwUserDeleteAccount.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vwUserDeleteAccount)
    }
    
    func remove_optionalViews(){
        NSLayoutConstraint.deactivate(constraints_Offline_NoEmail)
        NSLayoutConstraint.deactivate(constraints_Online_NoEmail)
        NSLayoutConstraint.deactivate(constraints_Offline_YesEmail)
        NSLayoutConstraint.deactivate(constraints_Online_YesEmail)
        vwLocationDayWeather.removeFromSuperview()
        vwOffline.removeFromSuperview()
        vwUserStatus.removeFromSuperview()
        vwUserDeleteAccount.removeFromSuperview()
        print("--- finished remove_optionalViews -")
    }
    func case_option_1_Offline_and_generic_name(){
        remove_optionalViews()
        setup_vwOffline()
        NSLayoutConstraint.activate(constraints_Offline_NoEmail)
    }
    func case_option_2_Online_and_generic_name(){
        remove_optionalViews()
        setup_vwLocationDayWeather()
        setup_vwUserStatus()
        vwUserStatus.btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
        NSLayoutConstraint.deactivate(vwUserStatus.constraints_NO_VwRegisterButton)
        vwUserStatus.setup_vcRegistrationButton()
        NSLayoutConstraint.activate(vwUserStatus.constraints_YES_VwRegisterButton)
        NSLayoutConstraint.activate(constraints_Online_NoEmail)
    }
    func case_option_3_Online_and_custom_email(){
        remove_optionalViews()
        setup_vwLocationDayWeather()
        setup_vwUserStatus()
        vwUserStatus.btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
        NSLayoutConstraint.deactivate(vwUserStatus.constraints_YES_VwRegisterButton)
        vwUserStatus.vwRegisterButton.removeFromSuperview()
        NSLayoutConstraint.activate(vwUserStatus.constraints_NO_VwRegisterButton)
        
        setup_vwUserDeleteAccount()
        NSLayoutConstraint.activate(constraints_Online_YesEmail)
    }
    func case_option_4_Offline_and_custom_email(){
        remove_optionalViews()
        setup_vwUserStatus()
        vwUserStatus.btnUsernameFilled.setTitle(userStore.user.username, for: .normal)
        setup_vwOffline()
        NSLayoutConstraint.activate(constraints_Offline_YesEmail)
    }
    
    
}






