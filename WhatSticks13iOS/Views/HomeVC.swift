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
        let userStore = UserStore.shared
        let locationFetcher = LocationFetcher.shared
        locationFetcher.locationManager.requestAlwaysAuthorization()
        let parentRequestStore = RequestStore.shared
        userStore.requestStore = parentRequestStore
        vwStatusTemporary.delegate = self
        let healthDataStore = HealthDataStore.shared
        healthDataStore.requestStore = parentRequestStore
        
        self.lblScreenName.text = "Home"
        self.setup_TopSafeBar()
        setup_HomeScreen()
        self.showSpinner()
        UserStore.shared.connectDevice {
            print("- finiehd connecting device")
            OperationQueue.main.addOperation {
                self.removeSpinner()
            }
        }
        
        templateAlertMultipleChoice(alertTitle: "Select environment:", alertMessage: "", choiceOne: "Production", choiceTwo: "Development") { stringResponse in
            switch stringResponse{
            case "Development":
                UserStore.shared.isInDevMode = true
                self.vwTopSafeBar.backgroundColor = UIColor(named:"ColorDevMode")
                self.setup_vwHomeVcLine()
                self.setupScrollView()
                self.setupContentView()
                self.setup_vwStatusTemporary()
            default:
                print("Lets keep it simple")
            }
        }
    }
    //    override func view
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
        lblWhatSticks.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        //        lblWhatSticks.numberOfLines = 0
        lblWhatSticks.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(lblWhatSticks)
        lblWhatSticks.accessibilityIdentifier="lblWhatSticks"
        NSLayoutConstraint.activate([
            lblWhatSticks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 1)),
            //            lblWhatSticks.trailingAnchor.constraint(equalTo: imgVwLogo.leadingAnchor),
            lblWhatSticks.topAnchor.constraint(equalTo: imgVwLogo.bottomAnchor,constant: heightFromPct(percent: -3))
        ])
        lblDescription.text = "The app designed to use data already being collected by your devices and other apps to help you understand your tendencies and habits."
        //        lblDescription.font = UIFont(name: "ArialRoundedMT", size: 17)
        lblDescription.numberOfLines = 0
        lblDescription.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(lblDescription)
        lblDescription.accessibilityIdentifier="lblDescription"
        NSLayoutConstraint.activate([
            lblDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 3)),
            lblDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -1)),
            lblDescription.topAnchor.constraint(equalTo: lblWhatSticks.bottomAnchor, constant: widthFromPct(percent: 3))
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
        contentView.addSubview(vwStatusTemporary)
        NSLayoutConstraint.activate([
            vwStatusTemporary.topAnchor.constraint(equalTo: contentView.topAnchor, constant: heightFromPct(percent: 3)),
            vwStatusTemporary.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            vwStatusTemporary.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            vwStatusTemporary.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -5))
        ])
    }
}

