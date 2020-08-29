//
//  ViewController.swift
//  Fatos CN
//
//  Created by Letícia Santos on 24/08/20.
//  Copyright © 2020 Letícia Santos. All rights reserved.
//

import UIKit
import Alamofire

struct Facts: Decodable {
    var icon: String
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case icon = "icon_url"
        case text = "value"
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var jokeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJokes()
    }
        
    func fetchJokes(){
        let url = "https://api.chucknorris.io/jokes/random"
        AF.request(url, method: .get, parameters: ["String": "Any"]).responseJSON { response in
            let value: Facts = try! JSONDecoder().decode(Facts.self, from: response.data!)
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.jokeLabel.text = value.text
                }
            case .failure(let error):
                print("Error to fetch data! \(error)")
            }
        }
    }
}


