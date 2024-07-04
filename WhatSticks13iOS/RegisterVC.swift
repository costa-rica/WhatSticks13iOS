//
//  RegisterVC.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 29/06/2024.
//

import UIKit

class RegisterVC: UIViewController{
    
    var vwRegisterVC = UIView()
    var lblRegister = UILabel()
    

//    let txtEmail = PaddedTextField()
//    let txtPassword = PaddedTextField()
    
    let txtEmail = UITextField()
    let txtPassword = UITextField()

    let btnShowPassword = UIButton()
    var btnRegister=UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's frame to take up most of the screen except for 5 percent all sides
//        self.view.frame = UIScreen.main.bounds.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        setup_vwRegisterVC()

        setup_lblRegister()
        
        setup_btnRegister()
        setup_registerTextfields()
//        addTapGestureRecognizer()
        
    }
    
    func setup_vwRegisterVC() {
        // The semi-transparent background
//        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.6)
//        view.backgroundColor = .systemBlue
//        vwRegisterVC .backgroundColor = UIColor(named: "ColorTableTabModalBack")
//        vwRegisterVC .layer.cornerRadius = 12
//        = UIColor(named: "ColorAppBackground")
//        vwRegisterVC .layer.borderColor = UIColor(named: "ColorTableTabModalBack")?.cgColor
//        vwRegisterVC .layer.borderWidth = 2
        vwRegisterVC .translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vwRegisterVC )
        vwRegisterVC .centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        vwRegisterVC .centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        vwRegisterVC.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive=true
        vwRegisterVC.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive=true

    }
    func setup_lblRegister(){
        lblRegister.text = "Register"
        lblRegister.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        lblRegister.numberOfLines = 0
        lblRegister.translatesAutoresizingMaskIntoConstraints=false
        vwRegisterVC.addSubview(lblRegister)
        lblRegister.accessibilityIdentifier="lblRegister"
        NSLayoutConstraint.activate([
            lblRegister.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor, constant: 20),
            lblRegister.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: 20),
            lblRegister.topAnchor.constraint(equalTo: vwRegisterVC.topAnchor, constant: 20)
        ])
    }
    func setup_registerTextfields(){
        
        txtEmail.translatesAutoresizingMaskIntoConstraints = false
        txtPassword.translatesAutoresizingMaskIntoConstraints = false
        btnShowPassword.translatesAutoresizingMaskIntoConstraints = false

        txtEmail.accessibilityIdentifier = "txtEmail"
        txtPassword.accessibilityIdentifier = "txtPassword"
        btnShowPassword.accessibilityIdentifier = "btnShowPassword"
        txtEmail.placeholder = "email"
        txtPassword.placeholder = "password"

        txtPassword.isSecureTextEntry = true
        btnShowPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btnShowPassword.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        vwRegisterVC.addSubview(txtEmail)
        vwRegisterVC.addSubview(txtPassword)
        vwRegisterVC.addSubview(btnShowPassword)
        view.layoutIfNeeded()// <-- Important (right here) to prevent UITextField error when typing in it
        
        NSLayoutConstraint.activate([
            txtEmail.topAnchor.constraint(equalTo: lblRegister.bottomAnchor, constant: heightFromPct(percent: 2)),
            txtEmail.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: widthFromPct(percent: 2)),
            txtEmail.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnShowPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor, constant: heightFromPct(percent: 1)),
            btnShowPassword.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: widthFromPct(percent: 2)),
            txtPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor, constant: heightFromPct(percent: 1)),
            txtPassword.trailingAnchor.constraint(equalTo: btnShowPassword.leadingAnchor, constant: widthFromPct(percent: 2)),
            txtPassword.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor, constant: widthFromPct(percent: 2))
            ])
        
        

        

        

        
    }
    func setup_btnRegister(){
        btnRegister.setTitle("Submit", for: .normal)
        btnRegister.layer.borderColor = UIColor.systemBlue.cgColor
        btnRegister.layer.borderWidth = 2
        btnRegister.backgroundColor = .systemBlue
        btnRegister.layer.cornerRadius = 10
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        btnRegister.accessibilityIdentifier="btnRegister"
        view.addSubview(btnRegister)
        
        btnRegister.bottomAnchor.constraint(equalTo: vwRegisterVC.bottomAnchor, constant: -20).isActive=true
        btnRegister.centerXAnchor.constraint(equalTo: vwRegisterVC.centerXAnchor).isActive=true
        btnRegister.widthAnchor.constraint(equalToConstant: widthFromPct(percent: 80)).isActive=true
        
//        btnRegister.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnRegister.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        if let email = txtEmail.text, isValidEmail(email) {
            // Email is valid, proceed to check password
            if let password = txtPassword.text, !password.isEmpty {
                // Proceed with registration logic
//                requestRegister()
                print(" send api register")
            } else {
//                self.templateAlert(alertTitle: "", alertMessage: "Must have password")
                print("test")
            }
        } else {
//            self.templateAlert(alertTitle: "", alertMessage: "Must valid have email")
            print("test")
        }
    }
    
    private func addTapGestureRecognizer() {
        // Create a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

        // Add the gesture recognizer to the view
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: view)
        print("Tap getster on REgisgter VC")
//        dismiss(animated: true, completion: nil)
        let tapLocationInView = view.convert(tapLocation, to: vwRegisterVC)
        

    }
    
    @objc func togglePasswordVisibility() {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        let imageName = txtPassword.isSecureTextEntry ? "eye.slash" : "eye"
        btnShowPassword.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}



import UIKit

class TestVC: TemplateVC {

    // Declare the text fields
    let txtEmailTest = UITextField()
    let txtPasswordTest = UITextField()
    
    var vwRegisterVC = UIView()
    var lblRegister = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup_vwRegisterVC()
        setup_lblRegister()
        setup_test()
    }
    

    func setup_vwRegisterVC() {
        // The semi-transparent background
//        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.6)
//        view.backgroundColor = .systemBlue
        vwRegisterVC .backgroundColor = UIColor(named: "ColorTableTabModalBack")
        vwRegisterVC .layer.cornerRadius = 12
//        = UIColor(named: "ColorAppBackground")
        vwRegisterVC .layer.borderColor = UIColor(named: "ColorTableTabModalBack")?.cgColor
        vwRegisterVC .layer.borderWidth = 2
        vwRegisterVC .translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vwRegisterVC )
        vwRegisterVC .centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        vwRegisterVC .centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        vwRegisterVC.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive=true
        vwRegisterVC.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive=true

    }
    func setup_lblRegister(){
        lblRegister.text = "Register"
        lblRegister.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        lblRegister.numberOfLines = 0
        lblRegister.translatesAutoresizingMaskIntoConstraints=false
        vwRegisterVC.addSubview(lblRegister)
        lblRegister.accessibilityIdentifier="lblRegister"
        NSLayoutConstraint.activate([
            lblRegister.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor, constant: smallPaddingSide),
            lblRegister.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: -smallPaddingSide),
            lblRegister.topAnchor.constraint(equalTo: vwRegisterVC.topAnchor, constant: smallPaddingTop)
        ])
    }
    
    func setup_test(){
        
        // Set up the email text field
        txtEmailTest.placeholder = "Enter your email"
        txtEmailTest.borderStyle = .roundedRect
        txtEmailTest.keyboardType = .emailAddress
        txtEmailTest.autocapitalizationType = .none
        txtEmailTest.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(txtEmailTest)

        // Set up the password text field
        txtPasswordTest.placeholder = "Enter your password"
        txtPasswordTest.borderStyle = .roundedRect
        txtPasswordTest.isSecureTextEntry = true
        txtPasswordTest.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(txtPasswordTest)

//        // Set up the constraints for the text fields
//        NSLayoutConstraint.activate([
//            txtEmailTest.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
//            txtEmailTest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            txtEmailTest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            txtPasswordTest.topAnchor.constraint(equalTo: txtEmailTest.bottomAnchor, constant: 20),
//            txtPasswordTest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            txtPasswordTest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//        ])
        // Set up the constraints for the text fields
        NSLayoutConstraint.activate([
            txtEmailTest.topAnchor.constraint(equalTo: lblRegister.bottomAnchor, constant: smallPaddingTop),
            txtEmailTest.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor, constant: smallPaddingSide),
            txtEmailTest.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: -smallPaddingSide),

            txtPasswordTest.topAnchor.constraint(equalTo: txtEmailTest.bottomAnchor, constant: smallPaddingTop),
            txtPasswordTest.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor, constant: smallPaddingSide),
            txtPasswordTest.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: -smallPaddingSide)
        ])
    }
}


