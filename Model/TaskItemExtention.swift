//
//  TaskItemExtention.swift
//  ToDoListTutorial
//
//  Created by Полина Данилова on 12.05.2023.
//

import SwiftUI

extension TaskItem {
    func isCompleted() -> Bool {
        return completedDate != nil
    }
}
