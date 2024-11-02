//
//  GroupView.swift
//  SpaceON
//
//  Created by 김민정 on 10/27/24.
//

import SwiftUI
import Alamofire

struct GroupView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var allGroups: [Group] = []
    @State private var myGroups: [Group] = []
    @State private var showModal = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("내 그룹")) {
                    if myGroups.isEmpty {
                        Text("내 그룹이 없습니다.")
                    } else {
                        ForEach(myGroups) { g in
                            NavigationLink (value: g.id){
                                VStack {
                                    HStack{
                                        Text(g.groupName)
                                            .font(.headline)
                                        Text("#\(g.id)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Text(g.groupContent)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("전체 그룹")) {
                    if allGroups.isEmpty {
                        Text("그룹이 없습니다.")
                    } else {
                        ForEach(allGroups) { g in
                            NavigationLink (value: g.id){
                                VStack {
                                    HStack{
                                        Text(g.groupName)
                                            .font(.headline)
                                        Text("#\(g.id)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Text(g.groupContent)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarItems(
                leading: Text("그룹 관리").font(.title),
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
            .onAppear {
                fetchAllGroupList()
            }
        }
    }
    
    private func fetchAllGroupList() {
        guard let accessToken = userManager.userInfo?.tokens.accessToken else {
            print("Error: Access token is missing")
            return
        }
        
        let url = "https://spaceon.kro.kr/api/v1/group/list"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: GroupResponse.self) { response in
            switch response.result {
            case .success(let groupResponse):
                self.allGroups = groupResponse.data.groups
                print("Group list fetched successfully")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchMyGroupList() {
        guard let accessToken = userManager.userInfo?.tokens.accessToken else {
            print("Error: Access token is missing")
            return
        }
        
        let url = ""
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: GroupResponse.self) { response in
            switch response.result {
            case .success(let groupResponse):
                self.myGroups = groupResponse.data.groups
                print("Group list fetched successfully")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

struct GroupResponse: Decodable {
    let status: Int
    let success: Bool
    let message: String
    let data: GroupList
}

struct GroupList: Decodable {
    let groups: [Group]
}

struct Group: Identifiable, Decodable {
    let id: Int
    let groupName: String
    let groupContent: String
}


#Preview {
    GroupView()
        .environmentObject(UserManager())
}
