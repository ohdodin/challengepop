//
//  IntroMessage.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/17/25.
//
import SwiftUI

struct IntroMessage: View {
    let plain1: String
    let point: String
    let plain2: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(plain1)
                .font(.body)
            Text(point)
                .font(.body)
                .foregroundColor(Color("mainOrange"))
            Text(plain2)
                .font(.body)
        }
    }

}

