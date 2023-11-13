//
//  MealManager.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/11/23.
//

import Foundation

protocol UpdateMealDelegate{
    func didUpdataMeal(category: MealModel)
    func didFailWithError(error: Error)
}

struct MealManager{
    let filterCategoryURL = "https://www.themealdb.com/api/json/v1/1/"
    var delegate: UpdateMealDelegate?
    
    func createURLByMeal(meal: String){
        let fullURL = "\(filterCategoryURL)search.php?s=\(meal)"
        
        performRequest(url: fullURL)
    }
    
    func createURLByID(id: String){
        let fullURL = "\(filterCategoryURL)lookup.php?i=\(id)"
        
        performRequest(url: fullURL)
    }
    
    
    
    func performRequest(url: String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let category = self.parseJSON(categoryData: safeData){
                        self.delegate?.didUpdataMeal(category: category)
                        
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(categoryData: Data)->MealModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(MealData.self, from: categoryData)
            
            let mealName = decodeData.meals[0].strMeal
            let mealInstructions = decodeData.meals[0].strInstructions
            let mealIngredientAndMeasure = decodeData.meals[0].ingredientsAndMeasure
            let categoryModel = MealModel(mealName: mealName, mealInstruction: mealInstructions, mealIngredientMeasure: mealIngredientAndMeasure)
            return categoryModel
            }catch{
            delegate?.didFailWithError(error:error)
            return nil
        }
    }
    
    
    
    
}
