//
//  TaskEditView.swift
//  ToDoListTutorial
//
//  Created by Полина Данилова on 09.05.2023.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
        
    
    @State var selectedTaskItem : TaskItem?
    @State var name : String
    @State var desc : String
    @State var deadline : Date
    @State var scheduleTime : Bool
    
    init(passedTaskItem: TaskItem?, initialDate: Date){
        if let taskItem = passedTaskItem {
            _selectedTaskItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _deadline = State(initialValue: taskItem.deadline ?? initialDate)
            _scheduleTime  = State(initialValue: taskItem.scheduleTime)
        } else {
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _deadline = State(initialValue: initialDate)
            _scheduleTime  = State(initialValue: false)
        }
    }
   
    var body: some View {
        Form {
            Section(header: Text("Task")) {
                TextField("Title", text: $name)
                TextField("Description", text: $desc)
            }
            Section(header: Text("Due Date")) {
                Toggle("Schedule Time", isOn: $scheduleTime)
                DatePicker("Deadline", selection: $deadline, displayedComponents: displayComps())
            }
//            if selectedTaskItem?.isCompleted() ?? false {
//                Section(header: Text("Completed")){
//                    Text(selectedTaskItem?.completedDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
//                        .foregroundColor(.green)
//                }
//            }
            Section(){
                Button("Save", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    func displayComps() -> DatePickerComponents{
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    func saveAction(){
        withAnimation{
            if selectedTaskItem == nil{
                selectedTaskItem = TaskItem(context: viewContext)
            }
            selectedTaskItem?.created = Date()
            selectedTaskItem?.name = name
            selectedTaskItem?.deadline = deadline
            selectedTaskItem?.scheduleTime = scheduleTime
    
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(passedTaskItem: TaskItem(), initialDate: Date())
    }
}
