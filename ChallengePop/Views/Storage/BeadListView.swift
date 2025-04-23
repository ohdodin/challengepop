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
    @Query(sort: \ChallengeRecord.createdAt, order: .reverse) private
        var challengeRecords: [ChallengeRecord]  // 값을 불러오는 순서를 보장할 수 없음, sort, created at으로 정렬

    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 4)

    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            ScrollView {

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
                    .frame(height: 218)

                    // 하단 구슬 리스트
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.white))

                        LazyVGrid(
                            columns: columns,
                            alignment: .leading,
                            spacing: 0
                        ) {
                            ForEach(challengeRecords.indices, id: \.self) {
                                index in
                                beadCard(
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
                        .frame(
                            minHeight: UIScreen.main.bounds.height - 514,
                            alignment: .top
                        )

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
                        // 여기!!
                        InputModalView(
                            canDelete: true,
                            selected: $selected
                        )

                    }

                }
            }
        }
        .navigationTitle(tabName.storage.stringValue)
        .onAppear {
            selected = nil
        }
    }

    // 하단 구슬리스트 개별 카드
    private func beadCard(index: Int) -> some View {
        VStack(spacing: 4) {
            let _ = print(
                "BeadListView: beadcard 통과 \(index), \(challengeRecords.count)"
            )
            //            if index < challengeRecords.count {
            // 정상 처리
            Image(challengeRecords[index].beadName)
                .resizable()
                .frame(width: 54, height: 54)
            ZStack {
                Text(
                    formattedSimpleDate(
                        from: challengeRecords[index].createdAt
                    )
                )
                .foregroundColor(selected == index ? .white : .black)
                .padding(.horizontal, 8)
                .font(.caption)

            }

            .background(
                selected == index ? Color(.mainOrange) : Color(.clear)
            )
            .cornerRadius(10)
            //            }
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
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                HStack {
                    Spacer()
                    Button {
                        showModal = true
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                Text(
                    formattedSimpleDate(from: challengeRecords[index].createdAt)
                )
                .foregroundColor(.darkGray)
                Text(
                    challengeRecords[index].challenge.title
                )
                .font(.title3)
                .bold()
            }

            VStack (alignment: .center) {
                if let content = challengeRecords[index].content {
                    Text(content)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                } else {
                    Text("도전을 이루었을 때 느꼈던 감정이나 성취감을 기록해보세요...")
                        .font(.caption)
                        .foregroundColor(.darkGray)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
            }
            Spacer()
            
        }
        .padding(24)

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
