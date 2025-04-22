import Foundation
import SwiftData
import SwiftUI

struct InputModalView: View {

    var canDelete: Bool = false
    var record: ChallengeRecord
    @State var textEditorText: String = ""

    @Environment(\.dismiss) var dismiss
    @AppStorage("isWritten") var isWritten: Bool = false
    @AppStorage("today") var today: Date = Date.distantPast

    @Environment(\.modelContext) private var context
    @Query private var challengeRecords: [ChallengeRecord]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background).ignoresSafeArea()

                VStack(spacing: 24) {

                    // 도전 과제 카드
                    ChallengeCard(
                        text: record.challenge.title,
                        emoji: record.challenge.emoji
                    )

                    // 텍스트 입력 필드
                    ZStack(alignment: .topLeading) {

                        TextEditor(text: $textEditorText)
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.border, lineWidth: 1)
                            )
                            .layoutPriority(1)  // 우선적으로 공간 차지
                        if textEditorText == "" {
                            Text("도전을 이루었을 때 느꼈던 감정이나 성취감을 기록해보세요...")
                                .foregroundColor(.darkGray)
                                .padding(20)
                        }
                    }

                    // 삭제 버튼
                    if canDelete {
                        VStack {
                            NavigationButton(
                                text: "저장하기",
                                step: .constant(0),
                                isDisabled: .constant(false),
                                onTap: {
                                    record.content = textEditorText
                                    try? context.save()
                                    record.isWritten = true
                                    isWritten = true
                                    dismiss()

                                }
                            )
                        }
                    }
                }
                .padding(.bottom, 36)
                .padding(.horizontal, 36)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("취소")
                        }
                    }
                    .foregroundColor(Color(.mainOrange))

                }
                ToolbarItem(placement: .principal) {
                    formattedDate(date: today)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("삭제") {
                        record.isWritten = false
                        //                                context.delete(record)
                        record.content = nil  // 여기!
                        dismiss()
                    }
                    .foregroundColor(Color(.mainOrange))
                }
            }
        }

        .onAppear {
            if let text = record.content {
                textEditorText = text
            }

        }

    }

    func todayChallengeRecord(today: Date) -> ChallengeRecord? {
        return challengeRecords.first { challengeRecord in
            startOfDay(date: challengeRecord.date) == startOfDay(date: today)
        }
    }

    func startOfDay(date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
}

#Preview {
    InputModalView(
        record: ChallengeRecord(
            challenge: Challenge.getChallengeData(
                category: Category.health,
                difficulty: Difficulty.easy
            )
        )
    )
}
