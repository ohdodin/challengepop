//
//  formattedDate.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/18/25.
//

import SwiftUI

struct formattedDate: View {
    let date: Date
    
    var body: some View {
        Text(formattedDate(from: date))
            .foregroundColor(.darkGray)
    }
    
    func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 E요일"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

}

#Preview {
    formattedDate(date: Date())
}
