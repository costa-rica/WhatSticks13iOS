//
//  DashboardVC.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class DashboardVC: TemplateVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemGreen
        let userStore = UserStore.shared
        self.lblScreenName.text = "Dashboard"
        print("user name is \(userStore.user.username!) in DashbaordVC")
    }


}
