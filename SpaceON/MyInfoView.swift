//
//  MyInfoView.swift
//  SpaceON
//
//  Created by 김민정 on 10/26/24.
//
import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct MyInfoView: View {
    var body: some View {
        VStack(){
            HStack{
                Text("로그인이 필요합니다.")
                Spacer()
                Image("kakaobutton-m").onTapGesture {
                    kakaoLogin()
                }
                // 이 뷰에 처음 들어올때 로그인 상태인지 확인이 필요하다
            }
        }
        .padding()
    }
    
    func kakaoLogin() {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                // 카카오톡으로 로그인
                UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                    if let error = error {
                        print("Kakao login error: \(error)")
                    } else {
                        print("Kakao login success")
                        // Access token
                        if let token = oauthToken?.accessToken {
                            print("Access token: \(token)")
                        }
                    }
                }
            } else {
                // 카카오 계정으로 로그인
                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                    if let error = error {
                        print("Kakao login error: \(error)")
                    } else {
                        print("Kakao login success")
                        // Access token
                        if let token = oauthToken?.accessToken {
                            print("Access token: \(token)")
                        }
                    }
                }
            }
        }
}

#Preview {
    MyInfoView()
}
