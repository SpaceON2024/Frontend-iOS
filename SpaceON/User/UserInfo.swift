//
//  UserInfo.swift
//  SpaceON
//
//  Created by 김민정 on 10/27/24.
// UserInfo.swift

struct UserInfo: Codable {
    let socialId: String
    let nickname: String
    let tokens: Tokens
    let profileImage: String?
}

struct Tokens: Codable {
    let refreshToken: String
    let accessToken: String
    
    init() {
        self.accessToken = ""
            self.refreshToken = ""
        }
}
