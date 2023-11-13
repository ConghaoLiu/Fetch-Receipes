//
//  IDTableViewController.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/12/23.
//

import UIKit

class IDTableViewController: UITableViewController, UpdateMealDelegate, UpdateFilterCategoryDelegate{
    var mealManager = MealManager()
    var filterCategoryManger = FilterCategoryManager()
    var mealModel: MealModel!
    var filterCategoryModel: FilterCategoryModel!
    var mealNames: [String] = []

    
    @IBOutlet weak var iDSearchBar: UISearchBar!
    
    func didUpdataFilterCategory(category: FilterCategoryModel) {
        DispatchQueue.main.async{
            self.filterCategoryModel = category
            self.mealNames = self.filterCategoryModel.filterCategoryNames
            print(self.mealNames)
            self.tableView.reloadData()
        }
    }
    
    func didUpdataMeal(category: MealModel) {
        DispatchQueue.main.async{
            self.mealModel = category
            self.mealNames.append(self.mealModel.mealName)
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealManager.delegate = self
        iDSearchBar.delegate = self
        filterCategoryManger.delegate = self
        
        iDSearchBar.placeholder = "Enter a meal ID(eg: 52773) or name(eg: Beef)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IDMealCell", for: indexPath)
        
        cell.textLabel?.text = mealNames[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "IdToMeal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MealTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedMeal = mealNames[indexPath.row]
        }
    }
}

extension IDTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let idText = searchBar.text, !idText.isEmpty else {return}
        print(idText)
        if Int(idText) != nil{
            mealManager.createURLByID(id: idText)
            
        }else{
            filterCategoryManger.createURLByName(name: idText)
            
        }
        searchBar.resignFirstResponder()
        
    }
    
    
}
