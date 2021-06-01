//
//  DownAttributedString.swift
//  Down-SwiftUI-Example
//
//  Created by Mikhail Ivanov on 01.06.2021.
//  Copyright © 2021 Down. All rights reserved.
//

import SwiftUI
import Down

class MarkdownObservable: ObservableObject {
    let textView = UITextView()
    private let text: String
    
    @Published var isLoading: Bool = true
    
    init(text: String) {
        
        self.text = text
        
        loadingDown()
    }
    
    private func loadingDown() {
        let down = Down(markdownString: text)
        self.isLoading = true
        DispatchQueue(label: "markdownParse").async {
            let attributedText = try? down.toAttributedString()
            
            DispatchQueue.main.async {
                self.textView.attributedText = attributedText
                
                self.isLoading = false
            }
        }
    }
}

struct MarkdownRepresentable: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    @Binding var dynamicHeight: CGFloat
    @EnvironmentObject var markdownObject: MarkdownObservable
    
    init(height: Binding<CGFloat>) {
        self._dynamicHeight = height
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        /// Allows you to adjust the alignment of the text
        markdownObject.textView.textAlignment = .left
        
        return markdownObject.textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            uiView.textColor = colorScheme == .dark ? UIColor.white : UIColor.black
            DispatchQueue.main.async {
                dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width,
                                                           height: CGFloat.greatestFiniteMagnitude))
                    .height
            }
        }
    }
}

struct DownAttributedString: View {
    @ObservedObject private var markdownObject: MarkdownObservable
    private var markdownString: String
    @State private var isLoading: Bool = false
    @State private var height: CGFloat = .zero
    
    init(text: String) {
        self.markdownString = text
        self.markdownObject = MarkdownObservable(text: text)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if isLoading {
                GeometryReader { geometry in
                    ProgressView()
                        .frame(width: geometry.size.width,
                               height: geometry.size.height,
                               alignment: .center)
                }
            } else {
                ScrollView {
                    MarkdownRepresentable(height: $height)
                        .frame(height: height)
                        .environmentObject(markdownObject)
                }
            }
        }.onReceive(markdownObject.$isLoading, perform: { bool in
            isLoading = bool
        })
    }
}
