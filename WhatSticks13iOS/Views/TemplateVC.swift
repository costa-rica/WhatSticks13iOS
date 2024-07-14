//
//  TemplateVC.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class TemplateVC: UIViewController {
    
    let vwTopSafeBar = UIView()
    let vwTopBar = UIView()
    let lblScreenName = UILabel()
//    let lblUsername = UILabel()
//    let imgVwLogo = UIImageView()
    let vwFooter = UIView()
    var bodySidePaddingPercentage = Float(5.0)
    var bodyTopPaddingPercentage = Float(20.0)
    var smallPaddingTop = heightFromPct(percent: 2)
    var smallPaddingSide = widthFromPct(percent: 2)
    var spinnerView: UIView?
    var activityIndicator:UIActivityIndicatorView!
    var lblMessage = UILabel()
//    var imgLogoTrailingAnchor: NSLayoutConstraint!
//    var lblScreenNameTopAnchor: NSLayoutConstraint!
//    var lblUserNameBottomAnchor: NSLayoutConstraint!
    
    var isInitialViewController: Bool = false
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ColorAppBackground")
//        setupViews()
    }
//    func setupIsDev(urlStore:URLStore){
//        if urlStore.apiBase == .dev || urlStore.apiBase == .local {
//            vwTopSafeBar.backgroundColor = UIColor(named: "yellow-dev")
//        } else{
//            vwTopSafeBar.backgroundColor = UIColor(named: "ColorTableTabModalBack")
//        }
//
//    }
    
    func setup_TopSafeBar(){
        vwTopSafeBar.backgroundColor = UIColor(named: "ColorTableTabModalBack")
        view.addSubview(vwTopSafeBar)
        vwTopSafeBar.translatesAutoresizingMaskIntoConstraints = false
        vwTopSafeBar.accessibilityIdentifier = "vwTopSafeBar"
        NSLayoutConstraint.activate([
            vwTopSafeBar.topAnchor.constraint(equalTo: view.topAnchor),
            vwTopSafeBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vwTopSafeBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vwTopSafeBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075),
        ])
    }
    func setup_vwFooter(){
//        vwFooter.backgroundColor = UIColor(named: "ColorTableTabModalBack")
        view.addSubview(vwFooter)
        vwFooter.translatesAutoresizingMaskIntoConstraints = false
        vwFooter.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        vwFooter.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vwFooter.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        vwFooter.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.0).isActive = true
    }

    @objc func touchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    func templateAlert(alertTitle:String = "Alert",alertMessage: String,  backScreen: Bool = false, dismissView:Bool = false) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        // This is used to go back
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.removeSpinner()
            if backScreen {
                self.navigationController?.popViewController(animated: true)
            }  else if dismissView {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func showSpinner() {
        print("- TemplateVC showSpinnner - ")
        spinnerView = UIView()
        spinnerView!.translatesAutoresizingMaskIntoConstraints = false
        spinnerView!.backgroundColor = UIColor(white: 0, alpha: 0.5)
        spinnerView!.accessibilityIdentifier = "spinnerView-TemplateVC"
        self.view.addSubview(spinnerView!)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
//        activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints=false
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)// makes spinner bigger
        activityIndicator.center = spinnerView!.center
        activityIndicator.startAnimating()
        spinnerView!.addSubview(activityIndicator)
        activityIndicator.accessibilityIdentifier = "activityIndicator"
        
        NSLayoutConstraint.activate([
            spinnerView!.topAnchor.constraint(equalTo: view.topAnchor),
            spinnerView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spinnerView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spinnerView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: spinnerView!.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: spinnerView!.centerYAnchor),
//            activityIndicator.heightAnchor.constraint(equalToConstant: widthFromPct(percent: 15)),
//            activityIndicator.widthAnchor.constraint(equalToConstant: widthFromPct(percent: 15)),
        ])

    }
    func spinnerScreenLblMessage(message:String){
//        lblMessage.text = "This is a lot of data so it may take more than a minute"
        lblMessage.text = message
//        messageLabel.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblMessage.numberOfLines = 0
        lblMessage.lineBreakMode = .byWordWrapping
        lblMessage.textColor = .white
        lblMessage.textAlignment = .center
//        lblMessage.frame = CGRect(x: 0, y: activityIndicator.frame.maxY + 20, width: spinnerView!.bounds.width, height: 50)
//        lblMessage.isHidden = true
        spinnerView?.addSubview(lblMessage)
        lblMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        lblMessage.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: heightFromPct(percent: 2)),
        lblMessage.leadingAnchor.constraint(equalTo: spinnerView!.leadingAnchor,constant: widthFromPct(percent: 5)),
        lblMessage.trailingAnchor.constraint(equalTo: spinnerView!.trailingAnchor,constant: widthFromPct(percent: -5)),
        ])
//      Timer to show the label after 3 seconds
//        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
//            self.messageLabel.isHidden = false
//        }
    }
    func removeSpinner() {
        spinnerView?.removeFromSuperview()
        spinnerView = nil
        print("removeSpinner() completed")
    }
    func removeLblMessage(){
        lblMessage.removeFromSuperview()
    }
    
    // Implement the delegate method
    func presentAlertController(_ alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
    }
    func presentNewView(_ uiViewController: UIViewController) {
        present(uiViewController, animated: true, completion: nil)
    }

}
