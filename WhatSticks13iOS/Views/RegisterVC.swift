//
//  RegisterVC.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 29/06/2024.
//

import UIKit


class RegModalVC: TemplateVC {

    // Declare the text fields
    let txtEmail = UITextField()
    let txtPassword = UITextField()
    
    var vwRegisterVC = UIView()
    var lblRegister = UILabel()
    
    let btnShowPassword = UIButton()
    let btnRegister = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup_vwRegisterVC()
        setup_lblRegister()
        setup_textfields()
        setup_btnRegister()
        addTapGestureRecognizer()
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        vwRegisterVC.layer.borderColor = borderColor(for: traitCollection)
    }
    

    func setup_vwRegisterVC() {
        // The semi-transparent background
        vwRegisterVC.backgroundColor = UIColor(named: "ColorTableTabModalBack")
        vwRegisterVC.layer.cornerRadius = 12
        vwRegisterVC.layer.borderColor = borderColor(for: traitCollection)
        vwRegisterVC.layer.borderWidth = 2
        vwRegisterVC.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vwRegisterVC )
        vwRegisterVC .centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        vwRegisterVC .centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        vwRegisterVC.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive=true
        vwRegisterVC.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive=true
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
    
//    func setup_test(){
    func setup_textfields(){
        
        // Set up the email text field
        txtEmail.placeholder = "Enter your email"
        txtEmail.borderStyle = .roundedRect
        txtEmail.keyboardType = .emailAddress
        txtEmail.autocapitalizationType = .none
        txtEmail.translatesAutoresizingMaskIntoConstraints = false
        vwRegisterVC.addSubview(txtEmail)

        // Set up the password text field
        txtPassword.placeholder = "Enter your password"
        txtPassword.borderStyle = .roundedRect
        txtPassword.isSecureTextEntry = true
        txtPassword.translatesAutoresizingMaskIntoConstraints = false
        vwRegisterVC.addSubview(txtPassword)

        btnShowPassword.accessibilityIdentifier = "btnShowPassword"
        btnShowPassword.translatesAutoresizingMaskIntoConstraints = false
        btnShowPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        vwRegisterVC.addSubview(btnShowPassword)
        btnShowPassword.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        
        // Set up the constraints for the text fields
        NSLayoutConstraint.activate([
            txtEmail.topAnchor.constraint(equalTo: lblRegister.bottomAnchor, constant: smallPaddingTop),
            txtEmail.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor, constant: smallPaddingSide),
            txtEmail.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: -smallPaddingSide),

            btnShowPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor, constant: smallPaddingTop),
            btnShowPassword.trailingAnchor.constraint(equalTo: vwRegisterVC.trailingAnchor, constant: -smallPaddingSide),
            btnShowPassword.widthAnchor.constraint(lessThanOrEqualToConstant: widthFromPct(percent: 10)),

            txtPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor, constant: smallPaddingTop),
            txtPassword.leadingAnchor.constraint(equalTo: vwRegisterVC.leadingAnchor, constant: smallPaddingSide),
            txtPassword.trailingAnchor.constraint(equalTo: btnShowPassword.leadingAnchor,constant:widthFromPct(percent: -1)),
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
        vwRegisterVC.addSubview(btnRegister)
        
        btnRegister.bottomAnchor.constraint(equalTo: vwRegisterVC.bottomAnchor, constant: -20).isActive=true
        btnRegister.centerXAnchor.constraint(equalTo: vwRegisterVC.centerXAnchor).isActive=true
        btnRegister.widthAnchor.constraint(equalToConstant: widthFromPct(percent: 80)).isActive=true
        
        btnRegister.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnRegister.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
    }
    
    @objc func togglePasswordVisibility() {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        let imageName = txtPassword.isSecureTextEntry ? "eye.slash" : "eye"
        btnShowPassword.setImage(UIImage(systemName: imageName), for: .normal)
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
//                print("test")
            }
        } else {
            self.templateAlert(alertTitle: "", alertMessage: "Must valid have email")
//            print("test")
        }
    }
    
    private func addTapGestureRecognizer() {
        // Create a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        print("add tap gester")
        // Add the gesture recognizer to the view
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: view)
         let tapLocationInView = view.convert(tapLocation, to: vwRegisterVC)

         if let firstResponder = view.findFirstResponder() {
             // If the keyboard is present, dismiss it
             firstResponder.resignFirstResponder()
         } else if !vwRegisterVC.bounds.contains(tapLocationInView) {
             // If the keyboard is not present and the tap is outside of vwRegisterVC, dismiss the view controller
             dismiss(animated: true, completion: nil)
         }

    }
    
}



