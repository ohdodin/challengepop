//
//  TabView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct CustomTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                SelectCategoryView()
            }
            .tabItem {
                Label("도전과제", systemImage: "star.fill")
            }
            NavigationStack {
                RecordCheckView()

            }
            .tabItem {
                Label("도전일기", systemImage: "pencil.line")
            }
            NavigationStack {
                BeadListView()
            }
            .tabItem {
                Label("저장소", systemImage: "star.circle.fill")
            }
        }
    }
}

#Preview {
    CustomTabView()
}
