//import SwiftUI
//
//struct ChallengeDetailView: View {
//    
//    @State var disabled: Bool = false
//    @Binding var tabSelection: Int
//    @AppStorage("isSelected") var isSelected: Bool = false
//    @AppStorage("isWritten") var isWritten: Bool = false
//    
//    var challenge: Challenge {
////        if let lastRecord = user.challengeRecords.last {
////            return lastRecord.challenge
////        }
//        // 기록이 없는 경우 기본 도전과제 반환
////        return ChallengeData.challengeList[2]
//    }
//
//    var body: some View {
//        ZStack {
//            Color(.background).ignoresSafeArea()
//
//            VStack {
//                Spacer()
//                
//
//                // 도전과제 보기
//                VStack (spacing: 16) {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 20)
//                            .fill(.white)
//                            .stroke(.border, lineWidth: 1)
//                        VStack(spacing: 24) {
//                            Text(challenge.title)
//                            Text(challenge.emoji)
//                                .font(.system(size: 100))
//                            Text(challenge.description)
//                                .font(.body)
//                                .multilineTextAlignment(.center)
//                        }
//                        .padding(24)
//                    }
//                    .frame(height: 300)
//                    VStack (spacing: 4) {
//                        HStack (spacing: 4) {
//                            Text("추천 시간:")
//                                .bold()
//                            Text(challenge.recommendedTime)
//                        }
//                        HStack {
//                            Text("추천 장소:")
//                                .bold()
//                            Text(challenge.recommendedPlace)
//                        }
//                    }
//                    
//                }
//
//                Spacer()
//
//                // 체크하러가기 버튼
//                if !isWritten{
//                    Button {
//                        tabSelection = 1
//                    } label: {
////                        NavigationButton(text: "체크하러 가기", isDisabled: .constant(false))
//                    }
//                }
//
//            }
//            .padding(36)
//
//        }
//        .navigationTitle("도전과제")
//        .navigationBarBackButtonHidden(true)
//
//    }
//    
//    
//}
//
//#Preview {
//    ChallengeDetailView(tabSelection: .constant(0))
//}
