//
//  Player.swift
//  Singer
//
//  Created by Bruce on 16/7/29.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import AVFoundation

protocol PlayerDelegate : NSObjectProtocol {
    func didFinish()
}
class Player: NSObject,AVAudioPlayerDelegate {
    
    var delegate:PlayerDelegate?
    var audioPlayer = AVAudioPlayer()
    init(_ audioPath:String) {
        super.init()
        let url = URL.init(fileURLWithPath: documentFile(audioPath))
        
        audioPlayer = try!AVAudioPlayer.init(contentsOf: url)
        audioPlayer.delegate = self
        audioPlayer.volume = 1.0
        audioPlayer.prepareToPlay()
    }
    
    func play() {
        
        audioPlayer.play()
    }
    
    func stop() {
        
        audioPlayer.stop()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag {
            delegate?.didFinish()
        }
    }
   
}
