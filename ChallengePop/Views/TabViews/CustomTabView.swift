//
//  TabView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct CustomTabView: View {
    @State var tabSelection: Int = 0
    @EnvironmentObject var user: User
    @AppStorage("isSelected") var isSelected: Bool = false
    @AppStorage("isWritten") var isWritten: Bool = false
    @AppStorage("lastChallengeDate") var lastChallengeDate: Date = Date.distantPast
    
    
    var body: some View {
        TabView (selection: $tabSelection) {
            NavigationStack {
                if isSelected {
                    ChallengeDetailView(tabSelection: $tabSelection)
                        .environmentObject(user)
                }
                else {
                    SelectCategoryView(tabSelection: $tabSelection)
                        .environmentObject(user)
                }
            }
            .tabItem {
                Label("도전과제", systemImage: "star.fill")
            }
            .tag(0)
            NavigationStack {
                if isSelected == false {
                    RecordBeforeView(tabSelection: $tabSelection)
                        .environmentObject(user)
                } else {
                    if isWritten == false {
                        RecordCheckView()
                            .environmentObject(user)
                    } else {
                        RecordAfterView()
                            .environmentObject(user)
                    }
                }
            }
            .tabItem {
                Label("도전일기", systemImage: "pencil.line")
            }
            .tag(1)
            NavigationStack {
                BeadListView()
                    .environmentObject(user)
            }
            .tabItem {
                Label("저장소", systemImage: "star.circle.fill")
            }
            .tag(2)
        }
        .tabViewStyle(.automatic)
        .accentColor(Color("mainOrange"))
        .onAppear {
            let today = Calendar.current.startOfDay(for: Date())
            if !Calendar.current.isDate(lastChallengeDate, inSameDayAs: today) {
                isSelected = false
                isWritten = false
                lastChallengeDate = today
            }
        }
        .onAppear{
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
        .environmentObject(User())
}
