//
//  RecipeController.swift
//  Secret Family Recipes
//
//  Created by Sergey Osipyan on 7/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import Foundation

class RecipeCotroller {
    
    static let shared = RecipeCotroller()
    private let baseURL = URL(string: "https://anthony-secret-family-recipes.herokuapp.com/api/")!
    var recipes: [Recipe] = []
    var userId: Int?
    var token: String?
    

    
    func createRequest(url: URL, httpMethod: String) -> URLRequest {
        var request = URLRequest(url: url)
        if let token = self.token {
            request.httpMethod = httpMethod
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(token, forHTTPHeaderField: "Authorization")
            return request
        }
        return request
    }
    
    
    
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void ) {
        
        guard let userId = self.userId else { return }
        guard let token = self.token else { return }
        
        let gestureURL = baseURL.appendingPathComponent("recipes").appendingPathComponent("\(userId)").appendingPathComponent("users")
        
        var request = URLRequest(url: gestureURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            let JSONString = String(data: data, encoding: String.Encoding.utf8)
            print(JSONString!)
            
            do {
                
                let jsonDecoder = JSONDecoder()
                let decodedTeam = try jsonDecoder.decode([Recipe].self, from: data)
                //                print(decodedTeam)
                
                //                if let contacts = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Contact] {
                //                    print(contacts)
                self.recipes = decodedTeam
                completion(decodedTeam)
                
            } catch {
                NSLog("Error decoding from object: \(error)")
                
                return
            }
            }.resume()
        
    }
    
    func fetchRecipesByCategory(category: String, completion: @escaping ([Recipe]) -> Void ) {
        
        guard let token = self.token else { return }
        
        let gestureURL = baseURL.appendingPathComponent("recipes").appendingPathComponent("search")
        
                let parameters = ["search" : category]
        
        var request = URLRequest(url: gestureURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            let JSONString = String(data: data, encoding: String.Encoding.utf8)
            print(JSONString!)
            
            do {
                
                let jsonDecoder = JSONDecoder()
                let decodedTeam = try jsonDecoder.decode([Recipe].self, from: data)
                //                print(decodedTeam)
                
                //                if let contacts = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Contact] {
                //                    print(contacts)
                self.recipes = decodedTeam
                completion(decodedTeam)
                
            } catch {
                NSLog("Error decoding from object: \(error)")
                
                return
            }
            }.resume()
        
    }
    
    func cteateRecipeInfo(with recipe: Recipe, completion: @escaping (Error?) -> Void) {
        
        // guard let userId = self.userId else { return }
        
        
        let parameters = ["title" : recipe.title, "ingredients" : recipe.ingredients!, "source" : recipe.source!, "instructions" : recipe.instructions!, "category" : recipe.category!, "user_id": userId!] as [String : Any]
        
        
        let loginURL = baseURL.appendingPathComponent("recipes")
        
        //create the session object
        let session = URLSession.shared
        var request = createRequest(url: loginURL, httpMethod: "POST")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
        })
        task.resume()
    }
    
    func updateRecipeInfo(with recipe: Recipe, completion: @escaping (Error?) -> Void) {
        
        guard let id  = recipe.id else { return }
        
        let parameters = ["title" : recipe.title, "ingredients" : recipe.ingredients!, "source" : recipe.source!, "instructions" : recipe.instructions!, "category" : recipe.category!] as [String : Any]
        
        
        let loginURL = baseURL.appendingPathComponent("recipes").appendingPathComponent("\(id)")
        //create the session object
        let session = URLSession.shared
        var request = createRequest(url: loginURL, httpMethod: "PUT")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            
            
        })
        task.resume()
        
    }
    
    func deleteRecipe(with recipe: Recipe, completion: @escaping (Bool) -> Void ) {
        
        guard let id = recipe.id else { return }
        
        let gestureURL = baseURL.appendingPathComponent("recipes").appendingPathComponent("\(id)")
        
        let request = createRequest(url: gestureURL, httpMethod: "DELETE")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            let JSONString = String(data: data, encoding: String.Encoding.utf8)
            print(JSONString!)
            
            }.resume()
        
    }
}
