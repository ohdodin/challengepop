//
//  AppStorageBootcamp.swift
//  ChallengePop
//
//  Created by Oh Seojin on 4/18/25.
//

import SwiftUI

struct AppStorageBootcamp: View {
    
    @State var currentUserName: String?
    
    var body: some View {
        VStack(spacing: 20){
            Text(currentUserName ?? "No name")
            
            if let name = currentUserName {
                Text(name)
            }
            
            Button("Save".uppercased()) {
                let name: String = "Nick"
                currentUserName = name

            }
        }
        .onAppear {

        }
    }
}

#Preview {
    AppStorageBootcamp()
}
