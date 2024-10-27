// MyInfoView.swift
// SpaceON
// Created by 김민정 on 10/26/24.

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct MyInfoView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationView {
            VStack {
                if userManager.isLoggedIn, let userInfo = userManager.userInfo {
                    Text("Hello, \(userInfo.name)!")
                        .font(.largeTitle)
                } else {
                    HStack {
                        Text("로그인이 필요합니다.")
                            .padding()
                        
                        Spacer()
                        
                        Image("kakaobutton-m").onTapGesture {
                            kakaoLogin()
                        }
                        .padding()
                    }
                }
            }
            .navigationBarItems(leading: Text("내 정보").font(.title))
            .onAppear {
                // 현재 로그인 상태인지 확인
                if userManager.isLoggedIn && userManager.userInfo == nil {
                    fetchUserInfo()
                }
            }
        }
    }
    
    func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print("Kakao login error: \(error)")
                } else if let token = oauthToken?.accessToken {
                    print("Kakao login success, token: \(token)")
                    fetchUserInfo()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print("Kakao login error: \(error)")
                } else if let token = oauthToken?.accessToken {
                    print("Kakao login success, token: \(token)")
                    userManager.accessToken = token
                    fetchUserInfo()
                }
            }
        }
    }
    
    func fetchUserInfo() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print("Failed to fetch user info: \(error)")
            } else if let user = user {
                let name = user.kakaoAccount?.profile?.nickname ?? "Unknown"
                let email = user.kakaoAccount?.email ?? ""
                let userInfo = UserInfo(name: name, email: email)
                userManager.login(token: userManager.accessToken, userInfo: userInfo)
            }
        }
    }
}

#Preview {
    MyInfoView()
        .environmentObject(UserManager())
}
