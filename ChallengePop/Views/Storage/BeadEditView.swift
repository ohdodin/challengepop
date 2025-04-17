//
//  BeadEditView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct BeadEditView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack {
                Text("모달 화면")
                    .font(.title)
                    .padding()
                Button("닫기") {
                    dismiss()
                }
            }
            .padding(36)
        }
        .navigationTitle("도전일기")
    }

    
}

#Preview {
    BeadEditView()
}

