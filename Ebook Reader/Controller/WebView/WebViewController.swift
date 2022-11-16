//
//  WebViewController.swift
//  Ebook Reader
//
//  Created by Abhay Kmar on 04/11/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var document_Viewer: WKWebView!
    var filetype:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        showFiles()
    }
//    func showFiles(){
//        let docURL = Bundle.main.url(forResource: "file-sample_100kB", withExtension: "doc")!
//        let docContents = try! Data(contentsOf: docURL)
//        let urlStr = "data:application/msword;base64," + docContents.base64EncodedString()
//        let url = URL(string: urlStr)!
//        let request = URLRequest(url: url)
//        self.document_Viewer.load(request)
//
//    }
    func showFiles(){
        if filetype == "txt"{
            let path = Bundle.main.path(forResource: "bern", ofType: "txt")
            let url = URL(fileURLWithPath: path!)
            let request = URLRequest(url: url)
            self.document_Viewer.load(request)
            
        }else{
            let path = Bundle.main.path(forResource: "sample", ofType: "doc")
            let url = URL(fileURLWithPath: path!)
            let request = URLRequest(url: url)
            self.document_Viewer.load(request)
        }
        

    }
    
    @IBAction func back_Btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
