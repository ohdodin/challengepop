import Foundation
import SwiftUI

struct InputModalView: View {
    
    var today: Date
    var canDelete: Bool = false
    
    @State var textEditorText: String = ""
    @Binding var user: User
    @Binding var record: ChallengeRecord
    @Environment(\.dismiss) var dismiss

    @AppStorage("isWritten") var isWritten: Bool = false

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background).ignoresSafeArea()
                VStack (spacing: 24) {
                    
                    // 도전 과제 카드
                    if let lastRecord = user.challengeRecords.last {
                        ChallengeCard(
                            text: lastRecord.challenge.title,
                            emoji: lastRecord.challenge.emoji
                        )
                    }
                    
                    // 텍스트 입력 필드
                    TextEditor(text: $textEditorText)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.border, lineWidth: 1)
                        )
                    
                    // 삭제 버튼
                    if canDelete {
                        VStack {
                            Text("작성한 일기의 내용만 삭제됩니다.")
                                .foregroundColor(Color(.darkGray))
                                .font(.caption)
                            NavigationButton(text: "삭제하기", step: .constant(0), isDisabled: .constant(false), onTap: {
                                record.content = ""
                                record.isWritten = false
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
                            isWritten = true
                            dismiss()
                        }
                        .foregroundColor(Color(.mainOrange))
                    }
                }
            }
        }
        .onAppear()
    }
}

#Preview {
    @State var user = User()
    @State var record: ChallengeRecord =  ChallengeRecord(challenge: ChallengeData.challengeList[0])
    
    InputModalView(today: Date(), canDelete: true, user: $user, record: $record)
}
