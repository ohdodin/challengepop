//
//  BeadListView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftData
import SwiftUI

struct BeadListView: View {

    @State private var showModal = false
    @State private var selected: Int? = nil

    @Environment(\.modelContext) private var context
    @Query private var challengeRecords: [ChallengeRecord]

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
                        // 선택된 경우
                        topView(index: selected)
                    } else {
                        // 빈 경우
                        blankTopView
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.border, lineWidth: 1)
                )

                // 하단 구슬 리스트
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.white))
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(challengeRecords.indices, id: \.self) {
                                index in
                                beadCard(
                                    bead: challengeRecords[index],
                                    index: index
                                )
                                .onTapGesture {
                                    if selected == index {
                                        selected = nil
                                    } else {
                                        selected = index
                                    }
                                }
                            }
                        }
                        .padding(16)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.border, lineWidth: 1)
                )

                Spacer()
            }
            .padding(36)
            .sheet(isPresented: $showModal) {
                if let index = selected,
                    challengeRecords.indices.contains(index)
                {
                    InputModalView(
                        canDelete: true,
                        record: challengeRecords[index]
                    )
                } else {
                    // 혹시나 모르니 fallback도 추가
                    Text("기록을 불러올 수 없습니다.")
                }

            }
        }
        .navigationTitle(tabName.storage.stringValue)
        .onAppear {
        }
    }

    // 하단 구슬리스트 개별 카드
    private func beadCard(bead: ChallengeRecord, index: Int) -> some View {
        VStack(spacing: 4) {
            Image(bead.challenge.category.beadName)
                .resizable()
                .frame(width: 54, height: 54)
            ZStack {
                Text(formattedSimpleDate(from: challengeRecords[index].date))
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
        VStack(spacing: 16) {
            Image(challengeRecords[index].challenge.category.beadName)
                .resizable()
                .frame(width: 54, height: 54)
            Text(formattedSimpleDate(from: challengeRecords[index].date))
                .foregroundColor(.darkGray)
            ChallengeCard(
                text: challengeRecords[index].challenge.title,
                emoji: challengeRecords[index].challenge.emoji
            )
            if let content = challengeRecords[index].content {
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
            showModal = true
        }

    }

    // 날짜
    func formattedSimpleDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

}

#Preview {
    BeadListView()
}
