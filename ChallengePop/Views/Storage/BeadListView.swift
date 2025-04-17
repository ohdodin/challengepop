//
//  BeadListView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct BeadListView: View {
    @State private var showModal = false
    @EnvironmentObject var user: User

        var body: some View {
            ZStack {
                Color(.background).ignoresSafeArea()
                VStack {
                    Text("BeadListView")
                    Text(user.challengeRecords.last?.content ?? "empty")
                    Button("모달 띄우기") {
                        showModal = true
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)

                }
                .sheet(isPresented: $showModal) {  // ✅ 모달 띄우기
                    BeadEditView()
                }
                .padding(36)
            }
            .navigationTitle("도전일기")
        }
        
    
}

#Preview {
    BeadListView()
        .environmentObject(User())
}
