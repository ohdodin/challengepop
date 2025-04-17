//
//  ContentView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/14/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        CustomTabView()
            .environmentObject(user)
    }
}

#Preview {
    ContentView()
        .environmentObject(User())
}
