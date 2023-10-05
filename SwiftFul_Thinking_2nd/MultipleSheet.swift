//
//  MultipleSheet.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/6/23.
//

import SwiftUI

struct RandomModel : Identifiable {
    let id = UUID().uuidString
    let title : String
}

struct MultipleSheet: View {
    
    @State var selectedModel : RandomModel = RandomModel(title: "Starting title ")
    @State var showSheet : Bool = false
    @State var showSheet2 : Bool = false
    
    var body: some View {
        VStack(spacing : 20){
            Button("Button 1") {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet, content: {
                nextView(selectedModel: RandomModel(title: "Sheet One"))
            })
            
            
            
            Button("Button 2") {
                showSheet2.toggle()
            }
            .sheet(isPresented: $showSheet2, content: {
                nextView(selectedModel: RandomModel(title:"Sheet Tow"))
            })
        }
    }
}

struct nextView : View {
    
    let selectedModel : RandomModel
    
    var body: some View {
        
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheet_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheet()
    }
}
