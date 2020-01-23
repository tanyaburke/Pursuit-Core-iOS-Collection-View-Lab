//
//  CollectionViewCell.swift
//  Collection-View-Lab
//
//  Created by Tanya Burke on 1/14/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import ImageKit

class CollectionViewCell: UICollectionViewCell {
   
    
    
    
    
        @IBOutlet weak var countryImage: UIImageView!
        @IBOutlet weak var countryNameAndCap:UILabel!
       
    
    
        func configureCell(for country: Countries) {
            let countryCode = country.alpha2Code
            let flagEndpoint = "https://www.countryflags.io/\(countryCode)/flat/64.png"
            countryImage.getImage(with: flagEndpoint) { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    print("Failed to load image: \(appError)")
                    DispatchQueue.main.async {
                        self?.countryImage.image = UIImage(systemName: "exclamation-triangle")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.countryImage.image = image
                        
                        self!.countryNameAndCap.text = "Name: \(country.name)\nCapital: \(country.capital)"
                    }
                }
            }
        }
    }
    
            
    
        
    //
    //}

    
    


