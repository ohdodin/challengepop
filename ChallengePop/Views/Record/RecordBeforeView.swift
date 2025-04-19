//
//  RecordBeforeView.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/15/25.
//

import SwiftUI

struct RecordBeforeView: View {
    @Binding var tabSelection: Int
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack {
                Spacer()
                // 오늘 날짜
                formattedDate(date: Date())
                
                VStack(spacing: 64) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(.background))
                            .stroke(Color(.border), lineWidth: 1)
                            .frame(height: 60)
                        Text("도전과제가 아직 없어요!")
                            .font(.title3)
                            .foregroundColor(.darkGray)
                        
                    }
                    VStack {
                        Image("sparkle")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("오늘의 나를 위한 작은 도전을\n시작해볼까요?")
                            .multilineTextAlignment(.center)
                        
                    }

                }
                Spacer()
                Button {
                    tabSelection = 0
                }label: {
                NavigationButton(text: "선택하러 가기", isDisabled: .constant(false))
                        
                }

            }
            .padding(36)
        }
    }
}

#Preview {
    RecordBeforeView(tabSelection: .constant(1))
}
