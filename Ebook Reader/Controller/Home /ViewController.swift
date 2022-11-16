//
//  ViewController.swift
//  Ebook Reader
//
//  Created by Abhay Kmar on 02/11/22.
//

import UIKit
import DropDown
import PDFKit
import MobileCoreServices
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIDocumentPickerDelegate,UITextFieldDelegate {

    var isSideViewOpen: Bool = false
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var current_BookImage: UIImageView!
    @IBOutlet weak var current_BookName: UILabel!
    @IBOutlet weak var currentBook_AuthorName: UILabel!
    @IBOutlet weak var currentPercentage_OfBookRead: UILabel!
    @IBOutlet weak var tapToOpenBook_Lbl: UILabel!
    
    @IBOutlet weak var searchBtn_View: UIView!
    @IBOutlet weak var editBtn_View: UIView!
    @IBOutlet weak var bookShelf_View: UIView!
    @IBOutlet weak var navigation_View: UIView!
    @IBOutlet weak var currentBook_View: UIView!
    @IBOutlet weak var allMyEbook_View: UIView!
    @IBOutlet weak var collection_view: UIView!
    
    
  //  @IBOutlet weak var threeDotMenu_View: UIView!
    @IBOutlet weak var listView_Btn: UIButton!
    @IBOutlet weak var sorting_Btn: UIButton!
    
    
    @IBOutlet weak var currentTap_ToOpn: UIButton!
    @IBOutlet weak var search_Tf: UITextField!
    @IBOutlet weak var allBook_BgView: UIView!
    @IBOutlet weak var allBook_MenuView: UIView!
    @IBOutlet weak var select_a_CollectionLbl: UILabel!
    @IBOutlet weak var allEbook_Btn: UIButton!
    @IBOutlet weak var menuDescription: UILabel!
    @IBOutlet weak var threeDotMenu: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    
   // @IBOutlet weak var threeBarBtn: UIButton!
    @IBOutlet weak var allEBook_Btn: UIButton!
    
    @IBOutlet weak var booksCollectionView: UICollectionView!
    @IBOutlet weak var allBookMenu_TableView: UITableView!
    
    private var pdfView:PDFView?
    private var pdfDocument:PDFDocument?
    
    var booksDetailsList = [BooksData]()
    var filteredBookList = [BooksData]()
    var searching = false
    
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    let options2 = ["Sorting mode","By title","By author","Most read","Last read","By date added",]
    var menuOption:[String] = ["See all my ebooks","or pick a collection:","All my ebooks","Bought from eBooks.com","Imported from this device","Loans"]
    /*
    var booksImgArray:[String] = ["A little princess","a-christmas-carol","Adrift on the pacific","Alladin","Charles","DH Lawrence Original","Draculas-Guest","James Joyce","Story"]
    var bookAuthorNames:[String] = ["Hodgson Burnett","Charles Dickens","Edward S. Ellis","James Howard Kunstler","Charles Dickens","DH Lawrence","Bram Stoker","James Joyce","Enid Blyton"]
    var bookNames:[String] = ["A little princess","A-christmas-carol","Adrift on the pacific","Alladin","Barnaby Rudge","Aaron's Rod","Dracula's Gust","Dubliners","Summer Adventures"]
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        settingShadow()
        dropDownAction()
       // isSideViewOpen = false
    
        search_Tf.addTarget(self, action: #selector(searchBooks), for: .editingChanged)
        search_Tf.delegate = self
        
        
    }
    
    private func fillData(){
        let book1 = BooksData(bName: "A little princess", aName: "Hodgson Burnett", bImages: "A little princess")
        booksDetailsList.append(book1)
        let book2 = BooksData(bName: "A-christmas-carol", aName: "Charles Dickens", bImages: "a-christmas-carol")
        booksDetailsList.append(book2)
        let book3 = BooksData(bName: "Adrift on the pacific", aName: "Edward S. Ellis", bImages: "Adrift on the pacific")
        booksDetailsList.append(book3)
        let book4 = BooksData(bName: "Alladin", aName: "James Howard Kunstler", bImages: "Alladin")
        booksDetailsList.append(book4)
        let book5 = BooksData(bName: "Barnaby Rudge", aName: "Charles Dickens", bImages: "Charles")
        booksDetailsList.append(book5)
        let book6 = BooksData(bName: "Aaron's Rod", aName: "DH Lawrence", bImages: "DH Lawrence Original")
        booksDetailsList.append(book6)
        let book7 = BooksData(bName: "Dracula's Gust", aName: "Bram Stoker", bImages: "Draculas-Guest")
        booksDetailsList.append(book7)
        let book8 = BooksData(bName: "Dubliners", aName: "James Joyce", bImages: "James Joyce")
        booksDetailsList.append(book8)
        let book9 = BooksData(bName: "Summer Adventures", aName: "Enid Blyton", bImages: "Story")
        booksDetailsList.append(book9)
        
        
    }
    
    
    @objc func searchBooks(sender:UITextField){
        self.filteredBookList.removeAll()
        let searchData:Int = search_Tf.text!.count
        if searchData != 0
        {
            searching = true
            var i:Int = 0
            for books in booksDetailsList{
                if let  booksToSearch = search_Tf.text{
                    let range = books.booksName.lowercased().range(of: booksToSearch,options: .caseInsensitive,range: nil,locale: nil)
                    if range != nil{
                        self.filteredBookList.append(books)
                    }
                }
                i = i+1
            }
        }
        else{
            filteredBookList = booksDetailsList
            searching = false
        }
        booksCollectionView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    func loadPdf(paths:URL?){
        pdfView = PDFView(frame: self.view.bounds)
        let pdfVc = UIViewController()
        pdfVc.view.addSubview(pdfView!)
        pdfView?.autoScales = true
        pdfView?.displayMode = .singlePage
        pdfView?.displayDirection = .horizontal
        pdfView?.usePageViewController(true)
   
        guard let path = paths
        else{
            print("Unable to locate file")
            return
        }
        pdfDocument = PDFDocument(url: path)
        pdfView?.document = pdfDocument
        self.navigationController?.pushViewController(pdfVc, animated: true)
        
    }

    
    func settingShadow(){
        navigation_View.layer.shadowColor = UIColor.gray.cgColor
        navigation_View.layer.shadowOpacity = 0.5
        navigation_View.layer.shadowOffset = .zero
        navigation_View.layer.shadowRadius = 5
        
        allBook_BgView.layer.shadowColor = UIColor.gray.cgColor
        allBook_BgView.layer.shadowOpacity = 0.5
        allBook_BgView.layer.shadowOffset = .zero
        allBook_BgView.layer.shadowRadius = 5
        
//        threeDotMenu_View.layer.shadowColor = UIColor.gray.cgColor
//        threeDotMenu_View.layer.shadowOpacity = 0.5
//        threeDotMenu_View.layer.shadowOffset = .zero
//        threeDotMenu_View.layer.shadowRadius = 5
        
        allBook_MenuView.layer.shadowColor = UIColor.gray.cgColor
        allBook_MenuView.layer.shadowOpacity = 0.5
        allBook_MenuView.layer.shadowOffset = .zero
        allBook_MenuView.layer.shadowRadius = 5
       /*
        sideView.layer.shadowColor = UIColor.gray.cgColor
        sideView.layer.shadowOpacity = 1
        sideView.layer.shadowOffset = .zero
        sideView.layer.shadowRadius = 5
    */
        }
    
    
    
    func dropDownAction(){
        dropDown.anchorView = self.threeDotMenu
        dropDown.dataSource = options2
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.textColor = .black
        dropDown.selectionBackgroundColor = .clear
        dropDown.backgroundColor = .white
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if index == 0 {
                print("index zero Clicked")
            }
            else{
                print("index one Clicked")
                
            }
        }
    }
    
    @IBAction func current_TapToOpenBtn(_ sender: Any) {
        if self.current_BookName.text == "A little princess"{
            guard let pathUrl1 = Bundle.main.url(forResource: "a-little-princess-001-chapter-1-sara", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl1)
        }else if self.current_BookName.text == "A-christmas-carol"{
            guard let pathUrl2 = Bundle.main.url(forResource: "a-christmas-carol-002-stave-i", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl2)
        }else if self.current_BookName.text == "Adrift on the pacific"{
            guard let pathUrl3 = Bundle.main.url(forResource: "Adrift-on-the-Pacific-Booktree", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl3)
        }else if self.current_BookName.text == "Alladin"{
            guard let pathUrl3 = Bundle.main.url(forResource: "the-blue-fairy-book-001-aladdin-and-the-wonderful-lamp", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl3)
        }else if self.current_BookName.text == "Barnaby Rudge"{
            let webVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController")as!WebViewController
            self.navigationController?.pushViewController(webVC, animated: true)
        }else if self.current_BookName.text == "Aaron's Rod"{
            guard let pathUrl4 = Bundle.main.url(forResource: "Aaron's rod", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl4)
        }else if self.current_BookName.text == "Dracula's Gust"{
            guard let pathUrl5 = Bundle.main.url(forResource: "Dracula Guest", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl5)
        }else if self.current_BookName.text == "Dubliners"{
            guard let pathUrl6 = Bundle.main.url(forResource: "Dubliners", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl6)
        }else if self.current_BookName.text == "Summer Adventures"{
            guard let pathUrl7 = Bundle.main.url(forResource: "SummerAdventureSotry8.10.17", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl7)
        }
        
      // self.threeDotMenu_View.isHidden = true
    }
    
    
    
    
    
    
//    @IBAction func delete_EditVBtn(_ sender: Any) {
//    }
//    @IBAction func star_EditViewBtn(_ sender: Any) {
//    }
    @IBAction func tick_EditBtn(_ sender: Any) {
        self.editBtn_View.isHidden = true
        if currentBook_View.isHidden{
            currentBook_View.isHidden = false
        }
        if bookShelf_View.isHidden{
            bookShelf_View.isHidden = false
        }
        if allMyEbook_View.isHidden{
            allMyEbook_View.isHidden = false
        }
    }
    @IBAction func threeDot_SearchBtn(_ sender: Any) {
    }
    @IBAction func edit_SearchBtn(_ sender: Any) {
    }
    @IBAction func back_SearchBtn(_ sender: Any) {
        self.searchBtn_View.isHidden = true
        if currentBook_View.isHidden{
            currentBook_View.isHidden = false
        }
        if bookShelf_View.isHidden{
            bookShelf_View.isHidden = false
        }
        if allMyEbook_View.isHidden{
            allMyEbook_View.isHidden = false
        }
        booksCollectionView.reloadData()
    }
    @IBAction func list_Btn(_ sender: Any) {
    }
    @IBAction func sorting_Btn(_ sender: Any) {
       // self.threeDotMenu_View.isHidden = true
        dropDown.show()
    }
    @IBAction func allEbookBtn(_ sender: Any) {
        if allBook_MenuView.isHidden == true {
            self.allBook_MenuView.isHidden = false
        }else{
            self.allBook_MenuView.isHidden = true
        }
    }
   /*
    @IBAction func threeBar_Btn(_ sender: Any) {
     
        sideBar.isHidden = false
        sideView.isHidden = false
        self.view.bringSubviewToFront(sideView)
        if !isSideViewOpen{
            isSideViewOpen = true//0
            sideView.frame = CGRect(x: 0, y: 88, width: 0, height: 499)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 499)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)//1
            sideView.frame = CGRect(x: 0, y: 88, width: 259, height: 499)
            sideBar.frame = CGRect(x: 0, y: 0, width: 259, height: 499)
            UIView.commitAnimations()
            
        }else{
            sideBar.isHidden = true
            sideView.isHidden = true
            isSideViewOpen = false
            sideView.frame = CGRect(x: 0, y: 88, width: 259, height: 499)
            sideBar.frame = CGRect(x: 0, y: 0, width: 259, height: 499)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            sideView.frame = CGRect(x: 0, y: 88, width: 0, height: 499)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 499)
            UIView.commitAnimations()
        }
        if sideView.isHidden == false {
            self.scrollView.isScrollEnabled = false
        }else{
            self.scrollView.isScrollEnabled = true
        }
    }
    */
    @IBAction func setting_Btn(_ sender: Any) {
        let settingVc = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC")as! SettingVC
        self.navigationController?.pushViewController(settingVc, animated: true)
    }
    
    @IBAction func search_Btn(_ sender: Any) {
        if searchBtn_View.isHidden == true {
            searchBtn_View.isHidden = false
            self.bookShelf_View.isHidden = true
            self.currentBook_View.isHidden = true
        }else{
            searchBtn_View.isHidden = true
        }
    }
    
    @IBAction func edit_Btn(_ sender: Any) {
        
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.content","public.data","com.microsoft.word.doc",kUTTypePDF as String], in: UIDocumentPickerMode.import)
            documentPicker.delegate = self
            documentPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            if let popoverPresentationController = documentPicker.popoverPresentationController {
                popoverPresentationController.sourceView = (sender as! UIView)
            }

            self.present(documentPicker, animated: true, completion: nil)
        
        
        
//        let documentPicker = UIDocumentPickerViewController(documentTypes:[kUTTypePlainText as String,kUTTypeText as String, kUTTypePDF as String,"com.microsoft.word.doc"], in: .import)
//
//        documentPicker.delegate = self
//        present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func threeDotMenuBtn(_ sender: Any) {
//        if self.threeDotMenu_View.isHidden == true{
//            self.threeDotMenu_View.isHidden = false
//        }else{
//            self.threeDotMenu_View.isHidden = true
//        }
        dropDown.show()
    }
    
    
    @IBAction func close_Btn(_ sender: Any) {
        self.allBook_MenuView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfItems = 1
        switch tableView {
        case allBookMenu_TableView:
            numberOfItems = menuOption.count
       // case sideBar:
         //   numberOfItems = arrdata.count
        default:
            print("Somthing went wrong")
        }
        return numberOfItems
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView{
        case allBookMenu_TableView:
            let cell1 = allBookMenu_TableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell")as! MenuTableViewCell
            cell1.textLabel?.text = menuOption[indexPath.row]
            cell = cell1
       /*
        case sideBar:
            let cell2 = sideBar.dequeueReusableCell(withIdentifier: "MenuTVC")as! MenuTVC
            cell2.textLabel?.text = arrdata[indexPath.row]
            cell2.detailTextLabel?.text = arrdataForSubtitle[indexPath.row]
            cell = cell2
        */
        default:
            print("Something went wrong")
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView{
        case allBookMenu_TableView:
            let cell = allBookMenu_TableView.cellForRow(at: indexPath)as! MenuTableViewCell
            if indexPath.row == 0 {
                
            }
      /*
        case sideBar:
          //  let cell1 = allBookMenu_TableView.cellForRow(at: indexPath)as! MenuTVC
            if indexPath.row == 0 {
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            
            if indexPath.row == 1 {
                let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")as! ViewController
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
            if indexPath.row == 2 {
                let collVC = self.storyboard?.instantiateViewController(withIdentifier: "CollectionsVC")as! CollectionsVC
                self.navigationController?.pushViewController(collVC, animated: true)
            }
            if indexPath.row == 3{
                let documentPicker = UIDocumentPickerViewController(documentTypes:[kUTTypePlainText as String,kUTTypeText as String,"com.microsoft.word.doc"], in: .import)
                
                documentPicker.delegate = self
                present(documentPicker, animated: true, completion: nil)
            }
            if indexPath.row == 4 {
                let dwnlodVC = self.storyboard?.instantiateViewController(withIdentifier: "DownLoadVC") as! DownLoadVC
                self.navigationController?.pushViewController(dwnlodVC, animated: true)
            }
            
   */
        default:
            print("Something went wrong")
        }
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: [URL]) {
        guard let selectedFileUrl = url.first else{return}
        print("url Of selected file ",selectedFileUrl)
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let sandBoxFileURL = dir?.appendingPathComponent(selectedFileUrl.lastPathComponent)
        if FileManager.default.fileExists(atPath: sandBoxFileURL!.path){
            print("Already exist")
        }else {
            do{
                try FileManager.default.copyItem(at: selectedFileUrl, to: sandBoxFileURL!)
                print("Copied File")
            }catch{
                print("Error\(error)")
            }
        }
    }
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return filteredBookList.count
        }else{
            return booksDetailsList.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = booksCollectionView.dequeueReusableCell(withReuseIdentifier: "BooksCVCell", for: indexPath) as! BooksCVCell
        if searching {
            cell.bookName_Lbl.text = filteredBookList[indexPath.row].booksName
            cell.author_Lbl.text = filteredBookList[indexPath.row].booksAuthorName
            cell.bookImage.image = UIImage(named: filteredBookList[indexPath.row].booksImages)
        }else{
            cell.bookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
            cell.bookName_Lbl.text = booksDetailsList[indexPath.row].booksName
            cell.author_Lbl.text = booksDetailsList[indexPath.row].booksAuthorName
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeWH = booksCollectionView.bounds.width
        return CGSize(width:sizeWH/3.5 , height:sizeWH/2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = booksCollectionView.cellForItem(at: indexPath)as! BooksCVCell
        if indexPath.row == 0 {
            self.current_BookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
            self.current_BookName.text = booksDetailsList[indexPath.row].booksName
            self.currentBook_AuthorName.text = booksDetailsList[indexPath.row].booksAuthorName
            guard let pathUrl1 = Bundle.main.url(forResource: "a-little-princess-001-chapter-1-sara", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl1)
        }
        if indexPath.row == 1 {
            self.current_BookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
            self.current_BookName.text = booksDetailsList[indexPath.row].booksName
            self.currentBook_AuthorName.text = booksDetailsList[indexPath.row].booksAuthorName
            guard let pathUrl2 = Bundle.main.url(forResource: "a-christmas-carol-002-stave-i", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl2)
        }
        if indexPath.row == 2{
            self.current_BookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
            self.current_BookName.text = booksDetailsList[indexPath.row].booksName
            self.currentBook_AuthorName.text = booksDetailsList[indexPath.row].booksAuthorName
            guard let pathUrl3 = Bundle.main.url(forResource: "Adrift-on-the-Pacific-Booktree", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl3)
        }
        if indexPath.row == 3{
            self.current_BookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
            self.current_BookName.text = booksDetailsList[indexPath.row].booksName
            self.currentBook_AuthorName.text = booksDetailsList[indexPath.row].booksAuthorName
            guard let pathUrl4 = Bundle.main.url(forResource: "the-blue-fairy-book-001-aladdin-and-the-wonderful-lamp", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl4)
        }
        if indexPath.row == 4{
            self.current_BookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
            self.current_BookName.text = booksDetailsList[indexPath.row].booksName
            self.currentBook_AuthorName.text = booksDetailsList[indexPath.row].booksAuthorName
            
            let webVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController")as!WebViewController
            webVC.filetype = "txt"
            self.navigationController?.pushViewController(webVC, animated: true)
        }
        if indexPath.row == 5{
            self.current_BookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
            self.current_BookName.text = booksDetailsList[indexPath.row].booksName
            self.currentBook_AuthorName.text = booksDetailsList[indexPath.row].booksAuthorName
            guard let pathUrl5 = Bundle.main.url(forResource: "Aaron's rod", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl5)
        }
        if indexPath.row == 6{
            self.current_BookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
            self.current_BookName.text = booksDetailsList[indexPath.row].booksName
            self.currentBook_AuthorName.text = booksDetailsList[indexPath.row].booksAuthorName
            guard let pathUrl6 = Bundle.main.url(forResource: "Dracula Guest", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl6)
        }
        if indexPath.row == 7{
            self.current_BookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
            self.current_BookName.text = booksDetailsList[indexPath.row].booksName
            self.currentBook_AuthorName.text = booksDetailsList[indexPath.row].booksAuthorName
            let webVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController")as!WebViewController
            webVC.filetype = "doc"
            self.navigationController?.pushViewController(webVC, animated: true)
            /*
            guard let pathUrl7 = Bundle.main.url(forResource: "Dubliners", withExtension: "pdf")
            else{
                print("Unable to locate file")
                return
            }
            loadPdf(paths: pathUrl7)
       */
        }
        if indexPath.row == 8{
            
            let bvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
            bvc.modalPresentationStyle = .fullScreen
            let bi = BookInformation()
            bi.bookCode = 0
            bi.position = 0
            bi.fileName = "Alice.epub"
            bvc.bookInformation = bi
            self.present(bvc, animated: false, completion: nil)
//            self.current_BookImage.image = UIImage(named: booksDetailsList[indexPath.row].booksImages)
//            self.current_BookName.text = booksDetailsList[indexPath.row].booksName
//            self.currentBook_AuthorName.text = booksDetailsList[indexPath.row].booksAuthorName
//            guard let pathUrl8 = Bundle.main.url(forResource: "SummerAdventureSotry8.10.17",      withExtension: "pdf")
//            else{
//                print("Unable to locate file")
//                return
//            }
//            loadPdf(paths: pathUrl8)
        }
    }
}
