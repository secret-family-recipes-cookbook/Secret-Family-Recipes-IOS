//
//  RecipesDetailViewController.swift
//  Secret Family Recipes
//
//  Created by Sergey Osipyan on 7/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    
    var pickedData = "Breakfast"
    var recipe: Recipe?
    let pickerData = ["Breakfast", "Lunch", "Dinner", "Dessert"]
    

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeSource: UITextField!
    @IBOutlet weak var recipeInstructions: UITextView!
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    
    @IBAction func saveBarButton(_ sender: Any) {
        
        if self.recipe != nil {
            if let title = recipeTitle.text, let source = recipeSource.text, let instructions = recipeInstructions.text, let ingredients = recipeIngredients.text {
                let newRecipe = Recipe(id: recipe!.id, title: title, source: source, instructions: instructions, ingredients: ingredients, category: pickedData)
                RecipeCotroller.shared.updateRecipeInfo(with: newRecipe) { (err) in
                    
                }
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            if let title = recipeTitle.text, let source = recipeSource.text, let instructions = recipeInstructions.text, let ingredients = recipeIngredients.text {
                let newRecipe = Recipe(title: title, source: source, instructions: instructions, ingredients: ingredients, category: pickedData)
                RecipeCotroller.shared.cteateRecipeInfo(with: newRecipe) { (err) in
                
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        self.updateView()
    }
    
    
    func updateView() {
    
        if self.recipe != nil {
           self.recipeTitle.text = recipe?.title
           self.recipeSource.text = recipe?.source
           self.recipeInstructions.text = recipe?.instructions
           self.recipeIngredients.text = recipe?.ingredients
           
        }
        
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedData = pickerData[row]
    }
    
}
