//
//  Currency Model.swift
//  Collection-View-Lab
//
//  Created by Tanya Burke on 1/16/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

struct ExchangeRate: Decodable {
    let rates: [String: Double]
}
