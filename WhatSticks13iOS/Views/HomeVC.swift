//
//  ViewController.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class HomeVC: TemplateVC {
    var imgLogo:UIImage?
    let imgVwLogo = UIImageView()
    let lblWhatSticks = UILabel()
    let lblDescription = UILabel()
    
    // News feed
    let btnCheckUserDefaultUserLocation = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(" in HomeVC -")
        let userStore = UserStore.shared
        let locationFetcher = LocationFetcher.shared
        locationFetcher.requestLocationPermission()
        let parentRequestStore = RequestStore.shared
        userStore.requestStore = parentRequestStore
        userStore.connectDevice()
        
        
        
        self.lblScreenName.text = "Home"
        self.setup_TopSafeBar()
        setup_HomeScreen()
        print("user name is \(userStore.user.username!)")
        if let userLocationArray = UserDefaults.standard.array(forKey: "user_location") as? [[String]] {
            print("user locations: \(userLocationArray)")
        }
        setup_btnCheckUserDeafultUserLocaiton()
    }

    func setup_HomeScreen(){
        guard let imgLogo = UIImage(named: "logo") else {
            print("Missing logo")
            return
        }
        imgVwLogo.image = imgLogo.scaleImage(toSize: CGSize(width: 50, height: 50))
//        imgVwLogo.image = imgLogo
        imgVwLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imgVwLogo)
        imgVwLogo.accessibilityIdentifier = "imgVwLogo"
        NSLayoutConstraint.activate([
            imgVwLogo.heightAnchor.constraint(equalTo: imgVwLogo.widthAnchor, multiplier: 1.0),
            imgVwLogo.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor, constant: heightFromPct(percent: 5)),
            imgVwLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: widthFromPct(percent: -1))
        ])

        lblWhatSticks.text = "What Sticks"
        lblWhatSticks.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        lblWhatSticks.numberOfLines = 0
        lblWhatSticks.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(lblWhatSticks)
        lblWhatSticks.accessibilityIdentifier="lblWhatSticks"
        NSLayoutConstraint.activate([
            lblWhatSticks.trailingAnchor.constraint(equalTo: imgVwLogo.leadingAnchor, constant: 20),
            lblWhatSticks.topAnchor.constraint(equalTo: imgVwLogo.bottomAnchor, constant: -20)
        ])
        lblDescription.text = "The app designed to use data already being collected by your devices and other apps to help you understand your tendencies and habits."
//        lblDescription.font = UIFont(name: "ArialRoundedMT", size: 17)
        lblDescription.numberOfLines = 0
//        lblDescription.lin
        lblDescription.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(lblDescription)
        lblDescription.accessibilityIdentifier="lblDescription"
        NSLayoutConstraint.activate([
//            lblDescription.trailingAnchor.constraint(equalTo: imgVwLogo.leadingAnchor, constant: 20),
            lblDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            lblDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            lblDescription.topAnchor.constraint(equalTo: lblWhatSticks.bottomAnchor, constant: 10)
        ])
    }
    
    func setup_btnCheckUserDeafultUserLocaiton(){
        btnCheckUserDefaultUserLocation.accessibilityIdentifier = "btnCheckUserDefaultUserLocation"
        btnCheckUserDefaultUserLocation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnCheckUserDefaultUserLocation)
        btnCheckUserDefaultUserLocation.setTitle("User Location", for: .normal)
        btnCheckUserDefaultUserLocation.layer.borderColor = UIColor.systemBlue.cgColor
        btnCheckUserDefaultUserLocation.layer.borderWidth = 2
        btnCheckUserDefaultUserLocation.backgroundColor = .systemBlue
        btnCheckUserDefaultUserLocation.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
//            lblDescription
            btnCheckUserDefaultUserLocation.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: heightFromPct(percent: 5)),
            btnCheckUserDefaultUserLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            btnCheckUserDefaultUserLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
        btnCheckUserDefaultUserLocation.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnCheckUserDefaultUserLocation.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
        
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        if let userLocationArray = UserDefaults.standard.array(forKey: "user_location") as? [[String]] {
            print(userLocationArray)
            self.templateAlert(alertTitle: "We have Locations!!", alertMessage: "\(userLocationArray)")
        } else {
            self.templateAlert(alertTitle: "", alertMessage: "No location")
        }

        
        

    }
    
    
}

