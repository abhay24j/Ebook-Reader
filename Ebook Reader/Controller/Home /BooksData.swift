//
//  BooksData.swift
//  Ebook Reader
//
//  Created by Abhay Kmar on 14/11/22.
//

import Foundation
class BooksData{
    var booksName:String
    var booksAuthorName:String
    var booksImages:String

    init(bName:String,aName:String,bImages:String){
        self.booksName = bName
        self.booksAuthorName = aName
        self.booksImages = bImages
    }
    init(){
        booksName = ""
        booksAuthorName = ""
        booksImages = ""
    }
}
