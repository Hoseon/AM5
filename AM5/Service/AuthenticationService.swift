//
//  AuthenticationService.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/02/01.
//

import Foundation
import Firebase

class AuthenticationService: ObservableObject {
    @Published var user: User?
    
    func signIn() {
        registerStateListener()
        Auth.auth().signInAnonymously()
        //등록리스너 구현 필요
    }
    
    private func registerStateListener() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print("로그인 상태 리스너 발동")
            self.user = user
            
            if let user = user {
                let anonymous = user.isAnonymous ? "anonymously " : ""
                print("유저 로그인 \(anonymous) with user ID \(user.uid)")
            }
            else {
                print("유저 로그아웃")
            }
        }
    }
}
