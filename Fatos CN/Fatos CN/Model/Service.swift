//
//  Service.swift
//  Fatos CN
//
//  Created by Letícia Santos on 24/08/20.
//  Copyright © 2020 Letícia Santos. All rights reserved.
//

import Foundation
import Alamofire

class ServiceAPI {
    
    let url = "https://api.chucknorris.io/jokes/random"
    
     func fetchJokes(){
        AF.request(url, method: .get, parameters: ["String": "Any"]).responseJSON { response in
            switch response.result {
            case .success:
                print(response)
            case .failure(let error):
                print("Error to fetch data! \(error)")
            }
        }
    }
}