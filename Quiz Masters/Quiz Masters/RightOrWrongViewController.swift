//
//  RightOrWrongViewController.swift
//  Quiz Masters
//
//
//  
//

import UIKit

class RightOrWrongViewController: UIViewController {
    
    @IBOutlet var progressView: UIProgressView!

    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    @IBAction func answerButtonHandler(sender: UIButton) {
        timer.invalidate()
        if sender.titleLabel!.text == correctAnswer {
            print("Correct")
            currentScore++
            cardButton.enabled = true
        } else {
            sender.backgroundColor = UIColor.redColor()
            print("Wrong Answer")
            showAlert(false)
        }
        for button in answerButtons {
            button.enabled = false
            if button.titleLabel!.text == correctAnswer {
                button.backgroundColor = UIColor.greenColor()
            }
        }
    }
    
    @IBOutlet var cardButton: UIButton!
    
    @IBAction func cardButtonHandler(sender: AnyObject) {
        cardButton.enabled = false
        if questionIdx < rowArray!.count - 1 {
            questionIdx++
        } else {
            questionIdx = 0
        }
        nextQuestion()
    }
    
    var correctAnswer: String?
    
    var question: String?
    
    var answers = ["Wrong","Right"]
    
    var questionIdx = 0
    
    var timer = NSTimer()
    
    var currentScore = 0
    
    var highscore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: UIImage(named: bgImage!)!)
        
        progressView.transform = CGAffineTransformScale(progressView.transform, 1, 10)
        
        cardButton.enabled = false
        rowArray!.shuffle()
        nextQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextQuestion() {
        let currentQuestion = rowArray![questionIdx]
        
        correctAnswer = currentQuestion["CorrectAnswer"] as? String
        question = currentQuestion["Question"] as? String
        
        titlesForButtons()
    }
    
    func titlesForButtons() {
        for (idx,button) in answerButtons.enumerate() {
            button.setTitle(answers[idx], forState: .Normal)
            button.enabled = true
            button.backgroundColor = UIColor(red: 83.0/255.0, green: 184.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        }
        
        questionLabel.text = question
        startTimer()
    }
    
    func startTimer() {
        progressView.progress = 1.0
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateProgressView", userInfo: nil, repeats: true)
    }
    
    func updateProgressView() {
        progressView.progress -= 0.01/10
        if progressView.progress <= 0 {
            outOfTime()
        }
    }
    
    func outOfTime() {
        timer.invalidate()
        showAlert(true)
        disableButtons()
    }
    
    func disableButtons() {
        for button in answerButtons {
            button.enabled = false
        }
    }
    
    func showAlert(slow: Bool) {
        if currentScore > highscore {
            highscore = currentScore
            NSUserDefaults.standardUserDefaults().setInteger(highscore, forKey: "highscore")
        }
        
        NSUserDefaults.standardUserDefaults().setInteger(currentScore, forKey: "score")
        
        var title: String?
        
        if slow {
            title = "Too Slow"
        } else {
            title = "Wrong Answer"
        }
        
        let alertController = UIAlertController(title: title, message: "Score: \(currentScore) \n Highscore: \(highscore)", preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "Ok", style: .Default, handler: { (alert: UIAlertAction!) in
            self.backToMenu()
        })
        
        alertController.addAction(ok)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func backToMenu() {
        navigationController?.popToRootViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
