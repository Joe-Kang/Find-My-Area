//
//  ViewController.swift
//  Find My Area
//
//  Created by Jihun Kang on 1/18/18.
//  Copyright © 2018 Jihun Kang. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MapViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func addMapCoordinates(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToMapSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        
    }
    
    @IBOutlet weak var distanceTableView: UITableView!
    @IBOutlet weak var areaTableView: UITableView!
    
    var area:[AreaListItem] = []
    var distance:[DistanceListItem] = []
  
    
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        if tableView == self.distanceTableView {
            count = distance.count
        }
        if tableView == self.areaTableView {
            count = area.count
        }
        
        return count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if tableView == self.distanceTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "distanceCell", for: indexPath)
            cell.textLabel?.text = distance[indexPath.row].nameOfPath
           let dist = String(format:"%2f", "\(distance[indexPath.row])", "Square Meters")
            cell.detailTextLabel?.text = dist
        }
        if tableView == self.areaTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "areaCell", for: indexPath)
            cell.textLabel?.text = area[indexPath.row].nameOfArea
            let areaM = String(format:"%2f", "\(area[indexPath.row])", "Square Meters")
            cell.detailTextLabel?.text = areaM
        }
        return cell
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let mapViewController = navigationController.topViewController as! MapViewController
        mapViewController.delegate = self
    }
    
    func returnArea(by Controller: MapViewController, _ area: Double, _ name:String) {
        dismiss(animated: true, completion: nil)
        let thing = NSEntityDescription.insertNewObject(forEntityName: "AreaListItem", into: managedObjectContext) as! AreaListItem
        thing.area = area
        thing.nameOfArea = name
        do{
            try managedObjectContext.save()
        } catch{
            print("\(error)")
        }
        areaTableView.reloadData()
    }
    
    func returnDistance(by Controller: MapViewController, _ distance: Double, _ name:String) {
        dismiss(animated: true, completion: nil)
        let thing = NSEntityDescription.insertNewObject(forEntityName: "DistanceListItem", into: managedObjectContext) as! DistanceListItem
        thing.distance = distance
        thing.nameOfPath = name
        do{
            try managedObjectContext.save()
        } catch{
            print("\(error)")
        }
        distanceTableView.reloadData()
    }
    
    
        func fetchAllItems(){
            let areaRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AreaListItem")
            do {
                let areaResult = try managedObjectContext.fetch(areaRequest)
                 area = areaResult as! [AreaListItem]
            } catch {
                print("\(error)")
            }
    
            let distanceRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DistanceListItem")
            do {
                let distanceResult = try managedObjectContext.fetch(distanceRequest)
                distance = distanceResult as! [DistanceListItem]
            } catch {
                print("\(error)")
            }
    
        }
    
    
}





