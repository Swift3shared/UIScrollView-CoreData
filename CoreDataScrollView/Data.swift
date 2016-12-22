//
//  Data.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/20/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit

var provinces : [String] = ["Phnom Penh", "Kan Dal", "Takeo", "Svay Reang", "Prev Veng", "Bat Tam Bang", "Pailin"]

var imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
                 "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
                 "http://algoos.com/wp-content/uploads/2015/08/ireland-02.jpg",
                 "http://bdo.se/wp-content/uploads/2014/01/Stockholm1.jpg",
                 "https://i.ytimg.com/vi/c7oV1T2j5mc/maxresdefault.jpg",
                 "https://s-media-cache-ak0.pinimg.com/originals/61/df/42/61df422d112485beb7c10be2c29acee5.jpg",
                 "https://images6.alphacoders.com/488/thumb-350-488291.jpg",
                 "https://wallpaperscraft.com/imagedota_2_art_heroes_93924_602x339.jpg"]

var imageCategory : [UIImage] = [#imageLiteral(resourceName: "book"),#imageLiteral(resourceName: "Dota2"),#imageLiteral(resourceName: "bmw")]

enum categoryType {
    case book
    case dota2
    case car
}

var bookURLs = [
    "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSzmWhSjnn6gnxLr-s57YPd0TeNvyh0JT6lXMLP_7jX58jHOk6U",
    "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTEd2f6OVQezMp7T17CqVaF3_ZEhGWS0fCvG-BF_V2G5FMvWEjt",
    "http://2.bp.blogspot.com/_gSqWmU1tR5k/TTkLQd-KD0I/AAAAAAAAEAg/Z4VaR5_VTAw/s1600/93703645.JPG",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQwG8eqlYVy6r3EWXYclEhWDBbWoFwtteAf9B4J3JXgylzKLLicXg"
]

//struct UserModel {
//    var oldUserName     : String!
//    var userName        : String!
//    var password        : String!
//    var dateOfBirth     : String!
//    var placeOfBirth    : String!
//    
//    init(userName : String, password : String, dateOfBirth : String, placeOfBirth : String) {
//        self.userName       = userName
//        self.password       = password
//        self.dateOfBirth    = dateOfBirth
//        self.placeOfBirth   = placeOfBirth
//    }
//    
//    init () {}
//}
