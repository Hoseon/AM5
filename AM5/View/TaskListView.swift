//
//  TaskListView.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/01/31.
//

import SwiftUI

struct TaskListView: View {
    // MARK: - PROPERTY
    @ObservedObject var taskListVM = TaskListViewModel()
    @State var presentAddNewItem = false
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach (taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                    }
                    .onDelete { indexSet in
                        print(indexSet)
                        self.taskListVM.removeTasks(atOffsets: indexSet)
                    }
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel.newTask()) { result in
                            if case .success(let task) = result {
                                self.taskListVM.addTask(task: task)
                            }
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Task")
                    }
                }
                .padding()
                .accentColor(Color(UIColor.systemRed))
            }
            .navigationBarTitle("Tasks")
        }
        
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    var onCommit: (Result<Task, InputError>) -> Void = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.completionStateIconName)
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
            TextField("Enter task title", text: $taskCellVM.task.title, onCommit: {
                if !self.taskCellVM.task.title.isEmpty {
                    self.onCommit(.success(self.taskCellVM.task))
                } else {
                    self.onCommit(.failure(.empty))
                }
            })
            .id(taskCellVM.id)
        }
    }
}
