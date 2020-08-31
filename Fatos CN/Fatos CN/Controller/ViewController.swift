//
//  ViewController.swift
//  Fatos CN
//
//  Created by Letícia Santos on 24/08/20.
//  Copyright © 2020 Letícia Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var jokeLabel: UILabel!
    
    public var favoriteJokes = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        jokeLabel.text = "Carregando piada..."
        loadJokes()
    }
    
    @IBAction func favoriteBtn(_ sender: Any) {
        favoriteJokes.append(jokeLabel.text ?? "")
        print("Favoritado")
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        print("Próxima piada")
        loadJokes()
    }
    
    @IBAction func shareJoke(_ sender: Any) {
        let shareBtn = UIActivityViewController(activityItems: [jokeLabel.text], applicationActivities: nil)
        
        shareBtn.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("Completo")
            } else {
                print("Cancelado")
            }
        }
        
        present(shareBtn, animated: true){
            print("Apresentado")
        }
    }
    
    func loadJokes(){
        ServiceAPI.fetchJokes { (info) in
            if let info = info {
                self.jokeLabel.text = info.text
            }
        }
    }
    
    func favoriteJoke(){
        
    }
}


