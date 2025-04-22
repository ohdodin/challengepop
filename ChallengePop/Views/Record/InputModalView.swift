import Foundation
import SwiftData
import SwiftUI

struct InputModalView: View {

    var canDelete: Bool = false
    @State var textEditorText: String = ""
    @Binding var selected: Int?

    @Environment(\.dismiss) var dismiss
    @AppStorage("isWritten") var isWritten: Bool = false
    @AppStorage("today") var today: Date = Date.distantPast

    @Environment(\.modelContext) private var context
    @Query(sort: \ChallengeRecord.createdAt, order: .forward) private
        var challengeRecords: [ChallengeRecord]  // 값을 불러오는 순서를 보장할 수 없음, sort, created at으로 정렬

    var body: some View {
        NavigationStack {
            ZStack {
                if var selected = selected {
                    let record = challengeRecords[selected]
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

                        // 저장 버튼
                        if canDelete {
                            VStack {
                                NavigationButton(
                                    text: "저장하기",
                                    step: .constant(0),
                                    isDisabled: .constant(false),
                                    onTap: {
                                        record.content = textEditorText
                                        try? context.save()
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
                        if let selected = selected {
                            context.delete(challengeRecords[selected])
                            try? context.save()
                        }
                        // 여기!!
                        selected = nil
                        print("여기: \(selected)")
                        isWritten = false
                        print("여기: \(isWritten)")

                        dismiss()
                        print("여기: dismiss")
                        dump(challengeRecords)

                        //
                    }
                    .foregroundColor(Color(.mainOrange))
                }
            }
        }
        .onAppear {
            if let selected = selected {
                textEditorText = challengeRecords[selected].content ?? ""
            } else {
                textEditorText = ""
            }
        }

    }
}

#Preview {
    var record: ChallengeRecord = ChallengeRecord(
        challenge: Challenge.getChallengeData(
            category: Category.communication,
            difficulty: Difficulty.easy
        )
    )
    @State var selected: Int? = 0
    InputModalView(
        selected: $selected
    )
}
