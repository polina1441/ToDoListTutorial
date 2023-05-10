//
//  FloatingButton.swift
//  ToDoListTutorial
//
//  Created by Полина Данилова on 09.05.2023.
//

import SwiftUI

struct FloatingButton: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        HStack{
            NavigationLink(destination: TaskEditView(passedTaskItem: nil, initialDate: Date())
                .environmentObject(dateHolder)) {
                Text("+ New Task")
                    .font(.headline)
            }
            .padding(16)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(30)
            .padding(16)
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
