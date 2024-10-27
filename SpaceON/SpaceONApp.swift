//
//  SpaceONApp.swift
//  SpaceON
//
//  Created by 김민정 on 10/24/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct TestApp: App {
    @StateObject private var userManager = UserManager()
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "e95dba54a1f1675bea1ad321c57a46b3")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userManager)  // UserManager를 환경 객체로 설정
                .onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
