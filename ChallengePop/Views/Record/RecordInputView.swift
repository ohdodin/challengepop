//
//  RecordInputView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import Foundation
import SwiftUI

struct RecordInputView: View {
    @State var textEditoerText: String = ""
    @Environment(\.dismiss) var dismiss
    @AppStorage("isWritten") var isWritten: Bool = false

    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack(spacing: 24) {
                VStack {
                    Spacer()

                    VStack(spacing: 8) {
                        
                        // 날짜
                        formattedDate(date: Date())
                        
                        // 도전과제
                        ChallengeCard(text: "하루 10분 스트레칭 하기", emoji: "🧘🏻")
                    }
                }

                // 작성칸
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $textEditoerText)
                        .padding(24)
                        .background(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.border, lineWidth: 1)
                        )
                    if textEditoerText == "" {
                        Text("도전을 하며 느꼈던 감정이나 성취감을 기록해보세요.")
                            .foregroundColor(.darkGray)
                            .padding(32)
                    }
                }
                .frame(
                    width: UIScreen.main.bounds.width - 72,
                    height: UIScreen.main.bounds.height - 340
                )
                Spacer()


            }
            .padding(36)
        }
        .navigationTitle("도전일기")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("완료"){
                    saveText()
                    isWritten = true
                    dismiss()
                }
                .foregroundColor(.mainOrange)
            }
        }
    }


    func saveText() {
//        user.challengeRecords.last?.content = textEditoerText
    }
}

#Preview {
    RecordInputView()
}
