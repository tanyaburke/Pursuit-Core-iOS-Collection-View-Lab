//
//  DetailViewController.swift
//  Collection-View-Lab
//
//  Created by Tanya Burke on 1/14/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

//
//An image of the flag
//- The country's name
//- The country's capital
//- The country's population


//- The currency and the currency's value in USD
//- The current weather in the country's capital

class DetailViewController: UIViewController {
    
    @IBOutlet weak var countryImage: UIImageView!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var exchangeRate:UILabel!
    var country: Countries?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         updateUI()
    }
    
         
        
     func getRate() {
         CountryListAPI.getCurrency { (result) in
             switch result {
             case .failure(let appError):
                 print("error with exchange: \(appError)")
             case .success(let rate):
                 
                 let exchangeRate = rate.rates[self.country?.currencies.first?.code ?? " "] ?? 0
                 let formatedRate = String(format: "%.0f", exchangeRate)
                 let currencyName = self.country?.currencies.first?.name ?? " "
                 
                 DispatchQueue.main.async {
                     self.exchangeRate.text = "1 US Dollar = \(formatedRate) \(currencyName)"
                 }
                 
                 
             }
         }
     }
        
         func updateUI() {
            
             guard let country = country else {
                 fatalError("no country or exchange") }
            navigationItem.title = country.name
                
             countryLabel.text = "Capital: \(country.capital) \nPopulation: \(country.population)"
             getRate()
         
             countryImage.getImage(with: "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png") { [weak self] (result) in
                 switch result {
                 case .failure(let appError):
                     print("error with getting flag: \(appError)")
                 case .success(let image):
                     DispatchQueue.main.async {
                         self?.countryImage.image = image
                     }
                     
                 }
             }
         
         }

     }
    
