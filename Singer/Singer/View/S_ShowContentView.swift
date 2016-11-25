//
//  S_ShowContentView.swift
//  Singer
//
//  Created by Bruce on 16/6/27.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class S_ShowContentView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    lazy var contentList = NSArray()
    var selectContent:String?
    
    var selectAction = {(content:String) in
        
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "showContent"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = contentList[indexPath.row] as? String
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectContent = contentList[indexPath.row] as? String
    }
 
}
