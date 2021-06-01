//
//  ContentView.swift
//  Down-SwiftUI-Example
//
//  Created by Mikhail Ivanov on 01.06.2021.
//  Copyright © 2021 Down. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var markdownString: String
    
    init() {
        if let readMeURL = Bundle.main.url(forResource: nil, withExtension: "md"),
           let readMeContents = try? String(contentsOf: readMeURL) {
            markdownString = readMeContents
        }
        else {
            markdownString = ""
                debugPrint("Could not load readme contents.")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: DownHTML(markdownString: markdownString),
                    label: {
                        Text("Down HTML")
                    })
            }
            .navigationBarHidden(true)
        }
        
    }
}
