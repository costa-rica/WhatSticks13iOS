//
//  ViewController.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class HomeVC: TemplateVC, UserStatusTemporaryViewDelegate {
    
    
    
//    var imgLogo:UIImage?
//    let imgVwLogo = UIImageView()
//    let lblWhatSticks = UILabel()
//    let lblDescription = UILabel()
//    
//    let vwHomeVcLine = UIView()
    let vwHomeVcHeader = HomeVcHeaderView()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let vwStatusTemporary = UserStatusTemporaryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userStore = UserStore.shared
        let locationFetcher = LocationFetcher.shared
        locationFetcher.locationManager.requestAlwaysAuthorization()
        let parentRequestStore = RequestStore.shared
        userStore.requestStore = parentRequestStore
        vwStatusTemporary.delegate = self
        let healthDataStore = HealthDataStore.shared
        healthDataStore.requestStore = parentRequestStore
        
//        self.lblScreenName.text = "Home"
        self.setup_TopSafeBar()
        setupHomeVcHeader()
        self.showSpinner()
        UserStore.shared.connectDevice {
            print("- finied connecting device")
            OperationQueue.main.addOperation {
                self.removeSpinner()
            }
        }
        
//        templateAlertMultipleChoice(alertTitle: "Select environment:", alertMessage: "", choiceOne: "Production", choiceTwo: "Development") { stringResponse in
//            switch stringResponse{
//            case "Development":
//                UserStore.shared.isInDevMode = true
//                self.vwTopSafeBar.backgroundColor = UIColor(named:"ColorDevMode")
//                self.setupScrollView()
//                self.setupContentView()
//                self.setup_vwStatusTemporary()
//                self.templateAlert(alertTitle: "⚠️", alertMessage: "Remember: development setting has no restrictions on collecting/sending locations", completion: nil)
//                LocationFetcher.shared.updateInterval = 1
//            default:
//                print("Lets keep it simple")
//            }
//        }
    }
    //    override func view
    func setupHomeVcHeader(){
        vwHomeVcHeader.accessibilityIdentifier = "vwHomeVcHeader"
        vwHomeVcHeader.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(vwHomeVcHeader)
        NSLayoutConstraint.activate([
            vwHomeVcHeader.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor),
            vwHomeVcHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vwHomeVcHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

//    func setupScrollView() {
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(scrollView)
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: vwHomeVcHeader.bottomAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    func setupContentView() {
//        contentView.accessibilityIdentifier = "contentView"
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(contentView)
//        NSLayoutConstraint.activate([
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // This ensures vertical scrolling
//        ])
//    }
//    
//    
//    func setup_vwStatusTemporary(){
//        print("-- adding vwOffline")
//        vwStatusTemporary.accessibilityIdentifier = "vwStatusTemporary"
//        vwStatusTemporary.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(vwStatusTemporary)
//        NSLayoutConstraint.activate([
//            vwStatusTemporary.topAnchor.constraint(equalTo: contentView.topAnchor, constant: heightFromPct(percent: 3)),
//            vwStatusTemporary.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
//            vwStatusTemporary.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
//            vwStatusTemporary.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -5))
//        ])
//    }
}

