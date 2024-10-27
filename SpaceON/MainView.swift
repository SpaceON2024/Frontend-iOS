//
//  MainView.swift
//  SpaceON
//
//  Created by 김민정 on 10/26/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationView {
            Text("초기 페이지로 로그인이 되어있다면 이름과 내가 속한 그룹 띄우기")
                    .navigationBarItems(leading: Text("홈").font(.title))
                }
    }
}

#Preview {
    MainView()
}
