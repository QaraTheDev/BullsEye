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
        scoreLabel.text = String(score)
        
        round += 1
        roundLabel.text = String(round)
        
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
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        popUpController.addAction(okAction)
        popUpController.addAction(cancelAction)
        present(popUpController, animated: true, completion: nil)
        newRound()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = sliderPosition.value.rounded()
        currentValue = Int(roundedValue)
        targetValue = Int.random(in: 1...100)
        newRound()
        // Do any additional setup after loading the view.
    }
    
    func newRound(){
        currentValue = 50
        targetValue = Int.random(in: 1...100)
        targetLabel.text = "\(targetValue)"
        sliderPosition.value = Float(currentValue)
    }


}

