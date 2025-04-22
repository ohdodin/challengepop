//
//  ChallengeDetailCard.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/22/25.
//

import SwiftUI

struct ChallengeDetailCard: View {

    var challenge: Challenge
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                Text(challenge.title)
                    .font(.title3)
                    .bold()
                    .padding(.vertical, 16)
                Text(challenge.emoji)
                    .font(.system(size: 100))
                Text(challenge.challengeDescription)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.darkGray)
            }
            .padding(24)
            .frame(maxWidth: UIScreen.main.bounds.width - 72)
            .background(.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.border, lineWidth: 1)
            )
        }
        // 추천시간, 추천장소
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Text("추천 시간 |")
                    .bold()
                    .font(.callout)
                Text(challenge.recommendedTime)
            }
            HStack {
                Text("추천 장소 |")
                    .bold()
                    .font(.callout)
                Text(challenge.recommendedPlace)
            }
        }
    }
}

#Preview {
    ChallengeDetailCard(
        challenge: Challenge.getChallengeData(
            category: Category.communication,
            difficulty: Difficulty.easy

        )
    )
}
