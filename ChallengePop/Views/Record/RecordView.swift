//
//  RecordView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/19/25.
//

import SwiftData
import SwiftUI

struct RecordView: View {

    @State private var showModal = false
    @Binding var tabSelection: Int
    @AppStorage("isSelected") var isSelected: Bool = false
    @AppStorage("isWritten") var isWritten: Bool = false
    @AppStorage("today") var today: Date = Date.distantPast

    @Environment(\.modelContext) private var context
    @Query(sort: \ChallengeRecord.createdAt, order: .reverse) private
        var challengeRecords: [ChallengeRecord]  // 값을 불러오는 순서를 보장할 수 없음, sort, created at으로 정렬

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
        .fullScreenCover(isPresented: $showModal) {

            // 여기!!

            InputModalView(selected: .constant(challengeRecords.count - 1))

        }
    }

    func firstChallengeRecord() -> ChallengeRecord? {
        //        dump(challengeRecords)
        return challengeRecords.first ?? nil
    }

    // MARK: 0. 도전과제 선택 전
    var beforeView: some View {
        VStack {
            Spacer()
            // 오늘 날짜
            formattedDate(date: today)

            VStack(spacing: 40) {
                VStack {
                    Image("sparkle")
                        .resizable()
                        .frame(width: 200, height: 200)

                }
                VStack(spacing: 8) {
                    Text("도전과제가 아직 없어요!")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)

                    Text("오늘의 나를 위한 작은 도전을\n시작해볼까요?")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.darkGray)
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
        VStack(spacing: 16) {
            Spacer()

            // 도전과제 보기
            VStack(spacing: 8) {
                Text("오늘의 도전과제")
                    .font(.body)

                if let challengeRecord = firstChallengeRecord() {
                    ChallengeDetailCard(
                        challenge: challengeRecord.challenge
                    )
                } else {
                    ChallengeCard(
                        text: "미리보기",
                    )
                }
                Text("이 도전을 완료하셨나요?")
                    .font(.body)

            }

            // 버튼 뷰
            VStack(spacing: 16) {

                if let challengeRecord = firstChallengeRecord() {
                    NavigationButton(
                        text: "오늘 도전 완료!",
                        step: .constant(0),
                        isDisabled: .constant(false),
                        onTap: {
                            challengeRecord.isDone = true
                            showModal = true
                        }
                    )
                    NavigationButton(
                        text: "오늘은 쉬어가기",
                        step: .constant(0),
                        isDisabled: .constant(false),
                        isLight: true,
                        onTap: {
                            challengeRecord.isDone = false
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

            VStack(spacing: 40) {

                Image("confetti")
                    .resizable()
                    .scaledToFit()

                VStack(spacing: 8) {
                    Text("도전과제가 아직 없어요!")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)

                    Text("오늘의 나를 위한 작은 도전을\n시작해볼까요?")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.darkGray)
                }

            }
            Spacer()

        }
    }

}

#Preview {
    @State var tabSelection: Int = 0
    RecordView(tabSelection: $tabSelection)
}
