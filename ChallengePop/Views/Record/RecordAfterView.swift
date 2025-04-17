//
//  RecordBeforeView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct RecordAfterView: View {
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack {
                Spacer()
                // 오늘 날짜
                formattedToday()
                
                VStack(spacing: 64) {
                    ChallengeCard(text: "하루 10분 스트레칭 하기", emoji:"🧘🏻")
                    VStack {
                        Image("confetti")
                            .resizable()
                            .scaledToFit()
                        Text("수고했어요!\n오늘의 도전을 완료했어요!\n내일 또 만나요!")
                            .multilineTextAlignment(.center)
                        
                    }

                }
                Spacer()


            }
            .padding(36)
        }
    }
}

#Preview {
    RecordAfterView()
}
