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
    //@IBOutlet weak var startOver: UIButton! // outlet for Start Over button

    override func viewDidLoad() {
        super.viewDidLoad()
        //currentValue = lroundf(slider.value) // assigned value on launch
        //targetValue = 1 + Int(arc4random_uniform(100)) // generate a random target value
        // Do any additional setup after loading the view, typically from a nib.
        //startNewRound()
        
        //let thumbImageNormal = UIImage(named: "SliderThumb-Normal")! // image file name
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        //let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") // image literal. cute
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        //let trackLeftImage = UIImage(named: "SliderTrackLeft")!
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
        // Dispose of any resources that can be recreated.
    }
    
    
    

    // @IBAction labels are interface builder objects - event-driven
    @IBAction func showAlert() {
        //var difference: Int
        /*
        if (currentValue > targetValue) {
            difference = currentValue - targetValue
        }
        else if (targetValue > currentValue) {
            difference = targetValue - currentValue
        }
        else {
            difference = 0
        }
        */
        /*
        var difference = currentValue - targetValue
        if difference < 0 {
            difference *= -1
        }
        */
        let difference = abs(targetValue - currentValue) // absolute value (negative or positive)
        var points = 100 - difference
        //score += points
        
        /*
        let message = "The value of the slider is: \(currentValue)" +
                      "\nThe target value is: \(targetValue)" +
                      "\nThe difference is: \(difference)"
        */
 
        //let message = "You scored \(points) points!"
        
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

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        /*
        let action = UIAlertAction(title: "Dank",
                                   style: .default,
                                   handler: nil)
        */
        let action = UIAlertAction(title: "Next Round",
                                   style: .default,
                                   handler: {action in self.startNewRound()}) // added a closure
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        //startNewRound()
        
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
    
    /*
    @IBAction func startOver() {
        startNewGame()
    }
 */
    
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









