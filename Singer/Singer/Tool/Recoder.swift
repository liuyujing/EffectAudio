//
//  Recoder.swift
//  Singer
//
//  Created by Bruce on 16/7/29.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import AVFoundation

class Recoder: NSObject {
    
    static let recoder = Recoder()
    
    //    初始化音频引擎
    lazy var engine = AVAudioEngine()
    var index = 0
    //    MARK:----准备----
    func prepare(){
        //        输入节点
        let inputNode = engine.inputNode!
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        
        //        效果器
//        let eqNode = eq(engine: engine)
        
        let reverbNode = reverb(engine: engine)
        let delayNode = delay(engine: engine)
        
        //        音频文件
        let audioFile = recoderFile(toPath: path .appendingPathComponent("\(timeStamp()).\(AUDIO_TYPE)"))
   
        //        混音节点
        let mixNode = mixer(engine: engine)
//        录制的时候必须保障 录制的音频格式 和输出的音频格式 为加工的格式（processingFormat）
//        audioFile.processingFormat
        mixNode.installTap(onBus: 0, bufferSize: 4410, format: audioFile.processingFormat) { (buffer, when) in
            try! audioFile.write(from: buffer)
        }
        
        //        输出节点
        let outputNode = engine.outputNode
        
        //        连接节点
        connectionNodes(nodes: [inputNode,reverbNode,delayNode,mixNode,outputNode], format: audioFile.processingFormat, engine:engine)
    }
    
    //    MARK:----创建节点相关-----
    //    音频写入的文件
    func recoderFile(toPath path:String) -> AVAudioFile {
        
        let audioFile = try! AVAudioFile.init(forWriting: NSURL.fileURL(withPath: path), settings: [AVSampleRateKey:44100,AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue])
        
        return audioFile
    }
    
    //    混音
    func mixer(engine audioEngine:AVAudioEngine) -> AVAudioMixerNode {
        let mixerNode = AVAudioMixerNode()
        mixerNode.outputVolume = 1.0
        audioEngine.attach(mixerNode)
        
        return mixerNode
    }
    
    //    效果器
    
//    EQ
//    func eq(engine audioEngine:AVAudioEngine) -> AVAudioUnitEQ {
//        let audioUnitEQ = AVAudioUnitEQ.init(numberOfBands: 2)
////        audioUnitEQ.globalGain = 20
//        engine.attach(audioUnitEQ)
//        return audioUnitEQ
//    }
    
    //    混响
    func reverb(engine audioEngine:AVAudioEngine) -> AVAudioUnitReverb {
        let audioUnitReverb = AVAudioUnitReverb()
        audioUnitReverb.loadFactoryPreset(.largeHall)
        audioUnitReverb.wetDryMix = 50
        audioEngine.attach(audioUnitReverb)
        
        return audioUnitReverb
    }
    
    //    延迟
    func delay(engine audioEngine:AVAudioEngine) -> AVAudioUnitDelay {
        let audioUnitDelay = AVAudioUnitDelay()
        audioUnitDelay.delayTime = 0.5
        audioUnitDelay.lowPassCutoff = 50
        audioUnitDelay.wetDryMix = 20
        audioEngine.attach(audioUnitDelay)
        
        return audioUnitDelay
    }
    
    //    连接音频节点
    //    节点数组里面的元素 添加的时候 必须按照串联的顺序
    func connectionNodes(nodes:[AVAudioNode], format:AVAudioFormat,engine audioEngine:AVAudioEngine) {
        
        for node in nodes {
            
            if index==0 {
                index+=1
                continue
            }
            index+=1
            engine.connect(nodes[index-2], to:node , format: format)
        }
        index = 0
    }
    
    //    MARK:----控制相关-----
    func startRecoder(){
        
        prepare()
        try! engine.start()
    }
    
    func stopRecoder(){
        
        engine.inputNode?.removeTap(onBus: 0)
        engine.stop()
    }
    
    func recoding() -> Bool {
        return engine.isRunning
    }

}
