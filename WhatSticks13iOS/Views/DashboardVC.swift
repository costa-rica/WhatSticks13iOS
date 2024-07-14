//
//  DashboardVC.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class DashboardVC: TemplateVC {
    let lblDashboardVcTitle = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemGreen
        let userStore = UserStore.shared
//        self.lblScreenName.text = "Dashboard"
        print("user name is \(userStore.user.username!) in DashbaordVC")

        setup_TopSafeBar()
        setup_ManageDataVc()
    }
    
    
    private func setup_ManageDataVc(){
        lblDashboardVcTitle.accessibilityIdentifier="lblDashboardVcTitle"
        lblDashboardVcTitle.translatesAutoresizingMaskIntoConstraints = false
        lblDashboardVcTitle.text = "Dashboard VC"
        lblDashboardVcTitle.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        lblDashboardVcTitle.numberOfLines=0
        view.addSubview(lblDashboardVcTitle)
        

        
        NSLayoutConstraint.activate([
            lblDashboardVcTitle.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor, constant: heightFromPct(percent: 3)),
            lblDashboardVcTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -2)),
            lblDashboardVcTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
    

        ])
    }
}
