//
//  RecipeListTableViewController.swift
//  Secret Family Recipes
//
//  Created by Sergey Osipyan on 7/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import UIKit

class RecipeListTableViewController: UITableViewController {

    var recipes: [Recipe] = []
    var searchedRecipes: [Recipe] = []
    var isSearching = false
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func addNewRecipeButton(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITableView.appearance().backgroundColor = .white
        UITableView.appearance().tintColor = .black
        UINavigationBar.appearance().backgroundColor = .darkGray
        UINavigationBar.appearance().tintColor = .darkGray
        // search delegate
        searchBar.delegate = self
        
        // hide keyboard when tapping on the screen
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if LoginController.shared.token == nil {
            performSegue(withIdentifier: "loginSegue", sender: self)
        } else {
            RecipeCotroller.shared.fetchRecipes(completion: { (recipes) in
                self.recipes = recipes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if isSearching {
            count = searchedRecipes.count
        } else {
            count = recipes.count
        }
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        var recipesArray: [Recipe] = []
        if isSearching {
            recipesArray = searchedRecipes
        } else {
            recipesArray = recipes
        }
        cell.textLabel?.text = recipesArray[indexPath.row].title
        cell.detailTextLabel?.text = recipesArray[indexPath.row].category
        cell.layer.cornerRadius = 8.0
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe = recipes[indexPath.row]
            RecipeCotroller.shared.deleteRecipe(with: recipe) { (bool) in
                
            }
            recipes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeSegue" {
            let destination = segue.destination as! RecipeDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destination.recipe = self.recipes[indexPath.row]
        }
    }
}

extension RecipeListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            self.isSearching = false
            print("search text cleard")
        } else {
        print("Text is: \(searchText)")
        self.searchedRecipes = self.recipes.filter({ (text: Recipe) -> Bool in
            return (text.title.trimmingCharacters(in: CharacterSet.whitespaces).lowercased().contains(searchText.trimmingCharacters(in: .whitespaces).lowercased()))
        })
        self.isSearching = true
        self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchedRecipes.removeAll()
        for recipe in recipes {
            if recipe.category == searchBar.scopeButtonTitles![selectedScope] {
                isSearching = true
                searchedRecipes.append(recipe)
            } else {
                isSearching = true
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        if selectedScope == 0 {
            isSearching = false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        tableView.reloadData()
    }
}
