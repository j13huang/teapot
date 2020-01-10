//
//  ContentView.swift
//  Teapot
//
//  Created by John Huang on 12/30/19.
//  Copyright © 2019 John Huang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = true
    
    var body: some View {
        Section {
            Text("Hello, World!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.alert(isPresented: $showingAlert) {
        Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
        }.onAppear(perform: {
            print("yOOOO")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
