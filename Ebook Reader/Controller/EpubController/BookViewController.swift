//
//  BookViewController.swift
//  Ebook Reader
//
//  Created by Abhay Kmar on 15/11/22.
//

import UIKit

class BookViewController: UIViewController,ReflowableViewControllerDataSource,ReflowableViewControllerDelegate,SkyProviderDataSource {

    @IBOutlet weak var skyepubView: UIView!
    var bookCode:Int = -1
    var bookInformation:BookInformation!
    var rv:ReflowableViewController!
    var ad:AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ad = UIApplication.shared.delegate as? AppDelegate
        self.makeBookViewer()
        // Do any additional setup after loading the view.
    }
    func getBookPath()->String {
        let bookPath:String = "\(rv.baseDirectory!)/\(rv.fileName!)"
        return bookPath
    }
    
    @IBAction func back_Btn(_ sender: Any) {
      //  self.navigationController?.popViewController(animated: true)
        let hVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")as! ViewController
        self.navigationController?.pushViewController(hVC, animated: true)
    }
    func makeBookViewer() {
        // make ReflowableViewController object for epub.
        rv = ReflowableViewController(startPagePositionInBook: self.bookInformation.position)
        // set the color for blank screen.
        rv.setBlankColor(UIColor.white)
        // set the inital background color.
        rv.changeBackgroundColor(UIColor.white)
        // global pagination mode 0
        rv.setPagingMode(0)
        // set rv's datasource to self.
        rv.dataSource = self
        // set rv's delegate to self.
        rv.delegate = self
        
        // set filename and bookCode to open.
        rv.fileName = self.bookInformation!.fileName
        rv.bookCode = self.bookInformation!.bookCode
        self.bookCode = Int(self.bookInformation!.bookCode)

        // set baseDirector of rv to booksDirectory
        rv.baseDirectory = ad.getBooksDirectory()
        
        // since 8.5.0, the path of epub can be set by setBookPath.
        rv.setBookPath(self.getBookPath())

        // set the font of rv
        rv.fontSize = Int32(self.getRealFontSize(fontSizeIndex: 2))
        // set lineSpacing of rv
        rv.lineSpacing = Int32(self.getRealLineSpacing(3))
        rv.fontName = "Book Fonts"
        // 0: none, 1:slide transition, 2: curling transition.
        rv.transitionType = 2
        // if true, sdk will show 2 pages when screen is landscape.
        rv.setDoublePagedForLandscape(true)
        // if true, sdk will use gloabal pagination.
        rv.setGlobalPaging(false)
        
        // 25% space (in both left most and right most margins)
        rv.setHorizontalGapRatio(0.25)
        // 20% space (in both top and bottom margins)
        rv.setVerticalGapRatio(0.10)
        
        // set License Key for Reflowable Layout
        rv.setLicenseKey("0000-0000-0000-0000");
        
        // make SkyProvider object to read epub reader.
        let skyProvider:SkyProvider = SkyProvider()
        // set skyProvider datasource
        skyProvider.dataSource = self
        // set skyProvider book to rv's book
        skyProvider.book = rv.book
        // set the content provider of rv as skyProvider
        rv.setContentProvider(skyProvider)
        // set the coordinates and size of rv
        rv.view.frame = self.skyepubView.bounds
        rv.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        // add tv to skyepubView which is made in story board as a container of epub viewer.
        self.skyepubView.addSubview(rv.view)
        self.addChild(rv)
        self.view.autoresizesSubviews = true
    }
    
    // returns real font size for given font size Index
    func getRealFontSize(fontSizeIndex:Int) ->Int {
        var rs:Int = 0
        switch fontSizeIndex {
        case 0:
            rs = 15
        case 1:
            rs = 17
        case 2:
            rs = 20
        case 3:
            rs = 24
        case 4:
            rs = 27
        default:
            rs = 20
        }
        return rs
    }
    
    // returns real line spacing for given line spacing Index
    func getRealLineSpacing(_ lineSpaceIndex:Int) ->Int {
        var rs:Int = 0
        switch lineSpaceIndex {
        case 0:
            rs = -1
        case 1:
            rs = 125
        case 2:
            rs = 150
        case 3:
            rs = 165
        case 4:
            rs = 180
        case 5:
            rs = 200
        default:
            rs = 150
        }
        return rs
    }

}

