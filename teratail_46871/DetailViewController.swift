//
//  DetailViewController.swift
//  teratail_46871
//
//  Created by KentarOu on 2016/09/06.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    enum RecipeStatus {
        case jpn, eng
        
        mutating func statusNext() {
            switch self {
            case jpn: return self = .eng
            case eng: return self = .jpn
            }
        }
    }
    
    @IBOutlet weak var jpnLabel: UILabel!
    @IBOutlet weak var engLabel: UILabel!
    @IBOutlet weak var kanaLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var data: [DataModel]!
    var index: Int = 0
    var status = RecipeStatus.jpn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRecipe()
        self.title = "No.\(index + 1)"
    }
    
    func setRecipe() {
        jpnLabel.text  = data[index].jpn
        engLabel.text  = data[index].eng
        kanaLabel.text = data[index].kana
    }
    
    @IBAction func pushButton(sender: UIButton) {
        
        switch status {
        case .jpn:
            engLabel.hidden  = false
            kanaLabel.hidden = false
            button.setTitle("次へ", forState: .Normal)
            
        case .eng:
            if index < data.count - 1 {
                index += 1
                setRecipe()
            } else {
                print("Finish!")
                return
            }
            engLabel.hidden  = true
            kanaLabel.hidden = true
            button.setTitle("英語", forState: .Normal)
        }
        self.title = "No.\(index + 1)"
        status.statusNext()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
