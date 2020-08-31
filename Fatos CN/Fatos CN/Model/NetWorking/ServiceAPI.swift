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

    static private let url = "https://api.chucknorris.io/jokes/random"
    
    class func fetchJokes(onComplete: @escaping (Facts?) -> Void) {
        AF.request(url, method: .get, parameters: ["String": "Any"]).responseJSON { (response) in
            if let data = response.data {
                let jokesInfo = try? JSONDecoder().decode(Facts.self, from: data)
                onComplete(jokesInfo)
            } else {
                onComplete(nil)
            }
        }
    }
}
//            } switch response.result {
//            case .success:
//                DispatchQueue.main.async {
//                    print(value.text)
//                }
//            case .failure(let error):
//                print("Error to fetch data! \(error)")
//            }
//        }

