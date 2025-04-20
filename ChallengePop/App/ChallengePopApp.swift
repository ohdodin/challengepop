//
//  ChallengePopApp.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/14/25.
//

import SwiftUI

@main
struct ChallengePopApp: App {
    
    init() {
        UserDefaults.standard.removeObject(forKey: "isSelected") // 앱 실행 시 초기화
        UserDefaults.standard.removeObject(forKey: "isWritten") // 앱 실행 시 초기화
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
