//
//  ViewController.swift
//  JustPrototyping
//
//  Created by Michael on 10.11.15.
//  Copyright © 2015 Ocode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dialogFrame: UIView!
    
    @IBOutlet weak var headerVisualView: UIVisualEffectView!
    
    @IBOutlet weak var card_button: UIButton!
    @IBOutlet weak var titleOfCard: UILabel!
    
    @IBOutlet weak var heart: UIButton!
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var numberOfSharing: UILabel!
    
    var animator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var gravityBehavior: UIGravityBehavior!
    var snapBehavior: UISnapBehavior!
    
    var currentCardIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.dialogFrameAppered()
    }

    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(self.view)
        let boxLocation = sender.locationInView(dialogFrame)
        
        switch sender.state {
        case UIGestureRecognizerState.Began:
            let centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(dialogFrame.bounds), boxLocation.y - CGRectGetMidY(dialogFrame.bounds))
            attachmentBehavior = UIAttachmentBehavior(item: dialogFrame, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            animator.addBehavior(attachmentBehavior)
            
        case UIGestureRecognizerState.Changed:
            attachmentBehavior.anchorPoint = location
            
        case UIGestureRecognizerState.Ended:
            animator.removeBehavior(attachmentBehavior)
            snapBehavior = UISnapBehavior(item: dialogFrame, snapToPoint: self.view.center)
            animator.addBehavior(snapBehavior)
            
            let transition = sender.translationInView(self.view)
            if transition.y > 300 {
                for c in dialogFrame.constraints {
                    c.active = false
                }
                animator.removeAllBehaviors()
                let gravity = UIGravityBehavior(items: [dialogFrame])
                gravity.gravityDirection = CGVectorMake(0, 10)
                animator.addBehavior(gravity)
                
                dialogFrameAppered()
            }
            
        default:
            break
        }
    }
    
    func dialogFrameAppered() {
        currentCardIndex = (currentCardIndex >= CardsData.cards.count-1) ? 0 : currentCardIndex+1
        
        backgroundImageView.image = CardsData.cards[currentCardIndex].image
        card_button.imageView?.image = CardsData.cards[currentCardIndex].image
        card_button.setImage(CardsData.cards[currentCardIndex].image, forState: UIControlState.Normal)
        titleOfCard.text = CardsData.cards[currentCardIndex].title
        numberOfLikes.text = "\(CardsData.cards[currentCardIndex].likes)"
        numberOfSharing.text = "\(CardsData.cards[currentCardIndex].share)"

        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        let translate = CGAffineTransformMakeTranslation(0, -200)
        self.dialogFrame.transform = scale
        self.dialogFrame.transform = CGAffineTransformConcat(translate, scale)
        
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(1, 1)
            self.dialogFrame.transform = CGAffineTransformConcat(translate, scale)
            }, completion: { Bool in
                for c in self.dialogFrame.constraints {
                    c.active = true
                }
        })
    }
    
    @IBAction func likePressed(sender: AnyObject) {
        numberOfLikes.text = "\(Int(numberOfLikes.text!)!+1)"
    }
    
    @IBAction func sharePressed(sender: AnyObject) {
        numberOfSharing.text = "\(Int(numberOfSharing.text!)!+1)"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? InfoViewController {
            controller.card = CardsData.cards[currentCardIndex]
            controller.currentCardIndex = currentCardIndex-1
        }
    }
    
    @IBAction func cardButtonPressed(sender: AnyObject) {
        self.numberOfLikes.alpha = 0
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.dialogFrame.frame = self.view.frame
            self.card_button.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 25)
            self.headerVisualView.alpha = 0
            self.heart.alpha = 0
            self.shareButton.alpha = 0
            self.numberOfSharing.alpha = 0
            self.dialogFrame.layer.cornerRadius = 0
            }, completion: { finished in
                self.performSegueWithIdentifier("More_info", sender: self)
                
        })
    }

}

