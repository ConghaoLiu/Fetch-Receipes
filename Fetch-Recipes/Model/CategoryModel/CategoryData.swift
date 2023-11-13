//
//  CategoryData.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/10/23.
//

import Foundation

struct CategoryData: Codable{
    let categories: [Detail]
}

struct Detail: Codable{
    let strCategory: String
}
