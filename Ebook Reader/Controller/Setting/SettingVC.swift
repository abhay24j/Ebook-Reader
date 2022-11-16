//
//  SettingVC.swift
//  Ebook Reader
//
//  Created by Abhay Kmar on 10/11/22.
//

import UIKit

class SettingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var top_NavView: UIView!
    @IBOutlet weak var check_Box: UIButton!
    
    var headLines:[String] = ["Enable Online Synchronization","Sync Only on Wi-Fi","Download ebooks on Wi-Fi only","Enable notifications"]
    var subTitle:[String] = ["of your reading progress, margin notes, bookmarks, etc. this means that, when you replace this device, everything will be just the same when you open the new device.","Careful- unchecking this option may incur additional mobile data charges.","Uncheck this to enable the app to download ebooks via your mobile phone data service. Careful - doing so many incur additional mobile data charges.",""]
    var options_WithNoBox:[String] = ["Ad Options","Manage Subscriptions","Terms of Use and Licenses","Privacy Policy","Release Notes",]
    
    @IBOutlet weak var settingTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        top_NavView.layer.shadowColor = UIColor.gray.cgColor
        top_NavView.layer.shadowOpacity = 0.5
        top_NavView.layer.shadowOffset = .zero
        top_NavView.layer.shadowRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func back_Btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tick_Btn(_ sender: Any) {
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return headLines.count
        case 1:
            return options_WithNoBox.count
            
        default:
            print("Invalid Range")
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = settingTbl.dequeueReusableCell(withIdentifier: "SettingTVC", for: indexPath) as! SettingTVC
            cell.headLine_Lbl.text = headLines[indexPath.row]
            cell.subTitle_Lbl.text = subTitle[indexPath.row]
            return cell
        case 1:
            let cell = settingTbl.dequeueReusableCell(withIdentifier: "SettingTVC_NoBox", for: indexPath) as! SettingTVC_NoBox
            cell.setting_Lbl.text = options_WithNoBox[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}
