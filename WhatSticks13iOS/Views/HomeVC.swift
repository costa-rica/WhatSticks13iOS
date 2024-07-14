//
//  ViewController.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class HomeVC: TemplateVC, UserStatusTemporaryViewDelegate {
    

    
    var imgLogo:UIImage?
    let imgVwLogo = UIImageView()
    let lblWhatSticks = UILabel()
    let lblDescription = UILabel()
    
    let vwHomeVcLine = UIView()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let vwStatusTemporary = UserStatusTemporaryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(" in HomeVC -")
        let userStore = UserStore.shared
        let locationFetcher = LocationFetcher.shared
        locationFetcher.requestLocationPermission()
        let parentRequestStore = RequestStore.shared
        userStore.requestStore = parentRequestStore
        vwStatusTemporary.delegate = self
        
        self.lblScreenName.text = "Home"
        self.setup_TopSafeBar()
        setup_HomeScreen()
        
        self.showSpinner()
        userStore.connectDevice {
            print("- finiehd connecting device")
            OperationQueue.main.addOperation {
                self.removeSpinner()
            }
        }
        print("user name is \(userStore.user.username!)")
        if let userLocationArray = UserDefaults.standard.array(forKey: "user_location") as? [[String]] {
            print("user locations: \(userLocationArray)")
        }
        
        setup_vwHomeVcLine()
        setupScrollView()
        setupContentView()
        setup_vwStatusTemporary()
    }

    func setup_HomeScreen(){
        guard let imgLogo = UIImage(named: "logo") else {
            print("Missing logo")
            return
        }
        imgVwLogo.image = imgLogo.scaleImage(toSize: CGSize(width: 50, height: 50))
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
            lblWhatSticks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 1)),
            lblWhatSticks.trailingAnchor.constraint(equalTo: imgVwLogo.leadingAnchor, constant: widthFromPct(percent: -1)),
            lblWhatSticks.topAnchor.constraint(equalTo: imgVwLogo.bottomAnchor, constant: -20)
        ])
        lblDescription.text = "The app designed to use data already being collected by your devices and other apps to help you understand your tendencies and habits."
//        lblDescription.font = UIFont(name: "ArialRoundedMT", size: 17)
        lblDescription.numberOfLines = 0
        lblDescription.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(lblDescription)
        lblDescription.accessibilityIdentifier="lblDescription"
        NSLayoutConstraint.activate([
            lblDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            lblDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            lblDescription.topAnchor.constraint(equalTo: lblWhatSticks.bottomAnchor, constant: 10)
        ])
    }
    private func setup_vwHomeVcLine(){
        vwHomeVcLine.accessibilityIdentifier = "vwHomeVcLine"
        vwHomeVcLine.translatesAutoresizingMaskIntoConstraints = false
        vwHomeVcLine.backgroundColor = UIColor(named: "lineColor")
        view.addSubview(vwHomeVcLine)
        NSLayoutConstraint.activate([
            vwHomeVcLine.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: heightFromPct(percent: 3)),
            vwHomeVcLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vwHomeVcLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vwHomeVcLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: vwHomeVcLine.bottomAnchor),
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

    
    func setup_vwStatusTemporary(){
        print("-- adding vwOffline")
        vwStatusTemporary.accessibilityIdentifier = "vwStatusTemporary"
        vwStatusTemporary.translatesAutoresizingMaskIntoConstraints = false
//        vwStatusTemporary.backgroundColor = .purple
        contentView.addSubview(vwStatusTemporary)
        NSLayoutConstraint.activate([
            vwStatusTemporary.topAnchor.constraint(equalTo: contentView.topAnchor, constant: heightFromPct(percent: 3)),
            vwStatusTemporary.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            vwStatusTemporary.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            vwStatusTemporary.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -5))
            ])
    }
    
    
    
    
    
}

