//
//  Task.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/01/31.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum TaskPriority: Int, Codable {
    case high
    case medium
    case low
}

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var priority: TaskPriority
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

//#if DEBUG
//let testDataTasks: [Task] = [
//    Task(title: "Implement UI", priority: .medium, completed: false),
//    Task(title: "Connect to Firebase", priority: .medium, completed: false),
//    Task(title: "????", priority: .high, completed: false),
//    Task(title: "PROFIT!!!", priority: .high, completed: false),
//]
//#endif
