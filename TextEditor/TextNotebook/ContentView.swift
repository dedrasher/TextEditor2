//
//  ContentView.swift
//  TextNotebook
//
//  Created by Serega on 16.10.2021.
//

import SwiftUI
import Foundation
struct ContentView: View {
    @FocusState private var focus : Bool?
    @Binding var document: TextDocument
    func wordsCount() -> Int {
        let components = $document.text.wrappedValue.components(separatedBy: .whitespacesAndNewlines)
           let words = components.filter { !$0.isEmpty }
           return words.count
       }
            var body: some View {
                VStack
                {
                    TextEditor(text: $document.text).focused($focus, equals: true).onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                    }
                }.toolbar{
                    ToolbarItem(placement: .bottomBar) {
                        if wordsCount() > 0 {
                                           Text("Words count: " + String(wordsCount()))
                                       }
                    }
                }.onAppear{
                    if(document.text == "") {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                  self.focus = true
                              }
                    }
                }
                }
               
              
            
            }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(TextDocument()))
    }
}


