//
//  ViewController.swift
//  ArtGallery
//
//  Created by Fatih Yavuz on 12.06.2023.
//

import UIKit
import CoreData
class ViewController: UITableViewController{
    // if a cell tapped set to cell id to tappedId
    var tappedId : UUID?
    var nameArray = [String]()
    var idArray = [UUID]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // tableView config
        tableView.dataSource = self
        tableView.delegate = self
        
        // Plus button on navigation bar
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTapped))
        
        
        
        
        // Core Data
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
       }
    @objc func getData() {
            
            nameArray.removeAll(keepingCapacity: false)
            idArray.removeAll(keepingCapacity: false)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                                    if let name = result.value(forKey: "name") as? String {
                                        self.nameArray.append(name)
                                    }
                                    
                                    if let id = result.value(forKey: "id") as? UUID {
                                        self.idArray.append(id)
                                    }
                                    
                                    self.tableView.reloadData()
                                    
                                }
                }
                

            } catch {
                print("error")
            }
            
        }
    // Plus button action method
    @objc func addTapped(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    // Table View Cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    // Table View Cell Texts
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedId = idArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
            
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedId = tappedId
            tappedId = nil
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
                
                let idString = idArray[indexPath.row].uuidString
                
                fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
                
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        
                        for result in results as! [NSManagedObject] {
                            
                            if let id = result.value(forKey: "id") as? UUID {
                                
                                if id == idArray[indexPath.row] {
                                    context.delete(result)
                                    nameArray.remove(at: indexPath.row)
                                    idArray.remove(at: indexPath.row)
                                    self.tableView.reloadData()
                                    
                                    do {
                                        try context.save()
                                        
                                    } catch {
                                        print("error")
                                    }
                                    
                                    break
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        
                    }
                } catch {
                    print("error")
                }
                
                
                
                
            }
        }

}

