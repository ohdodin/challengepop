import SwiftUI

struct TabVIewBootcamp: View {
    @State var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            Text("GLOBE TAB")
                .tabItem {
                    Image(systemName: "globe")
                    Text("Home")
                }
                .tag(1)
            Text("PERSON TAB")
                .tabItem {
                    Image(systemName: "person")
                    Text("Home")
                }
                .tag(2)
        }
        .accentColor(Color("MainColor"))
    }
}

struct HomeView: View {

    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            Color(.background)
            VStack {
                Text("Home Tab")
                Button {
                    selectedTab = 2
                } label: {
                    Text("Click Here!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(.red)
                }

            }
        }
    }
}

#Preview {
    TabVIewBootcamp()
}
