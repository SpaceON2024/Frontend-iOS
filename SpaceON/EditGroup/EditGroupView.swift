//
//  EditGroupView.swift
//  SpaceON
//
//  Created by 김민정 on 10/27/24.
//

import SwiftUI

struct EditGroupView: View {
    @EnvironmentObject var userManager: UserManager
    
    @State private var showModal = false

    var body: some View {
        NavigationView {
            VStack {
                Text("로그인 후 사용자가 그룹을 관리 하는 뷰")
                Text("로그인을 한다면 내가 속한 그룹명으로 보고")
                Text("로그아웃 상태라면 현재 가지고 있는 모든 그룹 리스트를 출력한다")
            }
            .navigationBarItems(leading: Text("그룹 관리").font(.title),
                                trailing: Button(action: {
                                    if userManager.isLoggedIn {
                                        showModal.toggle()
                                    } else {
                                        userManager.kakaoLogin()
                                    }
                                }) {
                                    if userManager.isLoggedIn {
                                        Image(systemName: "plus")
                                            .foregroundColor(.blue)
                                    } else {
                                        Text("로그인")
                                            .foregroundColor(.blue)
                                    }
                                }
            )
            .sheet(isPresented: $showModal) {
                GroupCreationModal()
            }
        }
    }
}

#Preview {
    EditGroupView()
        .environmentObject(UserManager())
}
