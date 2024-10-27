//
//  EditGroupView.swift
//  SpaceON
//
//  Created by 김민정 on 10/27/24.
//

import SwiftUI

struct EditGroupView: View {
    var body: some View {
        NavigationView {
            Text("로그인 후 사용자가 그룹을 관리 하는 뷰")
                .navigationBarItems(leading: Text("그룹 관리").font(.title))
                }
    }
}

#Preview {
    EditGroupView()
}
