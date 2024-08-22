//
//  TabController.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
//    weak var delegate_to_userVc: MainTabBarControllerDelegate?
    var lineSelectedTab = UIView()
    var userStore:UserStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userStore = UserStore.shared
        print("- in TabController -")
        self.setupTabs()
        self.tabBar.backgroundColor = UIColor(named: "ColorTableTabModalBack")
        self.tabBar.tintColor = UIColor(named: "ColorTabBarSelected")
        self.tabBar.unselectedItemTintColor = UIColor(named: "ColorTabBarUnselected")
        self.tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor(named: "ColorTabBarSelected")!, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  tabBar.frame.height), lineWidth: 4.0)
        self.delegate = self
    }
    

    private func setupTabs(){
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeVC())
        let dash = self.createNav(with: "Dashboard", and: UIImage(systemName: "clock"), vc: DashboardVC())
        let manage_data = self.createNav(with: "Manage Data", and: UIImage(systemName: "square.and.arrow.up"), vc: ManageDataVC())// <--- altered for TEST DAta
        let user = self.createNav(with: "Manage User", and: UIImage(systemName: "person"), vc: UserVC())

        home.tabBarItem.tag = 0
        dash.tabBarItem.tag = 1
        manage_data.tabBarItem.tag = 2
        user.tabBarItem.tag = 3
        
        self.setViewControllers([home,dash, manage_data, user], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.tabBarItem.tag = 0
        
        return nav
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected viewController: \(type(of: viewController))") // Print the actual class type
//        print("Selected viewController.children: \(viewController.children)")
        guard let nav_vc = viewController as? UINavigationController else {
            print("- Item is not a UINavigationController")
            return
        }
        if let user_vc = nav_vc.children[0] as? UserVC {
            print("-- TabController UserVC selected < ------ *")

            // Trigger action for UserVC selection
            user_vc.vwLocationDayWeather.setLocationSwitchBasedOnUserPermissions()
            user_vc.vwLocationDayWeather.setLocationSwitchLabelText()
            print("MainTabBar - isOnline: \(userStore.isOnline)")
            

            if user_vc.view.subviews.count > 0 {
                user_vc.manageUserVcOptionalViews()
            }
            
            
        }

        if let manage_data_vc = nav_vc.children[0] as? ManageDataVC {// <--- altered for TEST DAta

            if userStore.isOnline || userStore.isGuestMode {
                manage_data_vc.setupManageDataVcOnline()
                let records = userStore.arryDataSourceObjects?[0].recordCount ?? "0"
                let earliestRecordDate = userStore.arryDataSourceObjects?[0].earliestRecordDate ?? "no data"
    //            manage_data_vc.btnRecordCountFilled.setTitle(records, for: .normal)
                manage_data_vc.vwManageDataVcHeader.btnRecordCountFilled.setTitle(records, for: .normal)
    //            manage_data_vc.btnEarliestDateFilled.setTitle(earliestRecordDate, for: .normal)
                manage_data_vc.vwManageDataVcHeader.btnEarliestDateFilled.setTitle(earliestRecordDate, for: .normal)
            }
            else if !userStore.isOnline{
                manage_data_vc.setupManageDataVcOffline()
            }
        }
        if let dash_vc = nav_vc.children[0] as? DashboardVC {
            if userStore.arryDashboardTableObjects.count > 0{
                print("in MainTabBarController dash_vc --------")
                dash_vc.setupUserHasDashboard()
                let currentDashboardObjPos = userStore.currentDashboardObjPos ?? 0
                if let unwp_dashTitle = self.userStore.arryDashboardTableObjects[currentDashboardObjPos].dependentVarName {
                    let btnTitle = " " + unwp_dashTitle + " "
                    dash_vc.vwDashboardHeader.btnDashboardNamePicker.setTitle(btnTitle, for: .normal)
                }
            } else {
                print("*** No dashboard set up")
                dash_vc.setupUserHasNODashboard()
            }
            
        }
    }

}


//// Protocol definition
//protocol MainTabBarControllerDelegate: AnyObject {
//    func removeSpinner()
//    func showSpinner()
//    func templateAlert(alertTitle:String,alertMessage: String,  backScreen: Bool)
//    func presentAlertController(_ alertController: UIAlertController)
//    func touchDown(_ sender: UIButton)
//    var constraints_Offline_NoEmail:[NSLayoutConstraint] {get}
//    var constraints_Online_NoEmail:[NSLayoutConstraint] {get}
//    var constraints_Offline_YesEmail:[NSLayoutConstraint] {get}
//    func case_option_1_Offline_and_generic_name()
//    func case_option_2_Online_and_generic_name()
//    func case_option_3_Online_and_custom_email()
//    func case_option_4_Offline_and_custom_email()
//    var vwUserStatus:UserVcUserStatusView {get}
//    func test_delegate_method()
//}
//


