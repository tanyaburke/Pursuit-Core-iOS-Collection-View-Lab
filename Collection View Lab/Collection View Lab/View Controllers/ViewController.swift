//
//  ViewController.swift
//  Collection View Lab
//
//  Created by Jason Ruan on 9/26/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    var arrayOfCountries: [Country] = [] {
        didSet {
            countryCollectionView.reloadData()
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialViewController()
    }
    
    private func configureInitialViewController() {
        countrySearchBar.delegate = self
        countryCollectionView.dataSource = self
        countryCollectionView.delegate = self
    }
    
}

extension ViewController: UISearchBarDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currentCountry = arrayOfCountries[indexPath.row]
        cell.countryNameLabel.text = currentCountry.name
        cell.capitalNameLabel.text = currentCountry.capital
        cell.populationLabel.text = currentCountry.population.description
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}
