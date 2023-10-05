//
//  MagnificationGesture.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/5/23.
//

import SwiftUI

struct magnificationGesture: View {
    @State var currentAmount : CGFloat = 0
    @State var lastAmount : CGFloat = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.mint)
            .cornerRadius(20)
            .scaleEffect(1 + currentAmount)
            .gesture(
               MagnificationGesture()
                .onChanged { value in
                    currentAmount = value - 1
                }
                .onEnded { value in
                    withAnimation(.spring()){
                        currentAmount = 0
                    }
                }
            )
    }
}

struct magnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        magnificationGesture()
    }
}
