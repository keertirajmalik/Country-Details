//
//  CountryViewController.swift
//  Country
//
//  Created by Keertiraj Laxman Malik on 09/02/22.
//

import UIKit

class CountryViewController: UIViewController {
    
//    TODO: Add support to more informations
    var country = [Country]()
    var countryName: String?
    var countryNameLabel: UILabel!
    var capitalLabel: UILabel!
    var timeZoneLabel: UILabel!
    var continentLabel: UILabel!
    var currencyLabel: UILabel!
    
    var countryFlagView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        let urlString = "https://restcountries.com/v3.1/name/" + countryName!.replacingOccurrences(of: " ", with: "%20")
        
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
    
    override func loadView() {
    
        view = UIView()
        view.backgroundColor = .white
        
        countryNameLabel = UILabel()
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.textColor = .black
        countryNameLabel.numberOfLines = 0
        countryNameLabel.font = UIFont.systemFont(ofSize: 24)
        countryNameLabel.textAlignment = .center
        view.addSubview(countryNameLabel)
        
        countryFlagView =  UIImageView()
        countryFlagView.translatesAutoresizingMaskIntoConstraints = false
        countryFlagView.backgroundColor = .black
        countryFlagView.layer.borderWidth = 5
        countryFlagView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(countryFlagView)
        
        capitalLabel = UILabel()
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.textAlignment = .right
        capitalLabel.textColor = .black
        view.addSubview(capitalLabel)
        
        timeZoneLabel = UILabel()
        timeZoneLabel.translatesAutoresizingMaskIntoConstraints = false
        timeZoneLabel.textAlignment = .right
        timeZoneLabel.textColor = .black
        view.addSubview(timeZoneLabel)
        
        continentLabel = UILabel()
        continentLabel.translatesAutoresizingMaskIntoConstraints = false
        continentLabel.textAlignment = .right
        continentLabel.textColor = .black
        view.addSubview(continentLabel)
        
        currencyLabel = UILabel()
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.textAlignment = .right
        currencyLabel.textColor = .black
        view.addSubview(currencyLabel)
        
        NSLayoutConstraint.activate([
            countryNameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            countryNameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            countryNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryFlagView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryFlagView.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 20),
            capitalLabel.topAnchor.constraint(equalTo: countryFlagView.bottomAnchor, constant: 30),
            capitalLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            timeZoneLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 10),
            timeZoneLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            continentLabel.topAnchor.constraint(equalTo: timeZoneLabel.bottomAnchor, constant: 10),
            continentLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            currencyLabel.topAnchor.constraint(equalTo: continentLabel.bottomAnchor, constant: 10),
            currencyLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ])
    }
}

extension CountryViewController {
    func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        do {
            let jsonCountry = try decoder.decode([Country].self, from: json)
            country = jsonCountry
            loadCountryDetails(imageURL: country.first?.flags.png)
        } catch {
            print(error)
        }
    }
    
    func loadCountryDetails(imageURL: URL?) {
        if let url = imageURL {
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    let currentCountry = self.country.first
                    
                    self.countryFlagView.image = UIImage(data: data!)
                    self.countryNameLabel.text = self.countryName
                    self.capitalLabel.text = "Capital city: " + (currentCountry?.capital?.first ?? "Capital city not found")
                    self.timeZoneLabel.text = "TimeZone: " + (currentCountry?.timezones.first)!
                    self.continentLabel.text = "Continent: " + (currentCountry?.continents.first)!
                    self.currencyLabel.text = "Currency: " + (currentCountry?.currencies?.values.first?["name"] ?? "Currency not found") + "    " + (currentCountry?.currencies?.values.first?["symbol"] ?? "")
                }
            }
        }
    }
}
