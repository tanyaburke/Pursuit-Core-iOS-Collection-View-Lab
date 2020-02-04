//
//  ViewController.swift
//  Collection-View-Lab
//
//  Created by Tanya Burke on 1/14/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

//
//This view controller should contain a:
//
//- Search Bar
//- Collection View
//
//Entering a term in the search bar should load the countries with a name matching the search term.  Each cell should have:
//
//- An image of the flag
//- The country's name
//- The country's capital
//- The country's population
//- Selecting on a cell should segue to another View Controller

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
        
    @IBOutlet weak var searchBar: UISearchBar!
    

    private var countries = [Countries](){
            didSet{
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.dataSource = self
            collectionView.delegate = self
            searchBar.delegate = self
            collectionView.backgroundColor = .blue
            fetchDogImages(searchQuery: "united")
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPathsForSelectedItems?.first else{
            fatalError("couldnt pass country")
        }
        detailVC.country = countries[indexPath.row]
    }
        
    private func fetchDogImages(searchQuery: String){
            CountryListAPI.getListOfCountries(query: searchQuery) { [weak self](result) in
                    switch result {
                    case .failure(let appError):
                        print("could not fetch dog images\(appError)")
                    case .success(let data):
                        self?.countries = data
                    }
                }
            }
            
    }

    extension ViewController: UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return countries.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CollectionViewCell else{
                fatalError("could not downcast to CollectionViewCell")
            }
            let country = countries[indexPath.row]
            cell.configureCell(for: country)
            
            return cell
        }
        
    }

    extension ViewController: UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let interItemSpacing: CGFloat = 10
            let maxWidth = UIScreen.main.bounds.width
            let numberOfItems: CGFloat = 3
            let totalSpacing:CGFloat = numberOfItems * interItemSpacing
            let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5
            
        }

}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text?.lowercased() else {
            print("missing search text")
            return
        }
        fetchDogImages(searchQuery: searchText)
    }
}


