//
//  S_RecordViewController.swift
//  Singer
//
//  Created by Bruce on 16/6/27.
//  Copyright © 2016年 Bruce. All rights reserved.
//
import UIKit
import AVFoundation

class S_RecordViewController: S_BaseViewController {
    
    @IBOutlet var controlButton: UIButton!
    @IBOutlet var finishAudioButtonItem: UIBarButtonItem!
    
    var button:UIButton?
    var showContentView:S_ShowContentView?
    var effectView:S_EffectView?
    var timer:Timer?
    var timeNum = 0.0
    
    @IBOutlet var recoderTimeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = AVAudioSession.sharedInstance()
        try!session.setActive(true)
        try!session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timeNum = 0.0
        recoderTimeLabel.text = "00:00:00"
        let session = AVAudioSession.sharedInstance()
        try!session.setActive(true)
        try!session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    }
    
    func start() {
        if effectView==nil {
            timeNum = 0.0
            recoderTimeLabel.text = "00:00:00"
            Recoder.recoder.startRecoder()
            effectView = S_EffectView.init(frame:CGRect(x: SCREEN_WIDTH/5, y: SCREEN_HEIGHT/3, width: SCREEN_WIDTH/2,height: 50.0))
            self.view.addSubview(effectView!)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updataTime), userInfo: nil, repeats: true)
            
        }
    }
    
    func updataTime() {
        timeNum += 1
        recoderTimeLabel.text = time(timeInterval: timeNum)
    }
    
    func stop() {
        if effectView != nil {
            Recoder.recoder.stopRecoder()
            timer?.invalidate()
            timer = nil
            effectView?.removeFromSuperview()
            effectView = nil
            
        }
    }
    @IBAction func controlAudio(sender: AnyObject) {
        let button = sender as? UIButton
        
        button!.isSelected = button!.isSelected != true ? true:false
        button!.isSelected == true ? start():stop()
    }
    
    @IBAction func showFinishAudioList(sender: AnyObject) {
        if Recoder.recoder.recoding() {
            Recoder.recoder.stopRecoder()
            timer?.invalidate()
            timer = nil
            timeNum = 0.0
            recoderTimeLabel.text = "00:00:00"
        }
        
        let mainSB = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = mainSB.instantiateViewController(withIdentifier: "S_FinishAudioFileController") as! S_FinishAudioFileController
        vc.audioFiles = searchDocumentFiles(fileType:AUDIO_TYPE)
        
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}
