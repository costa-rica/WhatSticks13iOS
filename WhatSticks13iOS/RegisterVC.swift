//
//  RegisterVC.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 29/06/2024.
//

import UIKit

class RegisterVC: TemplateVC{
    
    var vwRegisterVC = UIView()
    var lblRegister = UILabel()
    
    let stckVwRegister = UIStackView()//accessIdentifier set
    let stckVwEmailRow = UIStackView()//accessIdentifier set
    let stckVwPasswordRow = UIStackView()//accessIdentifier set
    
    
//    let lblEmail = UILabel()
    let txtEmail = PaddedTextField()

//    let lblPassword = UILabel()
    let txtPassword = PaddedTextField()

    let btnShowPassword = UIButton()
    var btnRegister=UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's frame to take up most of the screen except for 5 percent all sides
        self.view.frame = UIScreen.main.bounds.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        setup_vwRegisterVC()
//        setup_stckVwRinconOptions()
        setup_lblRegister()
        
        setup_btnRegister()
        setup_stckVwRegister()
        addTapGestureRecognizer()
        
    }
    
    func setup_vwRegisterVC() {
        // The semi-transparent background
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.6)
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
            lblRegister.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor, constant: 20),
            lblRegister.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: 20),
            lblRegister.topAnchor.constraint(equalTo: vwRegisterVC.topAnchor, constant: 20)
        ])
    }
    func setup_stckVwRegister(){
//        lblEmail.text = "Email"
//        lblPassword.text = "Password"
        
        stckVwRegister.translatesAutoresizingMaskIntoConstraints = false
        stckVwEmailRow.translatesAutoresizingMaskIntoConstraints = false
        stckVwPasswordRow.translatesAutoresizingMaskIntoConstraints = false
        txtEmail.translatesAutoresizingMaskIntoConstraints = false
        txtPassword.translatesAutoresizingMaskIntoConstraints = false
//        lblEmail.translatesAutoresizingMaskIntoConstraints = false
//        lblPassword.translatesAutoresizingMaskIntoConstraints = false
        
        stckVwRegister.accessibilityIdentifier="stckVwRegister"
        stckVwEmailRow.accessibilityIdentifier="stckVwEmailRow"
        stckVwPasswordRow.accessibilityIdentifier = "stckVwPasswordRow"
        txtEmail.accessibilityIdentifier = "txtEmail"
        txtPassword.accessibilityIdentifier = "txtPassword"
        txtEmail.placeholder = "email"
        txtPassword.placeholder = "password"
//        lblEmail.accessibilityIdentifier = "lblEmail"
//        lblPassword.accessibilityIdentifier = "lblPassword"
        
        txtPassword.isSecureTextEntry = true
        btnShowPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btnShowPassword.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
//        stckVwEmailRow.addArrangedSubview(lblEmail)
        stckVwEmailRow.addArrangedSubview(txtEmail)
        
//        stckVwPasswordRow.addArrangedSubview(lblPassword)
        stckVwPasswordRow.addArrangedSubview(txtPassword)
        stckVwPasswordRow.addArrangedSubview(btnShowPassword)
        
        stckVwRegister.addArrangedSubview(stckVwEmailRow)
        stckVwRegister.addArrangedSubview(stckVwPasswordRow)
        
        stckVwRegister.axis = .vertical
        stckVwEmailRow.axis = .horizontal
        stckVwPasswordRow.axis = .horizontal
        
        stckVwRegister.spacing = 5
        stckVwEmailRow.spacing = 2
        stckVwPasswordRow.spacing = 2
        
        // Customize txtEmail
        txtEmail.layer.borderColor = UIColor.systemGray.cgColor // Adjust color as needed
        txtEmail.layer.borderWidth = 1.0 // Adjust border width as needed
        txtEmail.layer.cornerRadius = 5.0 // Adjust corner radius as needed
        txtEmail.layer.masksToBounds = true
        view.layoutIfNeeded()// <-- Important (right here) to prevent UITextField error when typing in it
        
        // Customize txtPassword
        txtPassword.layer.borderColor = UIColor.systemGray.cgColor // Adjust color as needed
        txtPassword.layer.borderWidth = 1.0 // Adjust border width as needed
        txtPassword.layer.cornerRadius = 5.0 // Adjust corner radius as needed
        txtPassword.layer.masksToBounds = true
        view.layoutIfNeeded()// <-- Important (right here) to prevent UITextField error when typing in it
        
//        txtEmail.heightAnchor.constraint(equalToConstant: 35).isActive = true // Adjust height as needed
//        txtPassword.heightAnchor.constraint(equalToConstant: 35).isActive = true // Adjust height as needed
        
        view.addSubview(stckVwRegister)
        
        NSLayoutConstraint.activate([
            stckVwRegister.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor,constant: widthFromPct(percent: self.bodySidePaddingPercentage)),
            stckVwRegister.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: widthFromPct(percent: -bodySidePaddingPercentage)),
            stckVwRegister.topAnchor.constraint(equalTo: vwRegisterVC.topAnchor, constant: heightFromPct(percent: bodyTopPaddingPercentage)),
            stckVwRegister.bottomAnchor.constraint(lessThanOrEqualTo: btnRegister.topAnchor, constant: -20)
        ])
        
        // This code makes the widths of lblPassword and btnShowPassword take lower precedence than txtPassword.
//        btnShowPassword.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
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
        
        btnRegister.bottomAnchor.constraint(equalTo: vwRegisterVC.bottomAnchor, constant: -heightFromPct(percent: bodyTopPaddingPercentage)).isActive=true
        btnRegister.centerXAnchor.constraint(equalTo: vwRegisterVC.centerXAnchor).isActive=true
        btnRegister.widthAnchor.constraint(equalToConstant: widthFromPct(percent: 80)).isActive=true
        
        btnRegister.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
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
                self.templateAlert(alertTitle: "", alertMessage: "Must have password")
            }
        } else {
            self.templateAlert(alertTitle: "", alertMessage: "Must valid have email")
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
        
//        if let activeTextField = findActiveTextField(uiView: vwRegisterVC),
        if let activeTextField = findActiveTextField(uiStackView: stckVwRegister),
           activeTextField.isFirstResponder {
            // If a text field is active and the keyboard is visible, dismiss the keyboard
            activeTextField.resignFirstResponder()
        } else {
            // If no text field is active or the keyboard is not visible, dismiss the VC
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func togglePasswordVisibility() {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        let imageName = txtPassword.isSecureTextEntry ? "eye.slash" : "eye"
        btnShowPassword.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
