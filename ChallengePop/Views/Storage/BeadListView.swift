//
//  BeadListView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct BeadListView: View {
    @State private var showModal = false
    @State private var selected: Int? = nil
    @State private var beads: [ChallengeRecord] = [ChallengeRecord(challenge: ChallengeData.challengeList[4], isDone: true, isWritten: true, content: "이것만 내용 작성했지요~"),
         ChallengeRecord(challenge: ChallengeData.challengeList[8], isDone: true, isWritten: true),
         ChallengeRecord(challenge: ChallengeData.challengeList[2], isDone: true, isWritten: true),
         ChallengeRecord(challenge: ChallengeData.challengeList[11], isDone: true, isWritten: true),
         ChallengeRecord(challenge: ChallengeData.challengeList[9], isDone: true, isWritten: true),
         ChallengeRecord(challenge: ChallengeData.challengeList[7], isDone: true, isWritten: true),
         ChallengeRecord(challenge: ChallengeData.challengeList[1], isDone: true, isWritten: true),
         ChallengeRecord(challenge: ChallengeData.challengeList[0], isDone: true, isWritten: true),
         ChallengeRecord(challenge: ChallengeData.challengeList[8], isDone: true, isWritten: true)]

    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 4)
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack(spacing: 24) {
                Spacer()
                
                // 상단 보기
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.white))
                    if let selected = selected {
                        topView(index: selected)
                    } else {
                        blankTopView
                    }
                }

                // 하단 구슬 리스트
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.white))
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(beads.indices, id: \.self) { index in
                                beadCard(bead: beads[index], index: index)
                                    .onTapGesture {
                                        selected = index
                                    }
                            }
                        }
                        .padding(16)
                    }
                }
                
                Spacer()
            }
            .sheet(isPresented: $showModal) {
                if let selected = selected {
                    BeadEditView(bead: $beads[selected])

                }
            }
            .padding(36)
        }
        .navigationTitle("도전일기")
    }

    // 구슬 개별 카드
    private func beadCard(bead: ChallengeRecord, index: Int) -> some View {
        VStack(spacing: 4) {
            Image(bead.challenge.category.beadName ?? "bead_blank")
                .resizable()
                .frame(width: 54, height: 54)
            ZStack {
                Text(formattedDate(from: bead.date))
                    .foregroundColor(selected == index ? .white : .black)
                    .padding(.horizontal, 8)
                    .font(.caption)
            }
            .background(selected == index ? Color(.mainOrange) : Color(.clear))
            .cornerRadius(10)
        }
        .padding(8)
        .background(selected == index ? Color(.selected) : Color(.clear))
        .cornerRadius(15)
    }

    // 상단 보기 (빈)
    var blankTopView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image("bead_blank")
                .resizable()
                .frame(width: 54, height: 54)
            Text("구슬을 눌러 도전과제를 확인하세요!")
                .font(.body)
                .foregroundColor(.darkGray)
            Spacer()
        }
        .padding(24)

    }
    
    // 상단 보기 (선택)
    func topView(index: Int) -> some View {
        VStack (spacing: 16) {
            Image(beads[index].challenge.category.beadName)
                .resizable()
                .frame(width: 54, height: 54)
            ChallengePop.formattedDate(date: beads[index].date)
            ChallengeCard(text: beads[index].challenge.title, emoji: beads[index].challenge.emoji)
            if let content = beads[index].content {
                Text(content)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            } else {
                Text("작성된 내용이 없습니다.")
            }
        }
        .padding(24)
        .onTapGesture {
            if beads[index].content != nil {
                selected = index
                showModal = true
            }
        }

    }

    func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

}

#Preview {
    BeadListView()
}
