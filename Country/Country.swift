//
//  Country.swift
//  Country
//
//  Created by Keertiraj Laxman Malik on 09/02/22.
//

import Foundation

// MARK: - Country
struct Country: Codable {
    let name: Name
    var currencies: [String: [String: String]]? = ["": ["name": "Currency not found"]]
    var capital: [String]? = ["Capital city not found"]
//    let region, subregion: String
    var languages: [String: String]? = ["": "Languages not found"]
    let maps: Maps
    let population: Int
//    let fifa: String //TODO: Try to make this optional
//    let car: Car
    let timezones, continents: [String]
    let flags: Flags
    let startOfWeek: String
//    let capitalInfo: CapitalInfo
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]
    let side: String
}

// MARK: - Flags
struct Flags: Codable {
    let png: URL
    let svg: URL
}

// MARK: - Maps
struct Maps: Codable{
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
}
