//
//  BeadEditView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct BeadEditView: View {
    var body: some View {
        VStack {
            Text("모달 화면")
                .font(.title)
                .padding()
            Button("닫기") {
                dismiss()
            }
        }
    }
    
    @Environment(\.dismiss) private var dismiss
}

#Preview {
    BeadEditView()
}

