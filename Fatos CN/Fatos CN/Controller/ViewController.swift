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

    var favoriteJokes = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        jokeLabel.text = "loading joke..."
        loadJokes()
    }
    
    @IBAction func favoriteBtn(_ sender: UIButton) {
        var joke: Joke!
        joke = Joke.init(context: context)
        joke.quote = jokeLabel.text
        do {
            try context.save()
            print("save into favs list")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        print("next joke")
        loadJokes()
    }
    
    @IBAction func shareJoke(_ sender: Any) {
        let shareBtn = UIActivityViewController(activityItems: [jokeLabel.text], applicationActivities: nil)
        
        shareBtn.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("canceled")
            }
        }
        
        present(shareBtn, animated: true){
            print("presented")
        }
    }
    
    func loadJokes(){
        ServiceAPI.fetchJokes { (info) in
            if let info = info {
                self.jokeLabel.text = info.text
            }
        }
    }
}
