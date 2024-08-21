//
//  DashboardVC.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class DashboardVC: TemplateVC, DashboardHeaderDelegate, SelectDashboardVCDelegate {
    
    var userStore:UserStore!
    let vwDashboardHeader = DashboardHeader()
    var tblDashboard:UITableView?
    var vwDashboardHasNoData = InformationView()
    //    let lblDashboardVcTitle = UILabel()
    //    var btnRefreshDashboard:UIButton?
    //    var refreshControlTblDashboard:UIRefreshControl?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userStore = UserStore.shared
        vwDashboardHeader.delegate = self
        setup_TopSafeBar()
    }
    
    func setupUserHasNODashboard(){
        vwDashboardHeader.removeFromSuperview()
        tblDashboard?.removeFromSuperview()
        // MARK: remove vwDashboardHeader and table
//        vwDashboardHasNoData = DashboardVcNoDataView()
        vwDashboardHasNoData.lblTitle.text = "No Data"
        vwDashboardHasNoData.lblDescription.text = "Go to Manage Data to submit your data for analysis"
        vwDashboardHasNoData.accessibilityIdentifier="vwDashboardHasNoData"
        vwDashboardHasNoData.translatesAutoresizingMaskIntoConstraints=false
        vwDashboardHasNoData.layer.cornerRadius = 12
        view.addSubview(vwDashboardHasNoData)
        NSLayoutConstraint.activate([
            self.vwDashboardHasNoData.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.vwDashboardHasNoData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallPaddingSide),
            self.vwDashboardHasNoData.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -smallPaddingTop),
        ])
//        self.btnRefreshDashboard = UIButton()
//        self.btnRefreshDashboard!.accessibilityIdentifier = "btnRefreshDashboard"
//        self.btnRefreshDashboard!.translatesAutoresizingMaskIntoConstraints=false
//        self.btnRefreshDashboard!.backgroundColor = .systemGray
//        self.btnRefreshDashboard!.layer.cornerRadius = 10
//        self.btnRefreshDashboard!.setTitle(" Refresh Table ", for: .normal)
//        self.btnRefreshDashboard!.addTarget(self, action: #selector(self.touchDown(_:)), for: .touchDown)
//        self.btnRefreshDashboard!.addTarget(self, action: #selector(touchUpInside_btnRefreshDashboard(_:)), for: .touchUpInside)
//        view.addSubview(self.btnRefreshDashboard!)
//        NSLayoutConstraint.activate([
//            self.btnRefreshDashboard!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            self.btnRefreshDashboard!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
//            self.btnRefreshDashboard!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -2)),
//        ])
    }
    
    func setupUserHasDashboard(){
//        btnRefreshDashboard?.removeFromSuperview()
        vwDashboardHasNoData.removeFromSuperview()
        setup_vwDashboardHeader()
        setup_tblDashboard()
    }
    
    
    private func setup_vwDashboardHeader(){
        vwDashboardHeader.accessibilityIdentifier = "vwDashboardHeader"
        vwDashboardHeader.translatesAutoresizingMaskIntoConstraints = false
//        vwDashboardHeader.backgroundColor = UIColor(named: "ColorRow2")
        vwDashboardHeader.btnDashboardNamePicker.backgroundColor = UIColor(named: "ColorRow3Textfields")
        vwDashboardHeader.btnDashboardNamePicker.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 27)
        view.addSubview(vwDashboardHeader)
        NSLayoutConstraint.activate([
            vwDashboardHeader.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor),
            vwDashboardHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vwDashboardHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vwDashboardHeader.bottomAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor, constant: heightFromPct(percent: 10))
        ])
    }
    func setup_tblDashboard(){

        self.tblDashboard = UITableView()
        self.tblDashboard!.accessibilityIdentifier = "tblDashboard"
        self.tblDashboard!.translatesAutoresizingMaskIntoConstraints=false
        self.tblDashboard!.delegate = self
        self.tblDashboard!.dataSource = self
        self.tblDashboard!.register(DashboardTableCell.self, forCellReuseIdentifier: "DashboardTableCell")
        self.tblDashboard!.rowHeight = UITableView.automaticDimension
        self.tblDashboard!.estimatedRowHeight = 100
        view.addSubview(self.tblDashboard!)
        NSLayoutConstraint.activate([
            tblDashboard!.topAnchor.constraint(equalTo: vwDashboardHeader.bottomAnchor, constant: heightFromPct(percent: 2)),
            tblDashboard!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tblDashboard!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tblDashboard!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        
//        self.refreshControlTblDashboard = UIRefreshControl()
//        refreshControlTblDashboard!.addTarget(self, action: #selector(self.refresh_tblDashboardData(_:)), for: .valueChanged)
//        self.tblDashboard!.refreshControl = refreshControlTblDashboard!
    }
    
    
    @objc private func touchUpInside_btnRefreshDashboard(_ sender: UIButton){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
//        self.update_arryDashboardTableObjects()
        print("Check for User Dashboard data")
    }
    
    /* Protocol methods */
    func didSelectDashboard(currentDashboardObjPos:Int){
        print("- didSelectDashboard")
        let dash_tab_obj = self.userStore.arryDashboardTableObjects[currentDashboardObjPos]
        print("-- > user selected \(currentDashboardObjPos) - \(dash_tab_obj.dependentVarName!)")
        
        
        for i in dash_tab_obj.arryIndepVarObjects!{
            print("--- > Ind var name: \(i.independentVarName!), corr: \(i.correlationValue!)")
        }
            

        
        DispatchQueue.main.async{
            self.userStore.currentDashboardObjPos = currentDashboardObjPos
            self.userStore.currentDashboardObject = self.userStore.arryDashboardTableObjects[currentDashboardObjPos]
            print("-- > this should change here")
            if let unwp_dashTitle = self.userStore.arryDashboardTableObjects[currentDashboardObjPos].dependentVarName {
                let btnTitle = " " + unwp_dashTitle + " "
                self.vwDashboardHeader.btnDashboardNamePicker.setTitle(btnTitle, for: .normal)
            }
            self.tblDashboard?.reloadData()
        }
    }
    
    
    @objc func touchUpInside_btnSelectDashboards(_ sender: UIRefreshControl){
        print("present SelectDashboardVC")
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        let selectDashboardVC = SelectDashboardVC()
        selectDashboardVC.delegate = self
        selectDashboardVC.modalPresentationStyle = .overCurrentContext
        selectDashboardVC.modalTransitionStyle = .crossDissolve
        self.present(selectDashboardVC, animated: true, completion: nil)
    }
    
//    /* OBE */
//    private func setup_some_Label(){
//        lblDashboardVcTitle.accessibilityIdentifier="lblDashboardVcTitle"
//        lblDashboardVcTitle.translatesAutoresizingMaskIntoConstraints = false
//        lblDashboardVcTitle.text = "Dashboard VC"
//        lblDashboardVcTitle.font = UIFont(name: "ArialRoundedMTBold", size: 45)
//        lblDashboardVcTitle.numberOfLines=0
//        view.addSubview(lblDashboardVcTitle)
//        NSLayoutConstraint.activate([
//            lblDashboardVcTitle.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor, constant: heightFromPct(percent: 3)),
//            lblDashboardVcTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -2)),
//            lblDashboardVcTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
//        ])
//    }
}

extension DashboardVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DashboardTableCell else { return }
        cell.isVisible.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}

extension DashboardVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("- numberOfRowsInSection")
        guard let dashTableObj = self.userStore.currentDashboardObject else {
            print("-- > zero")
            return 0
        }
        print("-- > \(dashTableObj.arryIndepVarObjects!.count)")
        return dashTableObj.arryIndepVarObjects!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableCell", for: indexPath) as! DashboardTableCell
        guard let currentDashObj = userStore.currentDashboardObject,
              let arryIndepVarObjects = currentDashObj.arryIndepVarObjects,
              let unwpVerb = currentDashObj.verb else {return cell}
        
        cell.indepVarObject = arryIndepVarObjects[indexPath.row]
        cell.depVarVerb = unwpVerb
        cell.configureCellWithIndepVarObject()
        return cell
    }
    
}



//class DashboardVcNoDataView: UIView {
//    let lblTitle = UILabel()
//    let lblDescription = UILabel()
//
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupView(){
//        self.backgroundColor = UIColor(named: "ColorTableTabModalBack")
//        lblTitle.accessibilityIdentifier="lblTitle"
//        lblTitle.text = "No Data"
//        lblTitle.translatesAutoresizingMaskIntoConstraints=false
//        lblTitle.font = UIFont(name: "ArialRoundedMTBold", size: 25)
//        lblTitle.numberOfLines = 0
//        self.addSubview(lblTitle)
//        
//        lblDescription.accessibilityIdentifier="lblDescription"
//        lblDescription.text = "If you have not already sent data to analyze, go to Manage Data"
//        lblDescription.translatesAutoresizingMaskIntoConstraints=false
////        lblDescription.font = UIFont(name: "ArialRoundedMTBold", size: 25)
//        lblDescription.numberOfLines = 0
//        self.addSubview(lblDescription)
//        
//        NSLayoutConstraint.activate([
//            lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
//            lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
////            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
//            
//            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: heightFromPct(percent: 1)),
//            lblDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
//            lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
//            
//            lblDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -5))
//        ])
//    }
//}


