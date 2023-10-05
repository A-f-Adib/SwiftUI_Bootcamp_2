//
//  LongPressGesture.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/5/23.
//

import SwiftUI

struct LongPressGesture: View {
    @State var isComplete : Bool = false
    @State var isSuccess : Bool = false
    
    var body: some View {
        VStack{
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth : isComplete ? .infinity : 0)
                .frame(height : 100)
                .frame(maxWidth : .infinity , alignment: .leading)
                .background(.gray)
                .cornerRadius(5)
                .padding()
            
            HStack{
                Text("Click here")
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(20)
                    .onLongPressGesture(
                        minimumDuration: 1.0,
                        maximumDistance: 20) { (isPressing) in
                            if isPressing {
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    isComplete = true
                                }
                            }
                            else {
                                DispatchQueue.main.asyncAfter(deadline : .now() + 0.1){
                                    if !isSuccess {
                                        withAnimation(.easeInOut){
                                            isComplete = false
                                        }
                                    }
                                }
                                
                            }
                        } perform: {
                            withAnimation(.easeInOut){
                                
                                isSuccess = true
                            }
                        }

                        
                
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(.mint)
                    .cornerRadius(20)
                    .onTapGesture {
                        isSuccess = false
                        isComplete = false
                    }
            }
            
            
            Text(isComplete ? "Complete" : "Not Complete")
                .padding()
                .background(isComplete ? .green : .red)
                .cornerRadius(10)
                .padding()
            
                .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10, perform: {
                    isComplete.toggle()
                })
        }
    }
}

struct LongPressGesture_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGesture()
    }
}
