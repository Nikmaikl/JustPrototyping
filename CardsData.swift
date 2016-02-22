//
//  CardsData.swift
//  JustPrototyping
//
//  Created by Michael Nikolaev on 14.12.15.
//  Copyright © 2015 Ocode. All rights reserved.
//

import Foundation

class CardsData {
    static var cards = CardsData.getCards()
    
    private class func getCards() -> Array<Card> {
        var result = Array<Card>()
        
        result.append(Card(title: "Bora-Bora", imagePath: "background", likes: 340, share: 211))
        result.append(Card(title: "Yosemite", imagePath: "Yosemite_bg", likes: 221, share: 87))
        result.append(Card(title: "Grand Canyon", imagePath: "Grand_canyon", likes: 21, share: 871))
        result.append(Card(title: "Iceland", imagePath: "Iceland_bg", likes: 112, share: 211))
        
        return result
    }
}