//
//  Service.swift
//  CoreDataScrollView
//
//  Created by sok channy on 12/20/16.
//  Copyright © 2016 nini. All rights reserved.
//

import UIKit
import CoreData

typealias SuccessHandler = (User) -> ()
typealias ErrorHandler = (String) -> ()

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
                CDSAnimation.shake(eachTextField)
                return false
            }
        }
        return true
    }
    
    class func login(_ username : String, _ password : String, success : SuccessHandler, error : ErrorHandler) {
        
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        do{
            let users : [User] = try Service.context().fetch(fetchRequest)
            
            for eachUser in users {
                print(eachUser.userName)
                print(eachUser.password)
            }
            
            for eachUser in users {
                if eachUser.userName == username && eachUser.password == password {
                    success(eachUser)
                    return
                }
            }
        } catch {
            let error = error as NSError
            print("*** ERROR *** \(error)")
        }
        error("User name and password is not match.")
        
    }
    
    class func save(){
        
    }
    
    class func updateUser(oldUser: User, newUser : [String:String]) {
        
        let predicate = NSPredicate(format: "userName == %@ and password == %@", oldUser.userName!, oldUser.password!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = predicate
        
        do {
            let fetchedEntities = try Service.context().fetch(fetchRequest) as! [User]
            fetchedEntities.first?.userName     = newUser["userName"]
            fetchedEntities.first?.dateOfBirth  = newUser["dateOfBirth"]
            fetchedEntities.first?.placeOfBirth = newUser["placeOfBirth"]
        } catch {
            // Do something in response to error condition
        }
        Service.delegate().saveContext()
    }
    
    class func messageBoxAlert (withTitle title : String, forMessage message : String ) -> UIAlertController {
        let okAction = UIAlertAction(title: "OK", style: .default)
        let uiAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        uiAlert.addAction(okAction)
        return uiAlert
    }
    
    
    
}

