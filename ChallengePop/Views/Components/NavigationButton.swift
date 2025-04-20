//
//  SwiftUIView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/16/25.
//

import SwiftUI

struct NavigationButton: View {
    
    let text: String
    @Binding var step: Int
    @Binding var isDisabled: Bool
    var isNext: Bool = true
    var isLight: Bool = false
    var onTap: (() -> Void)?
    
    var body: some View {
        Button {
            if isNext {
                step += 1
            } else {
                step -= 1
            }
            onTap?()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        isDisabled
                        ? Color(.disabled)
                        : (isLight ? Color(.subOrange) :Color(.mainOrange))
                    )
                    .frame(
                        width: (UIScreen.main.bounds.width - 72),
                        height: 50
                    )
                Text(text)
                    .foregroundColor(isLight ? Color(.mainOrange) : .white)
            }
        }
        .disabled(isDisabled)

    }
}

