//
//  APIClient.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 31/08/2022.
//

import UIKit

final class APIClient {
    
    func downloadHogwartCharacters(for house: House, onComplete: @escaping ([Character], Error?) -> Void) {
        let urlString = "https://hp-api.herokuapp.com/api/characters/house/\(house.apiName)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        onComplete([], error)
                        return
                    }
                    
                    if let safeData = data {
                        if let decodedCharacters = self.parseJSON(safeData) {
                            onComplete(decodedCharacters, nil)
                            return
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ charactersData: Data) -> [Character]? {
        let decoder = JSONDecoder()
        do {
            let decodedCharacters = try decoder.decode([Character].self, from: charactersData)
            return decodedCharacters
        } catch(let error) {
            print(error)
            return nil
        }
    }
}
