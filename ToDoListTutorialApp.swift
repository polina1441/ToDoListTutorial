//
//  ToDoListTutorialApp.swift
//  ToDoListTutorial
//
//  Created by Полина Данилова on 09.05.2023.
//

import SwiftUI

@main
struct ToDoListTutorialApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        let context = persistenceController.container.viewContext
        let dateHolder = DateHolder(context)
        
        WindowGroup {
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateHolder)
        }
    }
}
