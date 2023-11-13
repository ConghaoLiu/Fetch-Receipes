//
//  CategoryTableViewController.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/10/23.
//

import UIKit

class CategoryTableViewController: UITableViewController, UpdateCategoryDelegate{
    var categoryManager = CategoryManager()
    var categoryNames: [String] = []
    
    func didUpdataCategory(category: CategoryModel) {
        DispatchQueue.main.async{
            self.categoryNames = category.categoryNames.sorted()
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryManager.delegate = self
        categoryManager.performRequest()
        
        self.title = "Category"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryNames[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToFilterCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FilterCategoryTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryNames[indexPath.row]
        }
    }

    
}
