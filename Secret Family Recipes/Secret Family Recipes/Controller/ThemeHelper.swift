//
//  ThemeHelper.swift
//  Secret Family Recipes
//
//  Created by Sergey Osipyan on 7/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import Foundation
import UIKit


enum ThemeHelper {

    static let customBlue = UIColor(displayP3Red: 149/255, green: 214/255, blue: 226/255, alpha: 1.0)

    static let customYellow = UIColor(displayP3Red: 209/255, green: 166/255, blue: 57/255, alpha: 1.0)

    static let customGold = UIColor(displayP3Red: 244/255, green: 232/255, blue: 66/255, alpha: 1.0)

    static let customPink = UIColor(displayP3Red: 247/255, green: 200/255, blue: 241/255, alpha: 1.0)

    static func setupAppearance() {

        UINavigationBar.appearance().barTintColor = customBlue
        UIBarButtonItem.appearance().tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
    }

    static func buttonStyle(for button: UIButton) {

        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = customYellow
        button.layer.cornerRadius = 10.0

    }

    static func textFieldStyle(for textField: UITextField) {

        textField.layer.cornerRadius = 10.0
        
    }

}
