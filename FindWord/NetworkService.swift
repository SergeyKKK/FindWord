//
//  NetworkService.swift
//  FindWord
//
//  Created by Serega Kushnarev on 19.12.2020.
//

import Foundation

// MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol {
    func getWord(text: String, completion: @escaping (Result<[Word]?, Error>) -> Void)
    
}

// MARK: - NetworkService

class NetworkService: NetworkServiceProtocol {
   
    func getWord(text: String, completion: @escaping (Result<[Word]?, Error>) -> Void) {
        
        guard let url = URL(string: "https://dictionary.skyeng.ru/api/public/v1/words/search?search=\(text)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONDecoder().decode([Word].self, from: data)
                completion(.success(json))
                print(json)
            } catch {
                print(error)
            }
        } .resume()
    }
}


