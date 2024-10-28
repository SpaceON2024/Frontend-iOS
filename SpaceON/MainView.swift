// MainView.swift
// SpaceON
// Created by 김민정 on 10/26/24.

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationView {
            VStack {
                if userManager.isLoggedIn, let userInfo = userManager.userInfo {
                    Text("Hello, \(userInfo.name)!")
                } else {
                    HStack {
                        Text("로그인 하기")
                            .padding()
                        
                        Spacer()
                        .padding()
                    }
                }
                
                Text("그룹 출력들 리스트로 출력하기")
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
    MainView()
        .environmentObject(UserManager())
}
