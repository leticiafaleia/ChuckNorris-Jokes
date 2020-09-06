//
//  ViewController.swift
//  Fatos CN
//
//  Created by Letícia Santos on 24/08/20.
//  Copyright © 2020 Letícia Santos. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var favoritesJokes: [NSManagedObject] = []
    
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
// MARK - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeLabel?.text = "loading joke..."
        loadJokes()
    }
    
// MARK - Fetch Data from Core Data
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Joke")

      do {
        favoritesJokes = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }

    
// MARK - Fetch Jokes from the API
    func loadJokes(){
        ServiceAPI.fetchJokes { (info) in
            if let info = info {
                self.jokeLabel?.text = info.text
            }
        }
    }
// MARK - Next Joke Button
    @IBAction func nextBtn(_ sender: Any) {
        print("next joke")
        loadJokes()
    }
    
    
// MARK - Share Joke button
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
    
// MARK - Save Joke
    @IBAction func saveJoke(_ sender: UIButton) {
        
        guard let jokeText = jokeLabel?.text else {
                return
        }
        self.save(quote: jokeText)
        self.tableView?.reloadData()
    }
    
    func save(quote: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Joke", in: managedContext)!
        let joke = NSManagedObject(entity: entity, insertInto: managedContext)
        joke.setValue(quote, forKeyPath: "quote")
        
        do {
          try managedContext.save()
            if !favoritesJokes.contains(joke){
                favoritesJokes.append(joke)
                print("saved")
            } else {
                print("equal jokes")
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}


// MARK - TableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(favoritesJokes[indexPath.row])
            
            do{
                try managedContext.save()
                favoritesJokes.removeAll()
                viewWillAppear(true)
                tableView.reloadData()
                print("deleted")
            }catch{
              print("not deleted")
            }
        }
    }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let alert = UIAlertController(title: "", message: "\(favoritesJokes[indexPath.row].value(forKey: "quote") ?? "")", preferredStyle: .alert)

    let cancelAction = UIAlertAction(title: "Cancel",style: .cancel)
    alert.addAction(cancelAction)
    present(alert, animated: true)
  }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoritesJokes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    let joke = favoritesJokes[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = joke.value(forKeyPath: "quote") as? String
    return cell
  }
}
