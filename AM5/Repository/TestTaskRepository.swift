//
//  TaskRepository.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/02/01.
//

import Foundation
import Disk
import FirebaseFirestore
import Combine
import Resolver

class BaseTaskRepository {
    @Published var tasks = [Task]()
}

protocol TaskRepository: BaseTaskRepository {
    func addTask(_ task: Task)
    func removeTask(_ task: Task)
    func updateTask(_ task: Task)
}

//class TestDataTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
//    override init() {
//        super.init()
////        self.tasks = testDataTasks
//    }
//
//    func addTask(_ task: Task) {
//        tasks.append(task)
//    }
//
//    func removeTask(_ task: Task) {
//        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
//            tasks.remove(at: index)
//        }
//    }
//
//    func updateTask(_ task: Task) {
//        if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
//            self.tasks[index] = task
//        }
//    }
//}

class LocalTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
    override init() {
        super.init()
        loadData()
    }
    
    func addTask(_ task: Task) {
        self.tasks.append(task)
        saveData()
        //데이터 세이브 필요
        
    }
    
    func removeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            saveData()
            //데이터 세이브 필요
        }
    }
    
    func updateTask(_ task: Task) {
        if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
            self.tasks[index] = task
            //데이터 세이브 필요
            saveData()
        }
    }
    
    private func loadData() {
        if let retrievedTasks = try? Disk.retrieve("tasks.json", from: .documents, as: [Task].self) {
            self.tasks = retrievedTasks
        }
    }
    
    private func saveData() {
        do {
            try Disk.save(self.tasks, to: .documents, as: "tasks.json")
        } catch let error as NSError {
            fatalError("""
                 Domain: \(error.domain)
                 Code: \(error.code)
                 Description: \(error.localizedDescription)
                 Failure Reason: \(error.localizedFailureReason ?? "")
                 Suggestions: \(error.localizedRecoverySuggestion ?? "")
            """)
        }
    }
}

class FireStoreTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
    var db = Firestore.firestore()
    
    @Injected var authenticationService: AuthenticationService
    var tasksPath: String = "tasks"
    var userId: String = "unknown"
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        //값이 변할때 리로드 되게 한다.
        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.loadData()
            }
            .store(in: &cancellables)
    }
    
    private func loadData() {
        db.collection(tasksPath)
            .whereField("userId", isEqualTo: self.userId)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnashot, error) in
            if let querySnashot = querySnashot {
                self.tasks = querySnashot.documents.compactMap { documnet -> Task? in
                    try? documnet.data(as: Task.self)
                }
            }
        }
    }
    
    func addTask(_ task: Task) {
        do {
            var userTask = task
            userTask.userId = self.userId
            print(userTask.userId)
            let _ = try db.collection(tasksPath).addDocument(from: userTask)
        }
        catch {
            fatalError("파이어베이스스토어에 데이터 저장 에러 : \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task) {
        if let taskId = task.id {
            do {
                try db.collection(tasksPath).document(taskId).setData(from: task)
            } catch {
                fatalError("파이어베이스 스토어에 데이터 업데이트 실패 : \(error.localizedDescription)")
            }
        }
    }
    
    func removeTask(_ task: Task) {
        if let taskId = task.id {
            db.collection(tasksPath).document(taskId).delete { (error) in
                if let error = error {
                    fatalError("데이터베이스 삭제 실패 : \(error.localizedDescription)")
                }
            }
        }
    }
}

