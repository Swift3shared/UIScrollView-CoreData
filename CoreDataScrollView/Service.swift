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
    
    class func updateUser(oldUser: User, newUser : User) {
        
        let predicate = NSPredicate(format: "userName == %@ and password == %@", oldUser.userName!, oldUser.password!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = predicate
        
        do {
            let fetchedEntities = try Service.context().fetch(fetchRequest) as! [User]
            fetchedEntities.first?.userName = "sok"
            // ... Update additional properties with new values
        } catch {
            // Do something in response to error condition
        }
        
        Service.delegate().saveContext()
        
        // Create Entity Description
        //let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: Service.context())
        
        // Initialize Batch Update Request
        
      //  let batchUpdateRequest = NSBatchUpdateRequest(entity: entityDescription!)
        
        // Configure Batch Update Request
       // batchUpdateRequest.resultType = .updatedObjectIDsResultType
       // batchUpdateRequest.propertiesToUpdate = newUser as? [AnyHashable : Any]
        
//        do {
//            let managedObject = try Service.context().execute(batchUpdateRequest) as! NSBatchUpdateResult
//            Service.context().object(with: oldUser.objectID)
//            Service.context().refreshObject(managedObject, mergeChanges: false)
//            Service.delegate().saveContext()
//        } catch {
//            let updateError = error as NSError
//            print("\(updateError), \(updateError.userInfo)")
//        }
    }
    
    class func messageBoxAlert (withTitle title : String, forMessage message : String ) -> UIAlertController {
        let okAction = UIAlertAction(title: "OK", style: .default)
        let uiAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        uiAlert.addAction(okAction)
        return uiAlert
    }
}

