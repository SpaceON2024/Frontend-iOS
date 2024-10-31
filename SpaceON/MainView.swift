// MainView.swift
// SpaceON
// Created by 김민정 on 10/26/24.

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if userManager.isLoggedIn, let userInfo = userManager.userInfo {
                    Text("\(userInfo.nickname)님 안녕하세요!")
                        .padding()
                } else {
                    HStack {
                        Text("로그인이 필요합니다.")
                            .padding()
                    }
                }
                
                GroupBox(label:
                    Label("나의 회의", systemImage: "calendar.badge.clock")
                ) {
                    ScrollView(.vertical, showsIndicators: true) {
                        Text("다음 회의가 있다면 표시한다")
                            .font(.footnote)
                    }
                    .frame(height: 70)
                }
                .cornerRadius(20)
                .padding([.leading, .trailing, .bottom])
                
                GroupBox(label:
                    Label("예약된 회의", systemImage: "calendar")
                ) {
                    ScrollView(.vertical, showsIndicators: true) {
                        Text("오늘 전체적인 회의 시간표를 출력한다")
                            .font(.footnote)
                    }
                    .frame(height: 200)
                }
                .cornerRadius(20)
                .padding([.leading, .trailing])
                
                Text("그룹 출력들 리스트로 출력하기")
                    .padding()
                
                Spacer()
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
            .onAppear {
                if userManager.isLoggedIn && userManager.userInfo == nil {
                    userManager.fetchUserInfo() // 필요한 경우 사용자 정보 가져오기
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(UserManager())
}
