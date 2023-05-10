//
//  DateHolder.swift
//  ToDoListTutorial
//
//  Created by Полина Данилова on 10.05.2023.
//

import Foundation
import CoreData

 class DateHolder : ObservableObject {
     
     init(_ context : NSManagedObjectContext){
         
     }
     
    func saveContext(_ context : NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
