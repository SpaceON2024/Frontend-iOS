// UserManager.swift
// SpaceON
// Created by 김민정 on 10/27/24.

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import Combine
import Alamofire

class UserManager: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    @Published var userInfo: UserInfo? = nil
    
    func login(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.isLoggedIn = true
        fetchUserInfo()  // 로그인 시 백엔드에서 사용자 정보 가져옴
    }
    
    func logout() {
        self.accessToken = ""
        self.refreshToken = ""
        self.userInfo = nil
        self.isLoggedIn = false
    }

    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print("Kakao login error: \(error)")
                } else if let token = oauthToken?.accessToken, let refreshToken = oauthToken?.refreshToken {
                    print("Kakao login success, token: \(token)")
                    self.login(accessToken: token, refreshToken: refreshToken)  // 로그인 메서드 호출
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print("Kakao login error: \(error)")
                } else if let token = oauthToken?.accessToken, let refreshToken = oauthToken?.refreshToken {
                    print("Kakao login success, token: \(token)")
                    self.login(accessToken: token, refreshToken: refreshToken)  // 로그인 메서드 호출
                }
            }
        }
    }
    
    func fetchUserInfo() {
        let url = "https://spaceon.kro.kr/api/v1/member/login"
        let parameters: [String: String] = ["accessToken": accessToken]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: UserInfoResponse.self) { response in
                switch response.result {
                case .success(let data):
                    if data.status == 200, data.success {
                        if let userData = data.data {
                            DispatchQueue.main.async {
                                self.userInfo = UserInfo(
                                    socialId: userData.socialId,
                                    nickname: userData.nickname,
                                    tokens: userData.tokens,
                                    profileImage: userData.profileImage
                                )
                                //print(self.userInfo) // 로그인 정보 출력
                                //self.accessToken = userData.tokens.accessToken
                                //self.refreshToken = userData.tokens.refreshToken
                            }
                        }
                    } else {
                        print("Failed to fetch user info: \(data.message)")
                    }
                case .failure(let error):
                    print("Error fetching user info: \(error)")
                }
            }
    }
}

// 서버 응답 형식과 일치하는 구조체
struct UserInfoResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: UserInfo?
}


