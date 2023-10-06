//
//  LocalNotificaton.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/6/23.
//

import SwiftUI
import UserNotifications


class NoticationManager {
    
    static let instance = NoticationManager()
    
    func ScheduleNotification () {
        let content = UNMutableNotificationContent()
        content.title = "This is a notification"
        content.subtitle = "This is subtitle"
        content.sound = .default
        content.badge = 1
        
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5.0,
            repeats: false)
        
        let request = UNNotificationRequest(
            identifier:  UUID().uuidString,
            content: content,
            trigger: trigger )
        
        UNUserNotificationCenter.current().add(request)
            
            
    }
}



struct LocalNotificaton: View {
    var body: some View {
        Button("Schedule notification") {
            NoticationManager.instance.ScheduleNotification()
        }
    }
}

struct LocalNotificaton_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificaton()
    }
}
