//
//  Recipe.swift
//  Secret Family Recipes
//
//  Created by Sergey Osipyan on 7/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//



import Foundation

// MARK: - Recipe
struct Recipe: Codable {
    
    let id: Int
    let title: String
    let source: String?
    let instructions: String?
    let ingredients: String?
    let category: String?
    let created_at: String?
    
}

