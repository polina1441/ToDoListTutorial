//
//  ContentView.swift
//  ToDoListTutorial
//
//  Created by Полина Данилова on 09.05.2023.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.deadline, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TaskItem>

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach(items) { taslItem in
                            NavigationLink(destination: TaskEditView(passedTaskItem: taslItem, initialDate: Date())
                                .environmentObject(dateHolder)) {
                                Text(taslItem.deadline!, formatter: itemFormatter)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                    HStack {
                        Spacer()
                        FloatingButton()
                            .offset(y: 260)
                            .environmentObject(dateHolder)
                    }
                }
            }.navigationTitle("TODO List")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            dateHolder.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
