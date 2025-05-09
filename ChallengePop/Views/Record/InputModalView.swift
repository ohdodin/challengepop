import Foundation
import SwiftData
import SwiftUI

struct InputModalView: View {

    var canDelete: Bool = false
    @State var textEditorText: String = ""
    @State var showAlert: Bool = false
    @Binding var selected: Int?

    @Environment(\.dismiss) var dismiss
    @AppStorage("isWritten") var isWritten: Bool = false
    @AppStorage("today") var today: Date = Date.distantPast

    @Environment(\.modelContext) private var context
    @Query(sort: \ChallengeRecord.createdAt, order: .reverse) private
        var challengeRecords: [ChallengeRecord]  // 값을 불러오는 순서를 보장할 수 없음, sort, created at으로 정렬

    var body: some View {
        NavigationStack {
            ZStack {
                if let selected = selected {
                    let record = challengeRecords[selected]
                    Color(.background).ignoresSafeArea()
                    VStack(spacing: 24) {

                        // 도전 과제 카드
                        ChallengeCard(
                            text: record.challenge.title,
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
                                .accentColor(Color(.mainOrange))

                            if textEditorText == "" {
                                Text("도전을 이루었을 때 느꼈던 감정이나 성취감을 기록해보세요...")
                                    .foregroundColor(.darkGray)
                                    .padding(20)
                            }
                        }

                        // 저장 버튼
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
                    if canDelete {
                        Button("삭제") {
                            showAlert = true
                        }
                        .foregroundColor(Color(.mainOrange))
                    }

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
        .alert("정말로 기록을 삭제하시겠습니까?", isPresented: $showAlert) {
            Button("취소", role: .cancel) { showAlert = false }
            Button("삭제", role: .destructive) {
                let selectedIndex = selected ?? 0
                print("여기: \(String(describing: selected))")
                isWritten = false
                print("여기: \(isWritten)")
                selected = nil

                //                            if let selected = selected {
                context.delete(challengeRecords[selectedIndex])
                try? context.save()
                //                            }

                dismiss()
                print("여기: dismiss")
                dump(challengeRecords)
            }
        } message: {
            Text("도전기록을 삭제하면 복원이 불가합니다")
        }

    }

}
