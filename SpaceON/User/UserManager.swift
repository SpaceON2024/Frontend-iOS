// UserManager.swift
// SpaceON
// Created by 김민정 on 10/27/24.

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import Combine

class UserManager: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("accessToken") var accessToken: String = ""
    @Published var userInfo: UserInfo? = nil
    
    func login(token: String) {
        self.accessToken = token
        self.isLoggedIn = true
        fetchUserInfo()  // 로그인 시 사용자 정보를 자동으로 가져옴
    }
    
    func logout() {
        self.accessToken = ""
        self.userInfo = nil
        self.isLoggedIn = false
    }

    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print("Kakao login error: \(error)")
                } else if let token = oauthToken?.accessToken {
                    print("Kakao login success, token: \(token)")
                    self.login(token: token)  // 로그인 메서드 호출
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print("Kakao login error: \(error)")
                } else if let token = oauthToken?.accessToken {
                    print("Kakao login success, token: \(token)")
                    self.login(token: token)  // 로그인 메서드 호출
                }
            }
        }
    }
    
    private func fetchUserInfo() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print("Failed to fetch user info: \(error)")
            } else if let user = user {
                let name = user.kakaoAccount?.profile?.nickname ?? "Unknown"
                let email = user.kakaoAccount?.email ?? ""
                self.userInfo = UserInfo(name: name, email: email)
            }
        }
    }
}
