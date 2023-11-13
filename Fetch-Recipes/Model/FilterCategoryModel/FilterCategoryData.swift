//
//  FilterCategoryData.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/10/23.
//

import Foundation

struct FilterCategoryData: Codable{
    let meals: [Item]
}

struct Item: Codable{
    let strMeal: String
}
