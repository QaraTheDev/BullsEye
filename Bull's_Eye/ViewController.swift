//
//  ViewController.swift
//  Bull's_Eye
//
//  Created by Andas on 18.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 1
    
    @IBOutlet weak var sliderPosition: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
//    connection between storyboard and viewController, so you can do any action with it
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value.rounded())
    }
    
//    action that happens after touch Button
    @IBAction func btn(_ sender: UIButton) {
        
        let diffrence = abs(currentValue - targetValue)
        var points = 100 - diffrence
        score += points
                
        let title: String
        if diffrence == 0 {
            title = "Perfect!"
            points += 100
        }else if diffrence < 5{
            title = "You almost have it!"
            points += 50
        }else if diffrence < 10{
            title = "Good!"
            points += 25
        }else{
            title = "Not even close."
        }
        
        let popUpController = UIAlertController(title: title, message: "You scored \(points)!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default,handler: {_ in self.newRound()})

        popUpController.addAction(okAction)
        present(popUpController, animated: true, completion: nil)
    }
    
    @IBAction func resetButton(){
        score = 0
        round = 0
        newRound()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = sliderPosition.value.rounded()
        currentValue = Int(roundedValue)
        resetButton()
        newRound()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        sliderPosition.setThumbImage( thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        sliderPosition.setThumbImage( thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        sliderPosition.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        sliderPosition.setMaximumTrackImage(trackRightResizeable, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    func newRound(){
        round += 1
        currentValue = 50
        targetValue = Int.random(in: 1...100)
        sliderPosition.value = Float(currentValue)
        updateLabel()
    }
    
    func updateLabel(){
        targetLabel.text = String(targetValue)
        roundLabel.text = String(round)
        scoreLabel.text = String(score)
    }


}

