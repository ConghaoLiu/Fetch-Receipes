//
//  MealTableViewController.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/11/23.
//

import UIKit

class MealTableViewController: UITableViewController, UpdateMealDelegate {
    var mealModel: MealModel!
    var arrayIngredientMeasure: [[String: String]] = []
    
    func didUpdataMeal(category: MealModel) {
        DispatchQueue.main.async{
            self.mealModel = category
            
            self.arrayIngredientMeasure = self.mealModel.mealIngredientMeasure.map{[$0.key: $0.value]}
            self.tableView.reloadData()
        }
        
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    var mealManager = MealManager()

    var selectedMeal: String?{
        didSet{
            mealManager.delegate = self
            mealManager.createURLByMeal(meal: selectedMeal!)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return mealModel?.mealIngredientMeasure.count ?? 0
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        
        switch indexPath.section{
        case 0:
            cell.textLabel?.text = mealModel?.mealName ?? ""
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.numberOfLines = 0
        case 1:
            let ingredient = arrayIngredientMeasure[indexPath.row]
            if let ingredientText = ingredient.first{
                cell.textLabel?.text = "• \(ingredientText.key): \(ingredientText.value)"
                
            }
            cell.textLabel?.numberOfLines = 0
            
            
        case 2:
            cell.textLabel?.text = mealModel?.mealInstruction ?? ""
            cell.textLabel?.numberOfLines = 0
            
        default:
            break
        }
        return cell
    }

}
