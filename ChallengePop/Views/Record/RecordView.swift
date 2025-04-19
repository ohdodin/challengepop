//
//  RecordView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/19/25.
//

import SwiftUI

struct RecordView: View {
    let today = Calendar.current.startOfDay(for: Date())
    
    @State private var showModal = false
    @State private var textEditorText: String = ""
    @Binding var user: User
    @Binding var tabSelection: Int
    @AppStorage("isSelected") var isSelected: Bool = false
    @AppStorage("isWritten") var isWritten: Bool = false

    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()

            if !isSelected {
                beforeView
            } else if !isWritten {
                checkView
            } else {
                afterView
            }
        }
        .sheet(isPresented: $showModal) {
            inputModal()
        }
    }

    var beforeView: some View {
        VStack {
            Spacer()
            // 오늘 날짜
            formattedDate(date: today)

            VStack(spacing: 64) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.background))
                        .stroke(Color(.border), lineWidth: 1)
                        .frame(height: 60)
                    Text("도전과제가 아직 없어요!")
                        .font(.title3)
                        .foregroundColor(.darkGray)

                }
                VStack {
                    Image("sparkle")
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text("오늘의 나를 위한 작은 도전을\n시작해볼까요?")
                        .multilineTextAlignment(.center)

                }

            }
            Spacer()
            Button {
                tabSelection = 0
            } label: {
                NavigationButton(
                    text: "선택하러 가기",
                    isDisabled: .constant(false)
                )

            }

        }
        .padding(36)
    }

    var checkView: some View {
        VStack(spacing: 88) {
            VStack(spacing: 8) {
                Text("오늘의 도전과제")
                    .font(.body)
                if let lastRecord = user.challengeRecords.last {
                    ChallengeCard(
                        text: lastRecord.challenge.title,
                        emoji: lastRecord.challenge.emoji
                    )
                }
                Text("이 도전을 완료하셨나요?")
                    .font(.body)

            }

            VStack(spacing: 16) {
                if var lastRecord = user.challengeRecords.last {
                    Button {
                        lastRecord.updateIsDone(to: true)
                        
                    } label: {
                        NavigationButton(
                            text: "오늘 도전 완료!",
                            isDisabled: .constant(false)
                        )
                    }
                    Button {
                        lastRecord.updateIsDone(to: false)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    Color("subOrange")
                                )
                                .frame(
                                    width: (UIScreen.main.bounds.width - 72),
                                    height: 50
                                )
                            Text("오늘은 쉬어가기")
                                .foregroundColor(Color("mainOrange"))
                        }
                    }

                }

            }
            .padding(36)
        }
    }

    var afterView: some View {
        VStack {
            Spacer()
            // 오늘 날짜
            formattedDate(date: today)

            VStack(spacing: 64) {
                if let lastRecord = user.challengeRecords.last {
                    ChallengeCard(
                        text: lastRecord.challenge.title,
                        emoji: lastRecord.challenge.emoji
                    )
                }
                
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
    
    func inputModal() -> some View {
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
                TextEditor(text: $textEditorText)
                    .padding(24)
                    .background(.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.border, lineWidth: 1)
                    )
                if textEditorText == "" {
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

}

#Preview {
    @State var tabSelection: Int = 0
    @State var user = User()
    RecordView(user: $user, tabSelection: $tabSelection)
}
