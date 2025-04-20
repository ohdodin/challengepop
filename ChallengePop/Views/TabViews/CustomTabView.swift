//
//  TabView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

enum tabName {
    case challenge
    case record
    case storage

    var stringValue: String {
        switch self {
        case .challenge:
            return "도전과제"
        case .record:
            return "도전일기"
        case .storage:
            return "도전저장소"
        }
    }
    
    var iconValue: String {
        switch self {
        case .challenge:
            return "star.fill"
        case .record:
            return "pencil.line"
        case .storage:
            return "star.circle.fill"
        }
    }
}

struct CustomTabView: View {

    @State var user = User()
    @State var tabSelection: Int = 0
    @AppStorage("isSelected") var isSelected: Bool = false
    @AppStorage("isWritten") var isWritten: Bool = false
    @AppStorage("lastChallengeDate") var lastChallengeDate: Date = Date
        .distantPast

    var body: some View {
        TabView(selection: $tabSelection) {
            ChallengeView(user: $user, tabSelection: $tabSelection)
                .tabItem {
                    Label(tabName.challenge.stringValue, systemImage: tabName.challenge.iconValue)
                }
                .tag(0)
            RecordView(user: $user, tabSelection: $tabSelection)
                .tabItem {
                    Label(tabName.record.stringValue, systemImage: tabName.record.iconValue)
                }
                .tag(1)
            NavigationStack {
                BeadListView()
            }
            .tabItem {
                Label(tabName.record.stringValue, systemImage: tabName.storage.iconValue)
            }
            .tag(2)
        }
        .tabViewStyle(.automatic)
        .accentColor(Color(.mainOrange))
        .onAppear {
            let today = Calendar.current.startOfDay(for: Date())
            if !Calendar.current.isDate(lastChallengeDate, inSameDayAs: today) {
                isSelected = false
                isWritten = false
                lastChallengeDate = today
            }
        }
        .onAppear {
            resetIfNewDay()
        }
    }

    func resetIfNewDay() {
        let today = Calendar.current.startOfDay(for: Date())
        let last = Calendar.current.startOfDay(for: lastChallengeDate)

        if last != today {
            isSelected = false
            isWritten = false

            lastChallengeDate = today
        }
    }
}

#Preview {
    CustomTabView()
}
