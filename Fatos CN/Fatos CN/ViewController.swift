//
//  ViewController.swift
//  Fatos CN
//
//  Created by Letícia Santos on 24/08/20.
//  Copyright © 2020 Letícia Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var serviceAPI = ServiceAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceAPI.fetchJokes()
        // Do any additional setup after loading the view.
    }


}

