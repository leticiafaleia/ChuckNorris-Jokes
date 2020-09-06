//
//  JSON.swift
//  Fatos CN
//
//  Created by Letícia Santos on 24/08/20.
//  Copyright © 2020 Letícia Santos. All rights reserved.
//

import Foundation

struct Facts: Decodable {
    var icon: String
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case icon = "icon_url"
        case text = "value"
    }
}
