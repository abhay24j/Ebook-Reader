//
//  AppDelegate.swift
//  Ebook Reader
//
//  Created by Abhay Kmar on 02/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.installSamples()
        return true
    }
    
    
    // get documents folder
    func getDocumentsPath() ->String {
        var documentsPath : String
        documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentsPath
    }
    
    // create books folder to store epub books under documents folder.
    func createBooksDirectory() {
        let docPath = self.getDocumentsPath()
        let booksDir = docPath + "/books"
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: booksDir) {
            do {
                try fileManager.createDirectory(atPath: booksDir, withIntermediateDirectories: true, attributes: nil)
                print(booksDir+" is created successfully")
            } catch {
                print("Couldn't create bools directory")
            }
        }else {
            print(booksDir+" has been already created!")
        }
    }
    
    func getBooksDirectory()->String {
        self.createBooksDirectory()
        let path = self.getDocumentsPath()+"/books"
        return path
    }
    
    func getBookPath(fileName:String) ->String {
        let booksDir = self.getBooksDirectory()
        let path = booksDir+"/"+fileName
        return path
    }
    
    func copyFileFromBundleToBooks(fileName:String) {
        let fileManager = FileManager.default
        let bookPath = self.getBookPath(fileName:fileName)
        
        let bundle = Bundle.main
        let path = bundle.resourcePath! + "/" + fileName
        do {
            try fileManager.copyItem(atPath: path, toPath: bookPath)
        }catch {
            print(error)
        }
    }
    
    func installSamples() {
        let fileName = "Alice.epub"
        let samplePath = self.getBookPath(fileName: fileName)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: samplePath) {
            createBooksDirectory()
            copyFileFromBundleToBooks(fileName: fileName)
        }else {
            print(fileName+" has been already installed!")
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

