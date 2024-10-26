//
//  ContentView.swift
//  SpaceON
//
//  Created by 김민정 on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
            .tabItem {
              Image(systemName: "house.fill")
              Text("메인")
            }
            AddgroupView()
            .tabItem {
                Image(systemName: "plus.square.fill")
              Text("그룹 추가")
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
}
