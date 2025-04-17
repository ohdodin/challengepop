//
//  TabView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct CustomTabView: View {
    @EnvironmentObject var user: User
    @State var tabSelection: Int = 0
    
    var body: some View {
        TabView (selection: $tabSelection) {
            NavigationStack {
                if user.challengeRecords.isEmpty {
                    SelectCategoryView(tabSelection: $tabSelection)
                        .environmentObject(user)
                }
                else {
                    ChallengeDetailView(tabSelection: $tabSelection)
                        .environmentObject(user)
                }
            }
            .tabItem {
                Label("도전과제", systemImage: "star.fill")
            }
            .tag(0)
            NavigationStack {
                RecordCheckView()

            }
            .tabItem {
                Label("도전일기", systemImage: "pencil.line")
            }
            .tag(1)
            NavigationStack {
                BeadListView()
            }
            .tabItem {
                Label("저장소", systemImage: "star.circle.fill")
            }
            .tag(2)
        }
        .tabViewStyle(.automatic)
        .accentColor(Color("MainColor"))
    }
}

#Preview {
    CustomTabView()
        .environmentObject(User())
}
