//
//  ChallengePopApp.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/14/25.
//

import SwiftUI
import SwiftData

@main
struct ChallengePopApp: App {
    
    init() {    // 앱 테스트용 함수
        UserDefaults.standard.removeObject(forKey: "isSelected") // 앱 실행 시 초기화
        UserDefaults.standard.removeObject(forKey: "isWritten") // 앱 실행 시 초기화
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ChallengeRecord.self)
    }
}
