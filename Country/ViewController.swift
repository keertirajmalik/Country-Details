//
//  ViewController.swift
//  Country
//
//  Created by Keertiraj Laxman Malik on 09/02/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let urlString: String
        
        urlString = "https://restcountries.com/v3.1/all"
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    return
                }
            }
            self.showError()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CountryList().countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        cell.textLabel?.text = CountryList().countries[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CountryDetails") as? CountryViewController {
            
            vc.countryFlag = countries[indexPath.row].flags.png
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController {
    func showError() {
        DispatchQueue.main.async {
            print("There was a problem loading the feed; please check your connection and try again.")
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        //        if let jsonCountry = try? decoder.decode([Country].self, from: json) {
        //            countries = jsonCountry
        //            print(countries)
        //        }
        do {
            let jsonCountry = try decoder.decode([Country].self, from: json)
            countries = jsonCountry
            countries.sort(by: { $0.name.common < $1.name.common })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
}

