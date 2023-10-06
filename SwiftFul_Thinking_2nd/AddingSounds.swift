//
//  AddingSounds.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/6/23.
//

import SwiftUI
import AVKit

class soundManager {
    
    static let instance = soundManager()
    var player : AVAudioPlayer?
    
    enum SoundOption : String {
        case bada
        case tada
    }
    
    
    func playSound (sound : SoundOption) {
        
        guard let url = Bundle.main.url(forResource:sound.rawValue, withExtension: ".mp3") else { return }
        
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
}

struct AddingSounds: View {
    var body: some View {
        VStack(spacing : 20){
            Button("Sound 1") {
                
                soundManager.instance.playSound(sound: .bada)
            }
            Button("Sound 2") {
                soundManager.instance.playSound(sound: .tada)
            }
        }
    }
}

struct AddingSounds_Previews: PreviewProvider {
    static var previews: some View {
        AddingSounds()
    }
}
