//
//  RecipesDetailViewController.swift
//  Secret Family Recipes
//
//  Created by Sergey Osipyan on 7/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe?
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTextView: UITextView!
    
    
    @IBAction func saveBarButton(_ sender: Any) {
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
