//
//  FirstQuestionViewController.swift
//  NationData
//
//  Created by Christopher Inegbedion on 28/07/2024.
//

import Foundation
import UIKit

class FirstQuestionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchBar: UISearchController?
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let flagColorsCache = NSCache<NSString, UIImageColors>()
    
    private var countriesForSearching: [Country] = AllCountryFetcher.getAllCountries()
    private var countries: [Country] = AllCountryFetcher.getAllCountries()
    
    private var performedInitialLoad = false
    private var selectedCountryName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = collectionView.frame.width/2 - 10
            layout.minimumInteritemSpacing = 0 // Adjust this value to your desired spacing
            layout.minimumLineSpacing = 20      // Adjust this value to your desired spacing
            layout.itemSize.width = width
            layout.itemSize.height = width
        }
        
        searchBar = {
            let searchController = UISearchController()
            searchController.searchResultsUpdater = self
            searchController.delegate = self
            searchController.searchBar.placeholder = "Search for a country"
            
            return searchController
        }()
        
        navigationItem.backBarButtonItem = nil
        navigationItem.searchController = searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "moveToSecondPageSegue" {
            return selectedCountryName != ""
        }
        
        return false
    }
}

extension FirstQuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countrySelectionItemCell", for: indexPath) as! CountrySelectionItemCell
        
        let item = countries[indexPath.row]
        
        cell.layer.cornerRadius = 10
        DispatchQueue.main.async { [self] in
            if let cachedImage = imageCache.object(forKey: item.name as NSString) {
                cell.flagImageView.image = cachedImage
                cell.flagImageView.contentMode = .scaleAspectFill
                
                if let cachedFlagColors = flagColorsCache.object(forKey: item.name as NSString) {
                    cell.backgroundColor = cachedFlagColors.background
                    cell.countryNameLabel.textColor = cachedFlagColors.primary
                    cell.checkmarkImage.tintColor = cachedFlagColors.secondary
                }
            } else {
                cell.flagImageView.downloaded(from: "https://flagcdn.com/w2560/\(item.code.lowercased()).png", contentMode: .scaleAspectFill) { [self] in
                    if let image = cell.flagImageView.image {
                        imageCache.setObject(image, forKey: item.name as NSString)
                    }
                    
                    if let cachedFlagColors = flagColorsCache.object(forKey: item.name as NSString) {
                        cell.backgroundColor = cachedFlagColors.background
                        cell.countryNameLabel.textColor = cachedFlagColors.primary
                        cell.checkmarkImage.tintColor = cachedFlagColors.secondary
                    } else {
                        cell.flagImageView.image?.getColors { [self] colors in
                            if let colors = colors {
                                cell.backgroundColor = colors.background
                                cell.countryNameLabel.textColor = colors.primary
                                cell.checkmarkImage.tintColor = colors.secondary
                                flagColorsCache.setObject(colors, forKey: item.name as NSString)
                            }
                        }
                    }
                }
            }
        }
        
        
        cell.checkmarkImage.isHidden = selectedCountryName != item.name
        
        cell.countryNameLabel.text = item.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCountryName = countries[indexPath.row].name
        collectionView.reloadData()
        
    }
}

extension FirstQuestionViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        
        guard let text = text else {
            return
        }
        
        guard !text.isEmpty else {
            countries = AllCountryFetcher.getAllCountries()
            collectionView.reloadData()
            return
        }
        
        let newCountriesList = countriesForSearching.filter({ country in
            country.name.lowercased().contains(text.lowercased())
        })
        
        guard newCountriesList.count > 0 else {
            return
        }
        
        countries = newCountriesList
        
        collectionView.reloadData()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        countries = AllCountryFetcher.getAllCountries()
        collectionView.reloadData()
    }
    
}
