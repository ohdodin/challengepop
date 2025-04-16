//
//  RecordStatusView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct RecordCheckView: View {
    var body: some View {
        VStack {
            Text("RecordCheckView")
            NavigationLink {
                RecordInputView()
            } label: {
                Text("Write")
            }
        }
    }
}

#Preview {
    RecordCheckView()
}
