//
//  NetworkManager.swift
//  Wheather
//
//  Created by Timur Saidov on 04/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    
    // MARK: Public Pro;erties
    
    static let shared = NetworkManager()
    let api = "https://samples.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric&appid=b6907d289e10d714a6e88b30761fae22"
    
    
    // MARK: Public
    
    func fetchWhether(completion: @escaping (_: [Wheather]) -> ()) {
        guard let url = URL(string: api) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let whetherJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
                guard let citiesWhether = Wheather.parse(json: whetherJSON) else { return }
                DispatchQueue.main.async {
                    completion(citiesWhether)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
