//
//  ContentView.swift
//  SpaceProj
//
//  Created by Tanvir on 09/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = SpaceAPI()
    @State private var opac = 0.0
    
    
    var body: some View {
        NavigationView{
            VStack {
                NewsView()
                    .opacity(opac)
                
            }
            .navigationTitle("Space News")
            .environmentObject(data)
            .onAppear{
                data.getData()
                
                withAnimation(.easeIn(duration: 2)) {
                    opac = 1.0
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
