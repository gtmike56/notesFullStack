//
//  ContentView.swift
//  NotesApp
//
//  Created by Mikhail Udotov on 22.03.2021.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    var body: some View {
        HomeScreen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 11 Pro Max")
    }
}
