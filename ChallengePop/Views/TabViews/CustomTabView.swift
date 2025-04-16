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
                Text("도전과제")
            }
            NavigationStack {
                RecordCheckView()

            }
            .tabItem {
                Text("도전일기")
            }
            NavigationStack {
                BeadListView()
            }
            .tabItem {
                Text("저장소")
            }
        }
    }
}

#Preview {
    CustomTabView()
}
