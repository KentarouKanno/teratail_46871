//
//  DatabaseManager.swift
//  teratail_46871
//
//  Created by KentarOu on 2016/09/06.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import Foundation

class DataBaseManager {
    
    static let sharedInstance: DataBaseManager = {
        let instance = DataBaseManager()
        return instance
    }()
    
    var db: FMDatabase!
    
    init() {
        copyDataBaseFromBundle()
        db = FMDatabase(path: dataBasePath())
    }
    
    func copyDataBaseFromBundle() {
        let bundle = NSBundle.mainBundle().pathForResource("recipe", ofType: "db")!
        let dbData = NSData(contentsOfFile: bundle)
        let fileName = "recipe.db"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        dbData!.writeToFile("\(documentsPath)/" + "/" + "\(fileName)", atomically: false)
    }
    
    // Database Path
    func dataBasePath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as NSString
        let _path = path.stringByAppendingPathComponent("recipe.db")
        return _path
    }
    
    
    // Select Recipe Data
    func selectRecipeAllData() -> Array<DataModel> {
        
        let sql = "SELECT * FROM RECIPE ORDER BY ID;"
        db.open()
        
        let results = db.executeQuery(sql, withArgumentsInArray: nil)
        
        var resultArray: Array<DataModel> = []
        
        while results.next() {
            let data = DataModel()
            data.id   = Int(results.intForColumn("ID"))
            data.jpn  = results.stringForColumn("JPN")
            data.eng  = results.stringForColumn("ENG")
            data.kana = results.stringForColumn("KANA")
            resultArray.append(data)
        }
        db.close()
        
        return resultArray
    }
}
