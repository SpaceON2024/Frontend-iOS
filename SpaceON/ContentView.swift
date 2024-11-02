// ContentView.swift
// SpaceON
// Created by 김민정 on 10/24/24.

import SwiftUI

struct ContentView: View {

    var body: some View {
            TabView {
                MainView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("홈")
                    }
                
                GroupView()
                    .tabItem {
                        Image(systemName: "plusminus.circle.fill")
                        Text("그룹 관리")
                    }
                
                MyInfoView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("내 정보")
                    }
            }
            .font(.headline)
        }
}

#Preview {
    ContentView()
        .environmentObject(UserManager())
}

