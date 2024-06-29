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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.lblScreenName.text = "Home"
        self.setup_TopSafeBar()
        setup_HomeScreen()
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
        lblDescription.font = UIFont(name: "ArialRoundedMTBold", size: 17)
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
}

