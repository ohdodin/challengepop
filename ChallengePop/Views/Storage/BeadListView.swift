//
//  BeadListView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct BeadListView: View {
    @State private var showModal = false

    var body: some View {
        VStack {
            Text("BeadListView")
            Button("모달 띄우기") {
                showModal = true
            }
            .padding()
            .buttonStyle(.borderedProminent)

        }
        .sheet(isPresented: $showModal) {  // ✅ 모달 띄우기
            BeadEditView()
        }
    }
}

#Preview {
    BeadListView()
}
