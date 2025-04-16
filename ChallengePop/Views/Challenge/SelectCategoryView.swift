import Foundation
import SwiftUI

struct SelectCategoryView: View {

    @State private var selectedCategory: Category? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color("BackgroundColor")).ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {
                    Spacer()

                    VStack(spacing: 24){
                        HStack(spacing: 0) {
                            Text("오늘의 ")
                                .font(.headline)
                            Text("도전 과제")
                                .font(.headline)
                                .foregroundColor(Color("MainColor"))
                            Text("를 선택하세요.")
                                .font(.headline)
                        }
                        Grid(
                            alignment: .center,
                            horizontalSpacing: 16,
                            verticalSpacing: 16
                        ) {
                            GridRow {
                                cell(category: Category.allCases[0])
                                cell(category: Category.allCases[1])
                            }
                            GridRow {
                                cell(category: Category.allCases[2])
                                cell(category: Category.allCases[3])
                            }
                        }
                    }
                    .frame(
                        width: UIScreen.main.bounds.width - 72,
                        height: UIScreen.main.bounds.height - 490
                    )

                    Spacer()

                    NavigationLink {

                        SelectDifficultyView(
                            selectedCategory: $selectedCategory
                        )

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
                                    height: 50
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
    
    private func cell(category: Category) -> some View {
        Button {
            selectedCategory = category
    } label: {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .stroke(selectedCategory==category ?  Color("MainColor") :  Color("BorderColor"), lineWidth:
                   selectedCategory==category ? 3 : 1
                )
            VStack {
                Image(category.imageName)
                    .resizable()
                    .frame(
                        width: 100,
                        height: 100,
                        alignment: .center
                    )
                Text(category.rawValue)
                    .foregroundColor(
                        Color("BlackColor")
                    )
            }
        }
    }
        
    }
}

#Preview {
    SelectCategoryView()
}
