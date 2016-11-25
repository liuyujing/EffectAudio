//
//  S_FinishAudioFileController.swift
//  Singer
//
//  Created by Bruce on 16/7/29.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class S_FinishAudioFileController: S_BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var recodListView: UITableView!
    var audioFiles:Array<AnyObject>?
    
    @IBOutlet var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "作品"
        
        let editButton = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(editCell))
        self.navigationItem.rightBarButtonItem = editButton
       
        let layer = CAGradientLayer.init()
        layer.colors = [UIColor.black.cgColor,UIColor.lightGray.cgColor,UIColor( red: 0.0431, green: 0.0431, blue: 0.0431, alpha: 1.0 ).cgColor]
        layer.frame = SCREEN_BOUNDS
        layer.opacity = 1.0
        
        backgroundView.layer.addSublayer(layer)
        
        
        recodListView.delegate = self;
        recodListView.dataSource = self;
        recodListView.separatorStyle = .none
    }
  
    func editCell() {
        recodListView.isEditing = !recodListView.isEditing
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (audioFiles?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "audio"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell==nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.textColor = UIColor.white
            cell?.backgroundColor = UIColor.clear
            cell?.selectionStyle = .none
            let longTap = UILongPressGestureRecognizer.init(target: self, action: #selector(changeName))
            longTap.minimumPressDuration = 1.5
            cell?.addGestureRecognizer(longTap)
        }
        cell?.imageView?.image = UIImage.init(named: "music")
        cell?.textLabel?.text = audioFiles?[indexPath.row] as? String
        
        return cell!
    }
    
    func changeName(sender:UILongPressGestureRecognizer) {
        if sender.state == .began {
            
            let curName = (sender.view as! UITableViewCell).textLabel?.text
            let changeNameView = S_ChangeNameView.init(frame: CGRect.init(x: 50, y: 50, width: SCREEN_WIDTH-100, height: SCREEN_WIDTH-100))
            changeNameView.center = self.view.center
            self.view.addSubview(changeNameView)
            changeNameView.finish = {(nameString:String)->Void
                in
                self.editFileName(sourceFileName: curName!, toFileName: "\(nameString).\(AUDIO_TYPE)")
                changeNameView.removeFromSuperview()
                self.audioFiles = self.searchDocumentFiles(fileType: AUDIO_TYPE)
                self.recodListView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let mainSB = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = mainSB.instantiateViewController(withIdentifier: "S_ControlAudioViewController") as? S_ControlAudioViewController
        vc?.path = audioFiles?[indexPath.row] as? String
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            deleteAudioFile(audioFiles![indexPath.row] as! String)
            audioFiles?.remove(at: indexPath.row)
            tableView .deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
