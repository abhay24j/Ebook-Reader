//
//  CollectionsVC.swift
//  Ebook Reader
//
//  Created by Abhay Kmar on 09/11/22.
//

import UIKit

class CollectionsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var threeBarBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var topHeadDisLbl: UILabel!
    
    @IBOutlet weak var collectionsLbl: UILabel!
    
    @IBOutlet weak var collectionsTbl: UITableView!
    
    var items:[String] = ["All my ebooks","Bought from ebooks.com","Imported from this device","Loans"]
    //var items = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Add Collection", message: "", preferredStyle: .alert)
     
        
        alert.addTextField { field in
            field.placeholder = "Collection title"
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    DispatchQueue.main.async {
                        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                        currentItems.append(text)
                        UserDefaults.standard.setValue(currentItems, forKey: "items")
                        self.items.append(text)
                        self.collectionsTbl.reloadData()
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
    @IBAction func searchBtn(_ sender: Any) {
    }
    
    @IBAction func threeBarsBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionsTbl.dequeueReusableCell(withIdentifier: "CollectionsTVC")as! CollectionsTVC
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
    
    
}
