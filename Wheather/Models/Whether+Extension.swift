//
//  Whether+Extension.swift
//  Wheather
//
//  Created by Timur Saidov on 04/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

extension Wheather {
    
    static func parse(json: [String: Any]) -> [Wheather]? {
        var citiesWheather: [Wheather] = []
        
        guard let list = json["list"] as? [[String: Any]] else { return citiesWheather }
        
        for item in list {
            guard
                let name = item["name"] as? String,
                let coord = item["coord"] as? [String: Double],
                let main = item["main"] as? [String: Double],
                let weather = item["weather"] as? [[String: Any]]
                else { return citiesWheather }
            guard
                let lon = coord["lon"],
                let lat = coord["lat"],
                let temp = main["temp"]
                else { return citiesWheather }
            guard let weatherFirst = weather.first else { return citiesWheather }
            guard let description = weatherFirst["description"] as? String else { return citiesWheather }
            
            let wheather = Wheather(name: name,
                                    lon: lon,
                                    lat: lat,
                                    temp: temp,
                                    description: description)
            citiesWheather.append(wheather)
        }
        
        return citiesWheather
    }
}
