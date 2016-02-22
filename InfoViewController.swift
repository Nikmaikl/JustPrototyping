//
//  InfroViewController.swift
//  JustPrototyping
//
//  Created by Michael on 30.11.15.
//  Copyright © 2015 Ocode. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var backButtonView: UIView!
    
    var currentCardIndex: Int!
    
    var card: Card! {
        didSet {
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? ViewController {
            controller.currentCardIndex = currentCardIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainPhoto.image = card.image
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
