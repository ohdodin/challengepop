import SwiftUI

struct ChallengeDetailView: View {
    
    @State var disabled: Bool = false
    @Binding var tabSelection: Int
    @EnvironmentObject var user: User
    @AppStorage("isSelected") var isSelected: Bool = false

    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()

            VStack {
                Spacer()
                

                // 도전과제 보기
                VStack (spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .stroke(.border, lineWidth: 1)
                        VStack(spacing: 24) {
                            Text(ChallengeData. ?? "empty")
                                .cornerRadius(15)
                            Text("🧘🏻")
                                .font(.system(size: 100))
                            Text("상세정보")
                                .font(.body)
                        }
                        .padding(24)
                    }
                    .frame(height: 300)
                    VStack (spacing: 4) {
                        HStack (spacing: 4) {
                            Text("추천 시간:")
                                .bold()
                            Text("아침 기상 직후 / 자기 전")
                        }
                        HStack {
                            Text("추천 장소:")
                                .bold()
                            Text("바닥에 매트를 깔고 편안하게")
                        }
                    }
                    
                }

                Spacer()

                // 체크하러가기 버튼
                if !isSelected{
                    Button {
                        tabSelection = 1
                    } label: {
                        NavigationButton(text: "체크하러 가기", isDisabled: .constant(false))
                        //                        .hidden(isWritten)
                    }
                }

            }
            .padding(36)

        }
        .navigationTitle("도전과제")
        .navigationBarBackButtonHidden(true)

    }
    
    
}

#Preview {
    ChallengeDetailView(tabSelection: .constant(0))
        .environmentObject(User())
}
