//
//  InformationView.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 20/08/2024.
//

import UIKit

class InformationView: UIView {
    let lblTitle = UILabel()
    let lblDescription = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    init(frame: CGRect, title:String?, description:String?){
        super.init(frame: frame)
        self.lblTitle.text = title
        self.lblDescription.text = description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = UIColor(named: "ColorTableTabModalBack")
        lblTitle.accessibilityIdentifier="lblTitle"
//        lblTitle.text = "No Data"
        lblTitle.translatesAutoresizingMaskIntoConstraints=false
        lblTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblTitle.numberOfLines = 0
        self.addSubview(lblTitle)
        
        lblDescription.accessibilityIdentifier="lblDescription"
//        lblDescription.text = "If you have not already sent data to analyze, go to Manage Data"
        lblDescription.translatesAutoresizingMaskIntoConstraints=false
//        lblDescription.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblDescription.numberOfLines = 0
        self.addSubview(lblDescription)
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
            lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
//            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: heightFromPct(percent: 1)),
            lblDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            
            lblDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -5))
        ])
    }
}
