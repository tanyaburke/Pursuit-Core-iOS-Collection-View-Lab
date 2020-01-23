//
//  CountryAPI.swift
//  Collection-View-Lab
//
//  Created by Tanya Burke on 1/15/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation
import NetworkHelper

struct CountryListAPI{
    static func getListOfCountries(completion: @escaping (Result<[Countries],AppError>)->()){
        let endPointURLString = "https://restcountries.eu/rest/v2/name/united"
        guard let url = URL(string: endPointURLString) else{
           completion (.failure(.badURL(endPointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
//        let countryList = [CountryList]()
        NetworkHelper.shared.performDataTask(with:request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let countryList = try JSONDecoder().decode([Countries].self, from: data)
                    completion(.success(countryList))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }


static func getCurrency(completion: @escaping (Result<ExchangeRate,AppError>)->()){
    let endPointURLString = "http://data.fixer.io/api/latest?access_key=a17aef5ece92cf36d9c5963f7f4babf1&format=1"
    guard let url = URL(string: endPointURLString) else{
       completion (.failure(.badURL(endPointURLString)))
        return
}
     let request = URLRequest(url: url)
    NetworkHelper.shared.performDataTask(with: request) { (result) in
        switch result{
        case .failure(let appError):
            completion(.failure(.networkClientError(appError)))
        case .success(let data):
            do{
                let exchangeRates = try JSONDecoder().decode(ExchangeRate.self, from: data)
                completion(.success(exchangeRates))
            }catch{
                completion(.failure(.decodingError(error)))
            }
        }
        
    }
}
}
