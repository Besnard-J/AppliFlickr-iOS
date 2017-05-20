//
//  Favoris.swift
//  ClientFilckrPerso
//
//  Created by Apple on 06/04/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Favoris {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    // - create entity -
    let employe = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
    
    employe.firstname = "Machin"
    employe.lastname = "Bidule"
    
    // - save entity -
    appDelegate.saveContext()
    
    context.perform {
    
    // - flech entity -
    //let employeFlecthRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
    let employeFlecthRequest : NSFetchRequest<Person> = Person.fetchRequest()
    employeFlecthRequest.predicate = NSPredicate(format: "firstname == %@","Machin")
    employeFlecthRequest.sortDescriptors = [NSSortDescriptor(key: "lastname",ascending: false)]
    
    
    do {
    let flecthPerson =  try employeFlecthRequest.execute()
    print(flecthPerson)
    //let flecthPerson =  try context.execute(employeFlecthRequest) as! [Person]
    }
    
    catch{
    fatalError("Failled to flecth employe: \(error)")
    }
    }
}
