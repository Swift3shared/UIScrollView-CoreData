//
//  Service.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/20/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit
import CoreData

class Service{
    class func delegate () -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    class func context () -> NSManagedObjectContext {
        return self.delegate().persistentContainer.viewContext
    }
    
    class func isVerified (string firsValue : String, cmpareTo secondValue : String) -> Bool {
        return firsValue == secondValue
    }
    
    class func isNotEmptyTextField(contentOf textFields : UITextField...) -> Bool {
        for eachTextField in textFields {
            if eachTextField.text! == "" {
                return false
            }
        }
        return true
    }
    
    class func login(_ user : User) -> Bool {
        
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        do{
            let users : [User] = try Service.context().fetch(fetchRequest)
            for user in users {
                
            }
        } catch {
            let error = error as NSError
            print("*** ERROR *** \(error)")
        }
        return false
    }
    
    class func messageBoxAlert (withTitle title : String, forMessage message : String) -> UIAlertController {
        let okAction = UIAlertAction(title: "OK", style: .default)
        let uiAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        uiAlert.addAction(okAction)
        return uiAlert
    }
}

