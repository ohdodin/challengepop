//
//  RecordStatusView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct RecordCheckView: View {
    @AppStorage("isWritten") var isWritten: Bool = false
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack(spacing: 88) {
                VStack(spacing: 8) {
                    Text("오늘의 도전과제")
                        .font(.body)
                    ChallengeCard(text: "하루 10분 스트레칭 하기", emoji:"🧘🏻")
                    Text("오늘의 도전과제")
                        .font(.body)
                }
                
                VStack (spacing: 16){
                    NavigationLink {
//                        RecordInputView()
                    } label: {
//                        NavigationButton(text: "오늘 도전 완료!", isDisabled: .constant(false))
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        // today / challengeRecord -> isCompleted = true
                        // today / challengeRecord -> idDone = true
                        updateRecord(isCompleted: true)
                    })
                    NavigationLink {
//                        RecordInputView()
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
                    .simultaneousGesture(TapGesture().onEnded {
                        // today / challengeRecord -> isCompleted = false
                        // today / challengeRecord -> idDone = true
                        updateRecord(isCompleted: false)
                    })
                }
                
            }
            .padding(36)
        }
        .navigationTitle("도전일기")
    }
    
    func updateRecord(isCompleted: Bool) {
        let today = Calendar.current.startOfDay(for: Date())
        
//        if let index = user.challengeRecords.firstIndex(where: {
//            Calendar.current.isDate($0.date, inSameDayAs: today)
//        }) {
//            user.challengeRecords[index].isWritten = isWritten
//            user.challengeRecords[index].isDone = true
//        }
    }
}

#Preview {
    RecordCheckView()
}
