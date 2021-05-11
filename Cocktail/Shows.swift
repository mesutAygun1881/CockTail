//
//  Shows.swift
//  Cocktail
//
//  Created by Mesut Aygün on 10.05.2021.
//

import Foundation

class Drinks {
    struct Returned : Codable {
        
        var drinks : [Drink]
    }
    let alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var alphabetIndex = 0
    var urlBase = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
    var urlString = ""
    var drinkArray : [Drink] = []
    var isFetching = false
    
    func getData(completed : @escaping () ->()) {
        
        guard !isFetching else {
            print("didnt call getData because we hadnt fetch data")
            completed()
            return
        }
        
        isFetching = true
        
        urlString = urlBase + alphabet[alphabetIndex]
        alphabetIndex += 1
        guard let url = URL(string: urlString) else {
            print("accessing url \(urlString)")
            isFetching = false
            completed()
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error : \(error.localizedDescription)")
                
            }
            do{
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.drinkArray = self.drinkArray + returned.drinks
                
            }catch {
                print("error:\(error.localizedDescription)")
            }
            self.isFetching = false
            completed()
        }
        task.resume()
        
    }
}
