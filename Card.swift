//
//  Card.swift
//  JustPrototyping
//
//  Created by Michael Nikolaev on 14.12.15.
//  Copyright © 2015 Ocode. All rights reserved.
//

import UIKit

class Card {
    var title: String!
    var likes: Int!
    var share: Int!
    var image: UIImage!
    
    init(title: String, imagePath: String, likes: Int, share: Int) {
        self.title = title
        self.image = UIImage(named: imagePath)
        self.likes = likes
        self.share = share
    }
}