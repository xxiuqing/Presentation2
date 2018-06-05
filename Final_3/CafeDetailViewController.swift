//
//  CafeDetailViewController.swift
//  Final_3
//
//  Created by SWUCOMPUTER on 2018. 5. 28..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class CafeDetailViewController: UIViewController {
    
    @IBOutlet var cafeName: UITextField!
    @IBOutlet var cafeAddress: UITextView!
    @IBOutlet var cafeLocation: UITextField!
    @IBOutlet var cafeMemo: UITextView!
    @IBOutlet var cafeImage: UIImageView!
    
    var detailCafe: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let cafe = detailCafe {
            cafeName.text = cafe.value(forKey: "name")as? String
            cafeAddress.text = cafe.value(forKey: "address")as? String
            cafeLocation.text = cafe.value(forKey: "location") as? String
            cafeMemo.text = cafe.value(forKey: "memo") as? String
        }
    }
    
    @IBAction func bookmarkButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "자주가는 카페 추가", message: "관심 카페로 추가합니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil) //handler부분 수정하고 액션 추가
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
