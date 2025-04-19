//
//  BeadEditView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct BeadEditView: View {
    
    @State private var textEditorText: String = ""  // 초기화는 .onAppear에서 처리
    @Binding var bead: ChallengeRecord
    @Environment(\.dismiss) private var dismiss
    
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
                        ChallengeCard(text: bead.challenge.title, emoji: bead.challenge.emoji)
                    }
                }

                // 작성칸
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $textEditorText)
                        .padding(24)
                        .background(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.border, lineWidth: 1)
                        )
                }
                .frame(
                    width: UIScreen.main.bounds.width - 72,
                    height: UIScreen.main.bounds.height - 340
                )
                Spacer()
                
                Button {
                    bead.content = ""
                    textEditorText = ""
                    dismiss()
                } label: {
                    NavigationButton(text: "삭제하기", isDisabled: .constant(false))
                }

            }
            .padding(36)
        }
        .onAppear {
                    textEditorText = bead.content ?? ""
                }
        .navigationTitle("도전일기")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("완료"){
                    bead.content = textEditorText
                    dismiss()
                }
                .foregroundColor(.mainOrange)
            }
        }
        .navigationTitle("도전일기")
    }

    
}

#Preview {
    BeadEditView(bead: .constant(ChallengeRecord(challenge: ChallengeData.challengeList[4], isDone: true, isWritten: true)))
}

