//
//  CategoryManager.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/10/23.
//

import Foundation

protocol UpdateCategoryDelegate{
    func didUpdataCategory(category: CategoryModel)
    func didFailWithError(error: Error)
}


struct CategoryManager{
    var delegate: UpdateCategoryDelegate?
    let categoryURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    
    func performRequest(){
        if let url = URL(string: categoryURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let category = self.parseJSON(categoryData: safeData){
                        self.delegate?.didUpdataCategory(category: category)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(categoryData: Data)->CategoryModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(CategoryData.self, from: categoryData)
            
            let categoryNames = decodeData.categories.map { $0.strCategory }
            let categoryModel = CategoryModel(categoryNames: categoryNames)
            return categoryModel
            }catch{
            delegate?.didFailWithError(error:error)
            return nil
        }
    }
}
