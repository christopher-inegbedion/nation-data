//
//  WorldBankDataAPI.swift
//  NationData
//
//  Created by Christopher Inegbedion on 25/08/2024.
//


import Foundation

// Function to fetch data from the World Bank API with a custom time range
func fetchWorldBankData(forIndicator indicator: String, inCountry country: String, fromYear startYear: String, toYear endYear: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
    // Define the World Bank API URL with the custom time range
    let urlString = "https://api.worldbank.org/v2/country/\(country)/indicator/\(indicator)?date=\(startYear):\(endYear)&format=json"
    
    // Convert the urlString to a URL object
    guard let url = URL(string: urlString) else {
        print("Invalid URL.")
        return
    }
    
    // Create a URLSession data task
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // Handle error if any
        if let error = error {
            completion(.failure(error))
            return
        }
        
        // Check if the response contains data
        guard let data = data else {
            print("No data received.")
            return
        }
        
        do {
            // Parse the JSON response
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                // The World Bank API returns an array of dictionaries. The first element usually contains metadata, and the second contains the actual data.
                if json.count > 1 {
                    let data = json[1]
                    completion(.success(data))
                } else {
                    print("Unexpected JSON structure.")
                }
            } else {
            }
        } catch let jsonError {
            completion(.failure(jsonError))
        }
    }
    
    // Start the task
    task.resume()
}
