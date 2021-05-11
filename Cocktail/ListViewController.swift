//
//  ViewController.swift
//  Cocktail
//
//  Created by Mesut Aygün on 10.05.2021.
//

import UIKit

class ListViewController: UIViewController {
    
    
    //Drinks classını drinkse tanımladık
    var drinks = Drinks()
    
    
    //myDrinks dizisini tanımladık
    var myDrinks : [String : String] = [:]

    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        drinks.getData {
            DispatchQueue.main.async {
                self.navigationItem.title = "Drinks Shown : \(self.drinks.drinkArray.count)"
                self.tableView.reloadData()
            }
        }

       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            let destination = segue.destination as! DetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow!
            destination.drink = drinks.drinkArray[selectedIndex.row]
            
            destination.myDrinks = myDrinks
        }
    }
    
    func loadData(){
        let directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryUrl.appendingPathComponent("myDrinks").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        
        do {
            myDrinks = try jsonDecoder.decode(Dictionary.self , from: data)
            tableView.reloadData()
        }catch{
            print("error")
            
        }
        
    }
    
    func saveData() {
        let directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryUrl.appendingPathComponent("myDrinks").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(myDrinks)
        do{
            try data?.write(to: documentURL,options: .noFileProtection)
            
        }catch{
            print("error")
            
            
        }
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! DetailViewController
        myDrinks = source.myDrinks
        saveData()
        tableView.reloadData()
    }


}

extension ListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.drinkArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == drinks.drinkArray.count-1  && drinks.alphabetIndex < drinks.alphabet.count {
            drinks.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Drinks Shown : \(self.drinks.drinkArray.count)"
                    self.tableView.reloadData()
                }
            }
            
            
        }
        cell.textLabel?.text = drinks.drinkArray[indexPath.row].strDrink
        let drinkName = drinks.drinkArray[indexPath.row].strDrink
        if let drinkRating = myDrinks[drinkName!] {
            cell.detailTextLabel?.text = drinkRating
            
        }else {
            cell.detailTextLabel?.text = "-"
        }
        return cell
    }
    
    
    
}

