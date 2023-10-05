//
//  scrollViewReader.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/6/23.
//

import SwiftUI

struct scrollViewReader: View {
    
    @State var textField : String = ""
    @State var scrollindex : Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter an id...", text: $textField)
                .padding()
                .frame(height : 55)
                .border(.gray)
                .padding(.horizontal)
                
            Button("Scroll") {
                withAnimation(.spring()){
                    if let index = Int (textField)
                    {
                        scrollindex = index
                    }
                }
            }
            
            
            ScrollView{
                ScrollViewReader { proxy in
                    ForEach(0..<500) { data in
                        Text("Id no = \(data)")
                            .font(.headline)
                            .frame(height : 50)
                            .frame(maxWidth : .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(data)
                    }
                    .onChange(of: scrollindex, perform: { value in
                        withAnimation(.spring()){
                            proxy.scrollTo(value, anchor: .top)
                        }
                        
                    })
                }
            }
        }
    }
}

struct scrollViewReader_Previews: PreviewProvider {
    static var previews: some View {
        scrollViewReader()
    }
}
