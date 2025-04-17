//
//  SwiftUIView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/16/25.
//

import SwiftUI

struct NavigationButton: View {
    let text: String
    @Binding var isDisabled: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    isDisabled
                    ? Color("DisabledColor")
                    : Color("MainColor")
                )
                .frame(
                    width: (UIScreen.main.bounds.width - 72),
                    height: 50
                )
            Text(text)
                .foregroundColor(.white)
        }
    }
}

