//
//  UserManager.swift
//  SpaceON
//
//  Created by 김민정 on 10/27/24.
// 

import SwiftUI
import Combine

class UserManager: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("accessToken") var accessToken: String = ""
    @Published var userInfo: UserInfo? = nil  // 유저 정보를 저장할 객체
    
    func login(token: String, userInfo: UserInfo) {
        self.accessToken = token
        self.userInfo = userInfo
        self.isLoggedIn = true
    }
    
    func logout() {
        self.accessToken = ""
        self.userInfo = nil
        self.isLoggedIn = false
    }
}
