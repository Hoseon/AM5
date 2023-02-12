//
//  TaskCell.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/02/01.
//

import SwiftUI

struct TaskCell: View {
    // MARK: - PROPERTY
    var task: Task
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
            Text(task.title)
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    private var task: Task
    
    static var previews: some View {
        TaskCell(task: self.task)
    }
}
