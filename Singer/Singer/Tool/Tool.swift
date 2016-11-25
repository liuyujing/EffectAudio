//
//  Tool.swift
//  Singer
//
//  Created by Bruce on 16/7/29.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import Foundation

extension NSObject{
    
//    MARK:----获得当前时间戳-----
    func timeStamp() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        return format.string(from: Date())
    }
    
//    MARK:----搜索Document目录-----
    func searchDocumentFiles(fileType:String) -> [AnyObject] {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        return searchFiles(path: path, fileType: fileType)
    }
    
    func searchFiles(path:String,fileType type:String) -> [AnyObject] {
        let manager = FileManager.default
        let fileList = NSMutableArray()
        
        for item in manager.subpaths(atPath: path)! {
            let searchPath = item as NSString
            if searchPath.pathExtension ==  type{
                fileList.add(item)
            }
        }
        
        return (fileList as Array).reversed()
    }
    
    func documentFile(_ path:String) -> String {
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
      
        return filePath.appendingPathComponent(path);
    }
    
//    MARK:----删除指定文件-----
    func deleteAudioFile(_ path:String) {
        print(documentFile(path))
        let manager = FileManager.default
        let url = URL.init(fileURLWithPath: documentFile(path))
        try!manager.removeItem(at: url)
    }
    
    func editFileName(sourceFileName fileName:String, toFileName:String) {
        let manager = FileManager.default
        try!manager.moveItem(atPath: documentFile(fileName), toPath: documentFile(toFileName))
    }
  
    func time(timeInterval:TimeInterval) -> String {
        let hourse = Int.init(timeInterval/360.0)
        let minute = Int.init(timeInterval/60.0)
        let second = Int.init(timeInterval)%60

        let timeString = NSString.init(format: "%02d:%02d:%02d", hourse,minute,second)
        return timeString as String
    }

    
}
