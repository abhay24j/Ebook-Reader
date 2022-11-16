//
//  DownLoadVC.swift
//  Ebook Reader
//
//  Created by Abhay Kmar on 11/11/22.
//

import UIKit

class DownLoadVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    

    @IBOutlet weak var overAll_SelectState_Btn: UIButton!
    @IBOutlet weak var threeBar_Btn: UIButton!
    @IBOutlet weak var threeDot_Btn: UIButton!
    @IBOutlet weak var selectState_Btn: UIButton!
    @IBOutlet weak var top_View: UIView!
    @IBOutlet weak var selectState_View: UIView!
    @IBOutlet weak var menuTbl: UITableView!
    @IBOutlet weak var menuBack_View: UIView!
    
    @IBOutlet weak var error_View: UIView!
    @IBOutlet weak var queue_View: UIView!
    @IBOutlet weak var Completed_View: UIView!
    
    
    var isOpen:Bool = true
    
    @IBOutlet weak var selectState_Lbl: UILabel!
    
    var statesArr:[String] = ["All","Active","Completed","With Error"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    @IBAction func threeBars_Btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func threeDots_Btn(_ sender: Any) {
    }
    
    @IBAction func selectState_Btn(_ sender: Any) {
    }
    
    @IBAction func allOverSelectStates_Btn(_ sender: Any) {
        if menuBack_View.isHidden{
            menuBack_View.isHidden = false
            self.selectState_Btn.setImage(UIImage(named: "caret-arrow-up"), for: .normal)
        }else{
            menuBack_View.isHidden = true
            self.selectState_Btn.setImage(UIImage(named: "down-arrow"), for: .normal)
        }
        if selectState_Lbl.text != "Select state"{
            selectState_Lbl.text = "Select state"
        }
//        self.queue_View.isHidden = true
//        self.error_View.isHidden = true
//        self.error_View.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTbl.dequeueReusableCell(withIdentifier: "MenuTblViewCell")as! MenuTblViewCell
        cell.textLabel?.text = statesArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = menuTbl.cellForRow(at: indexPath)as! MenuTblViewCell
        menuTbl.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if indexPath.row == 0 {
            self.selectState_Lbl.text = "All"
            self.menuBack_View.isHidden = true
            self.selectState_Btn.setImage(UIImage(named: "down-arrow"), for: .normal)
            if self.queue_View.isHidden{
                self.queue_View.isHidden = false
            }
            if self.Completed_View.isHidden{
                self.Completed_View.isHidden = false
            }
            if self.error_View.isHidden{
                self.error_View.isHidden = false
            }
        }
        if indexPath.row == 1 {
            self.selectState_Lbl.text = "Active"
            self.menuBack_View.isHidden = true
            self.selectState_Btn.setImage(UIImage(named: "down-arrow"), for: .normal)
           // self.queue_View.isHidden = true
            if Completed_View.isHidden {
                Completed_View.isHidden = false
            }
            self.Completed_View.isHidden = true
            self.error_View.isHidden = true
        }
        if indexPath.row == 2 {
            self.selectState_Lbl.text = "Completed"
            self.menuBack_View.isHidden = true
            self.selectState_Btn.setImage(UIImage(named: "down-arrow"), for: .normal)
            
            if Completed_View.isHidden {
                Completed_View.isHidden = false
                queue_View.isHidden = true
            }
     
        }
        if indexPath.row == 3 {
            self.selectState_Lbl.text = "With Error"
            self.menuBack_View.isHidden = true
            self.selectState_Btn.setImage(UIImage(named: "down-arrow"), for: .normal)
            self.queue_View.isHidden = true
            self.Completed_View.isHidden = true
            if error_View.isHidden{
                error_View.isHidden = false
            }
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        menuTbl.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
