////
////  CustomNavigationBar.swift
////  ChallengePop
////
////  Created by Oh Seojin on 4/19/25.
////
//
//import SwiftUI
//
//struct CustomNavigationBar: View {
//    
//    @Binding var step: Int
//    let title: String
//    @AppStorage("isSelected") var isSelected: Bool = false
//    
//    var body: some View {
//        VStack (alignment: .leading){
//            if step > 0 && !isSelected {
//                Button {
//                    step -= 1
//                } label: {
//                    HStack {
//                        Image(systemName: "chevron.left")
//                        Text("뒤로")
//                    }
//                }
//                .foregroundColor(.mainOrange)
//                .frame(height: 44)
//            } else {
//                Color.clear.frame(height: 44)
//            }
//            
//            Text(title)
//                .font(.title)
//                .bold()
//
//        }
//        .frame(maxWidth: UIScreen.main.bounds.width - 36, alignment: .leading)
//    }
//}
//
//#Preview {
//    @State var step = 0
//    CustomNavigationBar(step: $step, title: "도전과제")
//}
