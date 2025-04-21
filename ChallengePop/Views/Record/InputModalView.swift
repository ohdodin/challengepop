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

//                    // 텍스트 입력 필드
                    TextEditor(text: $textEditorText)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.border, lineWidth: 1)
                        )
                    
//                    TextField("작성해주세요.",text: $textEditorText, axis: .vertical)
//                        .padding()
//                        .background(.white)
//                        .cornerRadius(20)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .stroke(.border, lineWidth: 1)
//                        )
                    

                    // 삭제 버튼
                    if canDelete {
                        VStack {
                            Text("작성한 일기의 내용만 삭제됩니다.")
                                .foregroundColor(Color(.darkGray))
                                .font(.caption)
                            NavigationButton(
                                text: "삭제하기",
                                step: .constant(0),
                                isDisabled: .constant(false),
                                onTap: {
                                    //                                    record.content = nil
                                    //                                    record.isWritten = false
                                    context.delete(record)
                                    dismiss()
                                }
                            )
                        }
                    }

                }
                .padding(36)
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
                        Button("완료") {
                            record.isWritten = true
                            record.content = textEditorText
                            try? context.save()

                            isWritten = true
                            dismiss()
                        }
                        .foregroundColor(Color(.mainOrange))
                    }
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
