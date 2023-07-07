//
//  Utility.swift
//  Diagnal
//
//  Created by Avinash Thakur on 01/07/23.
//

import Foundation
public class Utitity {
    
    /**
     Function loads json data from given file name
     - Parameter fileName: String Json file name
     
     - Returns: MovieResponse?  Returns movie response
     */
    public static func loadJson(fileName: String) -> MovieResponse? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MovieResponse.self, from: data)
                return moviesResponse
            } catch {
                print("error:\(error)")
                return nil
            }
        }
        return nil
    }
}
