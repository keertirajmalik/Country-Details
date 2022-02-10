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
        let vc = CountryViewController()
        
        vc.countryName = CountryList().countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


