//
//  S_ControlView.swift
//  Singer
//
//  Created by Bruce on 16/7/29.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class S_ControlView: UIView {
    
    init(_ audioFilePath:String) {
        let frame = CGRect.init(x: 10, y: 10, width: SCREEN_WIDTH-20, height: SCREEN_WIDTH-20)
        super.init(frame: frame)
        
        let closeButton = UIButton.init(type: .custom)
        closeButton.frame = CGRect.init(x: frame.maxX-30, y: frame.minY, width: 30, height: 30)
        closeButton.setTitle("x", for: [])
        closeButton.addTarget(self, action: #selector(closeView(sender:)), for: UIControlEvents.touchUpInside)
        closeButton.setTitleColor(UIColor.red, for: [])
        closeButton.backgroundColor = UIColor.orange
        self.addSubview(closeButton)
    }
    
    func closeView(sender:UIButton) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
