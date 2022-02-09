//
//  CountryViewController.swift
//  Country
//
//  Created by Keertiraj Laxman Malik on 09/02/22.
//

import UIKit

class CountryViewController: UIViewController {
    
    var country = [Country]()
    var countryName: String?
    
    @IBOutlet var countryFlagView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        let urlString = "https://restcountries.com/v3.1/name/" + countryName!
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CountryViewController {
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
            country = jsonCountry
            loadImage(imageURL: country.first?.flags.png)
        } catch {
            print(error)
        }
    }
    
    func loadImage(imageURL: URL?) {
        if let url = imageURL {
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.countryFlagView.image = UIImage(data: data!)
                }
            }
        }
    }
}
