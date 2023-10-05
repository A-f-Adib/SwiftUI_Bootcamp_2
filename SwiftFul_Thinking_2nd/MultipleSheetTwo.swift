//
//  MultipleSheetTwo.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/6/23.
//

import SwiftUI

struct randomModel : Identifiable {
    let id = UUID().uuidString
    let title : String
}

struct MultipleSheetTwo: View {
    
    @State var selectedText : randomModel? = nil
    
    var body: some View {
        
        VStack(spacing : 20) {
            
            ForEach(0..<6){ data in
                Button("Button \(data)") {
                    selectedText = randomModel(title: "Sheet \(data)")
                }
            }
        }
        .sheet(item: $selectedText) { newData in
            nextScreen(selectText: newData )
        }
    }
}

struct nextScreen : View {
    let selectText : randomModel
    var body: some View {
        Text(selectText.title)
    }
}

struct MultipleSheetTwo_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetTwo()
    }
}
