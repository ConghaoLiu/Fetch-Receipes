//
//  MealTableViewController.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/10/23.
//

import UIKit

class FilterCategoryTableViewController: UITableViewController, UpdateFilterCategoryDelegate {
    var filterCategoryNames: [String] = []
    var filterCategoryManager = FilterCategoryManager()
    
    func didUpdataFilterCategory(category: FilterCategoryModel) {
        DispatchQueue.main.async{
            self.filterCategoryNames = category.filterCategoryNames.sorted()
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    var selectedCategory : String?{
        didSet{
            filterCategoryManager.delegate = self
            filterCategoryManager.createURLByFilterCategory(filter: selectedCategory!)
            
            self.title = selectedCategory
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCategoryNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCategoryCell", for: indexPath)
        cell.textLabel?.text = filterCategoryNames[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToMeal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MealTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedMeal = filterCategoryNames[indexPath.row]
        }
    }

    

}
