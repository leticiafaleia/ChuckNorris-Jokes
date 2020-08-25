//
//  JSON.swift
//  Fatos CN
//
//  Created by Letícia Santos on 24/08/20.
//  Copyright © 2020 Letícia Santos. All rights reserved.
//

import Foundation

struct ChuckNorris: Decodable {
    var icon: String
    var id: Int
    var facts: String
}
