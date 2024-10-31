// MyInfoView.swift
// SpaceON
// Created by 김민정 on 10/26/24.

import SwiftUI

struct MyInfoView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationView {
            VStack {
                if userManager.isLoggedIn, let userInfo = userManager.userInfo {
                    Text("Hello, \(userInfo.nickname)!")
                        .font(.largeTitle)
                } else {
                    HStack {
                        Text("로그인이 필요합니다.")
                            .padding()
                        
                        Spacer()
                        
                        Image("kakaobutton-m").onTapGesture {
                            userManager.kakaoLogin()
                        }
                        .padding()
                    }
                }
            }
            .navigationBarItems(
                leading: Text("홈").font(.title),
                trailing: Button(action: {
                    if userManager.isLoggedIn {
                        userManager.logout()
                    } else {
                        userManager.kakaoLogin()
                    }
                }) {
                    Text(userManager.isLoggedIn ? "로그아웃" : "로그인")
                        .foregroundColor(.blue)
                }
            )
        }
    }
}

#Preview {
    MyInfoView()
        .environmentObject(UserManager())
}
