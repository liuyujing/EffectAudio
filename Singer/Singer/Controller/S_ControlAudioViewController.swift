//
//  S_ControlAudioViewController.swift
//  Singer
//
//  Created by Bruce on 16/7/29.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit
import AVFoundation

class S_ControlAudioViewController: S_BaseViewController,PlayerDelegate {

    var path:String?
    var timer:Timer?
    var player:Player?
    
    @IBOutlet var controlProgress: UISlider!
    @IBOutlet var controlButton: UIButton!
    
    @IBOutlet var startTime: UILabel!
    @IBOutlet var endTime: UILabel!
    @IBOutlet var audioTitle: UILabel!
    @IBOutlet var backgroundView: UIView!
    var effectView:S_PlayerEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layer = CAGradientLayer.init()
        layer.colors = [UIColor.black.cgColor,UIColor.lightGray.cgColor,UIColor( red: 0.0431, green: 0.0431, blue: 0.0431, alpha: 1.0 ).cgColor]
        layer.frame = SCREEN_BOUNDS
        layer.opacity = 1.0
        backgroundView.layer.addSublayer(layer)
        
//        必须重新设置音频会话为AVAudioSessionCategoryPlayback
//        否则 播放声音会很小
        let session = AVAudioSession.sharedInstance()
        try!session.setActive(true)
        try!session.setCategory(AVAudioSessionCategoryPlayback)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        player = Player.init(path!)
        audioTitle.text = "歌曲名:《\(path!)》"
        player?.delegate = self
        controlProgress.minimumValue = 0.0
        controlProgress.maximumValue = Float.init(player!.audioPlayer.duration)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        endTime.text = time(timeInterval: player!.audioPlayer.duration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stop()
    }
    
    func updateTime() {
        controlProgress.value = Float.init(player!.audioPlayer.currentTime)
        startTime.text = time(timeInterval: player!.audioPlayer.currentTime)
    }
    
    func start() {
        if effectView==nil {
            effectView = S_PlayerEffectView.init(frame: CGRect(x: 0.0, y: SCREEN_HEIGHT-10, width: view.bounds.width,height: 50.0))
            self.view.addSubview(effectView!)
            player!.play()
        }
        
    }
    
    func stop() {
        if effectView != nil {
            effectView?.removeFromSuperview()
            effectView = nil
            startTime.text = "0:00:00"
            endTime.text = "0:00:00"
            timer?.invalidate()
            timer = nil
            player!.stop()
        }
    }
    
    @IBAction func controlAction(_ sender: UIButton) {
        sender.isSelected = sender.isSelected != true ? true:false
        sender.isSelected == true ? start():stop()
    }
    
    @IBAction func progressControl(_ sender: UISlider) {
        player!.audioPlayer.currentTime = Double.init(sender.value)
        startTime.text = time(timeInterval: player!.audioPlayer.currentTime)
    }
    
    func didFinish() {
        controlButton.isSelected = false
        controlProgress.value = 0.0
        effectView?.removeFromSuperview()
        effectView = nil
    }
    
}
