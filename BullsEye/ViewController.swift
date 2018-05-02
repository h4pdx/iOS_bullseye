//
//  ViewController.swift
//  BullsEye
//
//  Created by Ryan Hoover on 4/24/18.
//  Copyright © 2018 fatalerr. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider! // putlet for slider value in main.storyboard
    @IBOutlet weak var targetLabel: UILabel! // outlet for target value in main.storyboard
    @IBOutlet weak var scoreLabel: UILabel! // outlet for score
    @IBOutlet weak var roundLabel: UILabel! // outlet for round

    override func viewDidLoad() {
        super.viewDidLoad()
        //let thumbImageNormal = UIImage(named: "SliderThumb-Normal")! // image file name
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
    
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") // image literal. cute
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        //let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // @IBAction labels are interface builder objects - event-driven
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue) // absolute value (negative or positive)
        var points = 100 - difference
        let title: String
        
        if difference == 0 {
            title = "Bull's Eye!"
            points += 100 // bonus points
        }
        else if difference <= 5 {
            title = "So close!"
            if difference == 1 {
                points += 50 // bonus if within 1
            }
        }
        else if difference <= 10 {
            title = "Missed the mark."
        }
        else {
            title = "Not even close..."
        }
        
        score += points // update total score
        
        let message = "You scored \(points) points!" +
                      "\nYour shot: \(currentValue)" +
                      "\nThe target: \(targetValue)" +
                      "\nThe difference is: \(difference)"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "Next Round",
                                   style: .default,
                                   handler: {action in self.startNewRound()}) // added a closure
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        //print("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        
        // add cross-fade
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    /* NEW ROUND
     - target value is generated at random
     - current value is reset to middle
     - slider value is set to current value (reset)
     - labels are updated
    */
    func startNewRound() {
        round += 1 // increment round number
        targetValue = 1 + Int(arc4random_uniform(100)) // random number generator
        currentValue = 50 // reset value to middle of slider
        slider.value = Float(currentValue) // reset slider value
        updateLabels() // update labels with new var values
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue) // update UILabel with randomly generated value
        //targetLabel.text = "\(targetValue)" // alternative to typecasting as string
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    
}









