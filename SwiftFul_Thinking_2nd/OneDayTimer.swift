//
//  OneDayTimer.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/16/23.
//

import SwiftUI


struct OneDayTimer: View {

    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var timeRemain : String = ""
    
    let futureDate : Date = Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date()
    
    
    
    func updateTime () {
        
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        timeRemain = "\(hour): \(minute) : \(second)"
    }
    
    
    
    
    var body: some View {
        ZStack{
            Color.green
            
            Text(timeRemain)
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { _ in
          updateTime()
            
        })
    }
}

struct OneDayTimer_Previews: PreviewProvider {
    static var previews: some View {
        OneDayTimer()
    }
}
