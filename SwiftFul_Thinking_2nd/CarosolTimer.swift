//
//  carosolTimer.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/16/23.
//

import SwiftUI

struct CarosolTimer: View {
    
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    @State var count : Int = 1
    
    
    var body: some View {
        ZStack{
            Color.mint.ignoresSafeArea()
            
            TabView(selection: $count, content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.yellow)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            })
                .frame(height : 200)
                .cornerRadius(10)
                .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()){
                
                count = count == 5 ? 1 : count + 1
            }
            
        })

    }
}

struct CarosolTimer_Previews: PreviewProvider {
    static var previews: some View {
        
        CarosolTimer()
    }
}
