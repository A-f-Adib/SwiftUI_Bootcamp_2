//
//  TimerUI.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/15/23.
//

import SwiftUI

struct TimerUI: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var count : Int = 10
    @State var finished : String? = nil
    
    var body: some View {
        ZStack{
            Color.yellow
            
            Text(finished ?? "\(count)")
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { _ in
            
            if count <= 1 {
                finished = "Happy new year"
            } else {
                count -= 1
            }
            
        })
    }
}

struct TimerUI_Previews: PreviewProvider {
    static var previews: some View {
        TimerUI()
    }
}
