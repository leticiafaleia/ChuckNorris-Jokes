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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJokes()
    }
    
    var favoritesJokes = [String]()
    
    @IBOutlet weak var jokeLabel: UILabel!
    @IBAction func favoriteBtn(_ sender: Any) {
        favoritesJokes.append(jokeLabel.text ?? "")
        print("Favoritado")
    }
    @IBAction func nextBtn(_ sender: Any) {
        fetchJokes()
        print("Próxima piada")
    }
    
    @IBAction func shareJoke(_ sender: Any) {
        let shareBtn = UIActivityViewController(activityItems: [jokeLabel.text], applicationActivities: nil)
        
        shareBtn.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("Completed!")
            } else {
                print("Canceled!")
            }
        }
        
        present(shareBtn, animated: true){
            print("Presented!")
        }
        
    }
    
        
    func fetchJokes(){
        let url = "https://api.chucknorris.io/jokes/random"
        AF.request(url, method: .get, parameters: ["String": "Any"]).responseJSON { response in
            let value: Facts = try! JSONDecoder().decode(Facts.self, from: response.data!)
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.jokeLabel?.text = value.text
                }
            case .failure(let error):
                print("Error to fetch data! \(error)")
            }
        }
    }
}


