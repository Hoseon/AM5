//
//  AM5App.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/01/31.
//

import SwiftUI
import FirebaseCore
import Resolver

class AppDelegate: UIResponder, UIApplicationDelegate {
    @Injected var authenticationService: AuthenticationService
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        authenticationService.signIn()
        return true
    }
}

@main
struct AM5App: App {
    // 파이어 베이스 셋업을 하려면은 Appdelegate를 설정해주어야 한다.
    // 최신버전의 SwiftUI에서는 Appdelegate조차 생기지 않아서 수동으로 생성해주어야 함
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
