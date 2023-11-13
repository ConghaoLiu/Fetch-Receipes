//
//  MealData.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/11/23.
//

import Foundation

struct MealData: Codable{
    let meals: [Meal]
}

struct Meal: Codable{
    let strMeal: String
    let strInstructions: String
    var ingredientsAndMeasure: [String: String] = [:]
    
    struct DynamicCodingKeys: CodingKey{
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = ""
        }
        
        
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        strMeal = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strMeal")!)
        strInstructions = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strInstructions")!)
        
        var ingredientsTemp: [String] = []
        var measureTemp: [String] = []
        
        for key in container.allKeys{
            if key.stringValue.starts(with: "strIngredient"),
               let ingredient = try container.decodeIfPresent(String.self, forKey: key),
               !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                ingredientsTemp.append(ingredient)
            } else if key.stringValue.starts(with: "strMeasure"),
                      let measure = try container.decodeIfPresent(String.self, forKey: key),
                      !measure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                measureTemp.append(measure)
            }
            
        }
        
        for (index, ingredient) in ingredientsTemp.enumerated(){
            if index < measureTemp.count{
                ingredientsAndMeasure[ingredient] = measureTemp[index]
            }
        }
        
    }
}
