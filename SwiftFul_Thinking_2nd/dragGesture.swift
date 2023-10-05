//
//  dragGesture.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/5/23.
//

import SwiftUI

struct dragGesture: View {
    
    @State var offsetY : CGFloat = UIScreen.main.bounds.height * 0.83
    @State var currentOffset : CGFloat = 0
    @State var endOffset : CGFloat = 0
    
    var body: some View {
        
        ZStack{
            Color.green.ignoresSafeArea()
            
            SignUpView()
                .offset(y: offsetY)
                .offset(y: currentOffset)
                .offset( y: endOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                            currentOffset = value.translation.height
                            }
                        }
                        .onEnded { value in
                            
                            withAnimation(.spring()) {
                                if currentOffset < -150
                                {
                                    endOffset = -offsetY
                                    currentOffset = 0
                                    
                                } else if endOffset != 0 && currentOffset > 150 {
                                    endOffset = 0
                                    currentOffset = 0
                                }
                                else {
                                    currentOffset = 0
                                }
                            }
                        }
                )
        }
        .ignoresSafeArea(edges : .bottom)
    }
}

struct dragGesture_Previews: PreviewProvider {
    static var previews: some View {
        dragGesture()
    }
}

struct SignUpView: View {
    var body: some View {
        VStack(spacing : 20){
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width : 100, height: 100)
            
            Text("This is the discrption of the app")
            
            Text("Create an account")
                .padding()
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .background(.black)
                .cornerRadius(10)
            Spacer()
            
        }
        .frame(maxWidth : .infinity)
        .background(.white)
        .cornerRadius(20)
    }
}
