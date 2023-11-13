//
//  FilterCategoryManager.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/10/23.
//

import Foundation

protocol UpdateFilterCategoryDelegate{
    func didUpdataFilterCategory(category: FilterCategoryModel)
    func didFailWithError(error: Error)
}


struct FilterCategoryManager{
    var delegate: UpdateFilterCategoryDelegate?
    let filterCategoryURL = "https://www.themealdb.com/api/json/v1/1/"
    
    func createURLByFilterCategory(filter: String){
        let fullURL = "\(filterCategoryURL)filter.php?c=\(filter)"
        
        performRequest(url: fullURL)
    }
    
    func createURLByName(name: String){
        let fullURL = "\(filterCategoryURL)search.php?s=\(name)"
        print(fullURL)
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
                        self.delegate?.didUpdataFilterCategory(category: category)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(categoryData: Data)->FilterCategoryModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(FilterCategoryData.self, from: categoryData)
            
            let filterCategoryNames = decodeData.meals.map { $0.strMeal }
            let categoryModel = FilterCategoryModel(filterCategoryNames: filterCategoryNames)
            return categoryModel
            }catch{
            delegate?.didFailWithError(error:error)
            return nil
        }
    }
}

