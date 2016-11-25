//
//  S_ChangeNameView.swift
//  Singer
//
//  Created by Bruce on 16/8/3.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class S_ChangeNameView: UIView {
    
    var finish:((_ nameString:String)->Void)?
    var nameTextField:UITextField?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        
        let effect = UIBlurEffect.init(style: .light)
        
        let effectView = UIVisualEffectView.init(effect: effect)
        effectView.frame = self.bounds
        self.addSubview(effectView)
        
        
        nameTextField = UITextField.init(frame: CGRect.init(x: 10, y: 5, width: frame.width-30, height: 40))
        nameTextField!.placeholder = "请修改音频文件名"
        nameTextField!.textColor = UIColor.orange
        self.addSubview(nameTextField!)
        let closeButton = UIButton.init(type: .custom)
        closeButton.frame = CGRect.init(x: frame.width-20, y: 5, width: 20, height: 20)
        closeButton.setTitle("X", for: [])
        closeButton.setTitleColor(UIColor.white, for: [])
        closeButton.addTarget(self, action: #selector(finishEdit), for: .touchUpInside)
        self.addSubview(closeButton)
    }
    
    func finishEdit() {
        nameTextField?.resignFirstResponder()
        finish!((nameTextField?.text)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
