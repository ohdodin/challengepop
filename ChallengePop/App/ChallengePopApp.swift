//
//  ChallengePopApp.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/14/25.
//

import SwiftUI

@main
struct ChallengePopApp: App {
    @StateObject var user = User()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
        }
    }
}
