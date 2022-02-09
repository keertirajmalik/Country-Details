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
//    let currencies: Currencies
//    let capital: [String]
//    let region, subregion: String
//    let languages: Languages
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

// MARK: - Currencies
struct Currencies: Codable {
    let pen: Pen
}

// MARK: - Pen
struct Pen: Codable {
    let name, symbol: String
}

// MARK: - Flags
struct Flags: Codable {
    let png: URL
    let svg: URL
}

// MARK: - Languages
struct Languages {
    let aym, que, spa: String
}

// MARK: - Maps
struct Maps: Codable{
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
}
