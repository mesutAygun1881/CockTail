//
//  DetailViewController.swift
//  Cocktail
//
//  Created by Mesut Aygün on 10.05.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var drinkLabel: UILabel!
    @IBOutlet var ratingTextField: UITextField!
    @IBOutlet var alcoholLabel: UILabel!
    @IBOutlet var glassLabel: UILabel!
    @IBOutlet var recipeTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var ingredientsTextView: UITextView!
    @IBOutlet var ratingLabel: UILabel!
    
    var drink : Drink!
    
    var myDrinks : [String:String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()

        if drink == nil {
            drink = Drink()
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        drinkLabel.text = drink.strDrink
        glassLabel.text = drink.strGlass
        createIngredientsList()
        ratingTextField.text = myDrinks[drink.strDrink ?? "-"]
        recipeTextView.text = drink.strInstructions
        if drink.strAlcoholic != "Alcoholic" {
            alcoholLabel.text = "Yes"
        }
        
        guard let url = URL(string: drink.strDrinkThumb ?? "") else {return}
        do{
            let data = try Data(contentsOf: url)
            imageView.image = UIImage(data: data)
            
        }catch{
            print("error\(url)")
        }
    }
    
    func addIngredients(measure : String? , ingredient : String?) {
        guard measure != nil else {return}
        ingredientsTextView.text += measure!
        guard ingredient != nil else {return}
        ingredientsTextView.text += "\(ingredient!)\n"
    }
    func createIngredientsList() {
        ingredientsTextView.text = ""
        addIngredients(measure: drink.strMeasure1, ingredient: drink.strIngredient1)
        addIngredients(measure: drink.strMeasure2, ingredient: drink.strIngredient2)
        addIngredients(measure: drink.strMeasure3, ingredient: drink.strIngredient3)
        addIngredients(measure: drink.strMeasure4, ingredient: drink.strIngredient4)
        addIngredients(measure: drink.strMeasure5, ingredient: drink.strIngredient5)
        addIngredients(measure: drink.strMeasure6, ingredient: drink.strIngredient6)
        addIngredients(measure: drink.strMeasure7, ingredient: drink.strIngredient7)
        addIngredients(measure: drink.strMeasure8, ingredient: drink.strIngredient8)
        addIngredients(measure: drink.strMeasure9, ingredient: drink.strIngredient9)
        addIngredients(measure: drink.strMeasure10, ingredient: drink.strIngredient10)
        addIngredients(measure: drink.strMeasure11, ingredient: drink.strIngredient11)
        addIngredients(measure: drink.strMeasure12, ingredient: drink.strIngredient12)
        addIngredients(measure: drink.strMeasure13, ingredient: drink.strIngredient13)
        addIngredients(measure: drink.strMeasure14, ingredient: drink.strIngredient14)
        addIngredients(measure: drink.strMeasure15, ingredient: drink.strIngredient15)
        if ingredientsTextView.text != "" {
            ingredientsTextView.text.removeLast()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ratingNumber = Int(ratingTextField.text!) {
            if ratingNumber >= 1 && ratingNumber <= 10 {
                myDrinks[drink.strDrink ?? "-"] = String(ratingNumber)
            }
        }
    }
    

    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    

}
