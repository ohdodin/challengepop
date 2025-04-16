import Foundation
import SwiftUI

struct SelectCategoryView: View {

    @State private var selectedCategory: Category? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color("BackgroundColor")).ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("오늘의 ")
                            .font(.headline)
                        Text("도전 과제")
                            .font(.headline)
                            .foregroundColor(Color("MainColor"))
                        Text("를 선택하세요.")
                            .font(.headline)
                    }

                    Spacer()

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()), GridItem(.flexible()),
                        ],
                        spacing: 16
                    ) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
                                        .stroke(
                                            Color("BorderColor"),
                                            lineWidth: 1
                                        )
                                        .frame(
                                            width: (UIScreen.main.bounds.width
                                                - 88) / 2,
                                            height: (UIScreen.main.bounds.height
                                                - 548) / 2
                                        )
                                    Text(category.rawValue)
                                        .font(.body)
                                        .foregroundColor(Color("BlackColor"))
                                }
                            }
                        }
                    }

                    Spacer()

                    NavigationLink {

                        SelectDifficultyView(selectedCategory: $selectedCategory    )

                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    selectedCategory == nil
                                        ? Color("DisabledColor")
                                        : Color("MainColor")
                                )
                                .frame(
                                    width: (UIScreen.main.bounds.width - 64),
                                    height: 44
                                )
                            Text("다음")
                                .foregroundColor(.white)

                        }
                    }
                    .disabled(selectedCategory == nil)

                }
                .padding(36)

            }
            .navigationTitle("도전과제")

        }
    }
}

#Preview {
    SelectCategoryView()
}
