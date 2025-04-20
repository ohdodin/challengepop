//
//  RecordView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/19/25.
//

import SwiftUI

struct RecordView: View {
    @Binding var user: User
    @State private var showModal = false
    @Binding var tabSelection: Int
    @AppStorage("isSelected") var isSelected: Bool = false
    @AppStorage("isWritten") var isWritten: Bool = false
    @AppStorage("today") var today: Date = Date.distantPast
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack {
                if !isSelected {
                    beforeView
                } else if !isWritten {
                    checkView
                } else {
                    afterView
                }
            }
            .padding(36)

        }
        .navigationTitle(tabName.record.stringValue)
        .sheet(isPresented: $showModal) {
            if let index = user.challengeRecords.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
                InputModalView(today: today,user: $user, record: $user.challengeRecords[index])
            }
        }
    }

    // MARK: 0. 도전과제 선택 전
    var beforeView: some View {
        VStack {
            Spacer()
            // 오늘 날짜
            formattedDate(date: today)

            VStack(spacing: 40) {
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
                    step: $tabSelection,
                    isDisabled: .constant(false),
                    isNext: false
                )

            }
        }
    }

    // MARK: 1. 도전과제 선택 후 체크 화면
    var checkView: some View {
        VStack(spacing: 88) {
            Spacer()

            // 도전과제 보기
            VStack(spacing: 8) {
                Text("오늘의 도전과제")
                    .font(.body)

                if let lastRecord = user.getTodayChallengeRecord(today: today).first {
                    ChallengeCard(
                        text: lastRecord.challenge.title,
                        emoji: lastRecord.challenge.emoji
                    )
                }
                Text("이 도전을 완료하셨나요?")
                    .font(.body)

            }
            
            // 버튼 뷰
            VStack(spacing: 16) {
                if let index = user.challengeRecords.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
                    NavigationButton(
                        text: "오늘 도전 완료!",
                        step: .constant(0),
                        isDisabled: .constant(false),
                        onTap: {
                            user.challengeRecords[index].updateIsDone(to: true)
                            showModal = true
                        }
                    )
                    NavigationButton(
                        text: "오늘은 쉬어가기",
                        step: .constant(0),
                        isDisabled: .constant(false),
                        isLight: true,
                        onTap: {
                            user.challengeRecords[index].updateIsDone(to: false)
                            showModal = true
                        }
                    )
                }

            }
            Spacer()
        }
    }

    // MARK: 2. 도전일기 작성 후
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
    }

}

#Preview {
    @State var tabSelection: Int = 0
    @State var user = User()
    RecordView(user: $user, tabSelection: $tabSelection )
}
