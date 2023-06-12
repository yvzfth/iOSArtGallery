//
//  DetailsViewController.swift
//  ArtGallery
//
//  Created by Fatih Yavuz on 12.06.2023.
//

import UIKit
import CoreData
class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var selectedId : UUID?
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var artistField: UITextField!
    @IBOutlet var yearField: UITextField!
    @IBOutlet var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        saveButton.isEnabled = false
   
        
        
        
        
        // Render details with selected id
        if selectedId != nil{
            nameField.isEnabled = false
            artistField.isEnabled = false
            yearField.isEnabled = false
                    saveButton.isHidden = true
                    
                    //Core Data
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
                    let idString = selectedId?.uuidString
                    fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
                    fetchRequest.returnsObjectsAsFaults = false
                    
                    do {
                       let results = try context.fetch(fetchRequest)
                        
                        if results.count > 0 {
                            
                            for result in results as! [NSManagedObject] {
                                
                                if let name = result.value(forKey: "name") as? String {
                                    nameField.text = name
                                }

                                if let artist = result.value(forKey: "artist") as? String {
                                    artistField.text = artist
                                }
                                
                                if let year = result.value(forKey: "year") as? Int {
                                    yearField.text = String(year)
                                }
                                
                                if let imageData = result.value(forKey: "image") as? Data {
                                    let image = UIImage(data: imageData)
                                    imageView.image = image
                                }
                                
                            }
                        }

                    } catch{
                        print("error")
                    }
                    
                    
                } else {
                    saveButton.isHidden = false
                    saveButton.isEnabled = false
                    
                    
                    
                    //Recognizers
                    imageView.isUserInteractionEnabled = true
                    let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
                    imageView.addGestureRecognizer(imageTapRecognizer)
                  
                    //Recognizers
                        
                     let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                     view.addGestureRecognizer(gestureRecognizer)
                 
                }
        
        
      
    }
    
    @objc func hideKeyboard() {
          view.endEditing(true)
      }

    @objc func selectImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
           saveButton.isEnabled = true
           self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
                
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Attributes
               
               newPainting.setValue(nameField.text!, forKey: "name")
               newPainting.setValue(artistField.text!, forKey: "artist")
               
               if let year = Int(yearField.text!) {
                   newPainting.setValue(year, forKey: "year")
               }
               
               newPainting.setValue(UUID(), forKey: "id")
               
               let data = imageView.image!.jpegData(compressionQuality: 0.5)
               
               newPainting.setValue(data, forKey: "image")
               
               do {
                   try context.save()
                   print("success")
               } catch {
                   print("error")
               }
               
             
               NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
               self.navigationController?.popViewController(animated: true)
    }
   

}
