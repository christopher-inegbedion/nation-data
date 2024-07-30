//
//  AllCountryFetcher.swift
//  NationData
//
//  Created by Christopher Inegbedion on 27/07/2024.
//

import Foundation

class AllCountryFetcher {
    static func getAllCountries() -> [Country] {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            print("Failed to locate countries.json in the bundle.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let countries = try JSONDecoder().decode([Country].self, from: data)
            
            return countries
        } catch {
            print("Failed to load and decode countries.json: \(error.localizedDescription)")
            return []
        }
    }
}
