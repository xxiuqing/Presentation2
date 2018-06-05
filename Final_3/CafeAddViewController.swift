//
//  CafeAddViewController.swift
//  Final_3
//
//  Created by SWUCOMPUTER on 2018. 5. 28..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class CafeAddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var detailLoca: String!
    var cafeAddress: String!
    var cafeVC: UITableViewController? = nil
    let picker = UIImagePickerController()

    @IBOutlet var cafeName: UITextField!
    @IBOutlet var detailLocation: UILabel!
    @IBOutlet var cafeDAddress: UITextField!
    @IBOutlet var cafeLocation: UITextField!
    @IBOutlet var cafeMemo: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailLocation.text = detailLoca
        picker.delegate = self
    }
    
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    @IBAction func addPicture(_ sender: Any) {
        
        let alert = UIAlertController(title: "Photo", message: "사진 가져오기", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) {(action) in self.openLibrary() }
        let camera = UIAlertAction(title: "카메라", style: .default) {(action) in self.openCamera() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        picker.sourceType = .camera
        present(picker, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if let dAdd = cafeDAddress.text {
            cafeAddress = detailLoca + " " + dAdd
        }
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Cafes", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(cafeName.text, forKey: "name")
        object.setValue(cafeAddress, forKey: "address")
        object.setValue(cafeLocation.text, forKey: "location")
        object.setValue(cafeMemo.text, forKey: "memo")
        
        if let targetVC = cafeVC as? CafeTableViewController {
            targetVC.addedCafe = object
        }
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save  \(error),  \(error.userInfo)") }
        
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }



}
