//
//  InputViewController.swift
//  Quiz Masters
//
//
//
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var correctAnswerLabel: UILabel!
    
    @IBOutlet var inputTextField: UITextField!
    
    @IBOutlet var cardButton: UIButton!
    
    @IBAction func cardButtonHandler(sender: AnyObject) {
        cardButton.enabled = false
        if questionIdx < scArray!.count - 1 {
            questionIdx++
        } else {
            questionIdx = 0
        }
        nextQuestion()
    }
    
    var enteredAnswer: String?
    
    var correctAnswer: String?
    
    var question: String?
    
    var questionIdx = 0
    
    var timer = NSTimer()
    
    var currentScore = 0
    
    var highscore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: UIImage(named: bgImage!)!)
        
        progressView.transform = CGAffineTransformScale(progressView.transform, 1, 10)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
        
        inputTextField.delegate = self
        
        cardButton.enabled = false
        scArray!.shuffle()
        nextQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextQuestion() {
        let currentQuestion = scArray![questionIdx]
        
        correctAnswer = currentQuestion["CorrectAnswer"] as? String
        question = currentQuestion["Question"] as? String
        
        titlesForLabels()
    }
    
    func titlesForLabels() {
        questionLabel.text = question
        correctAnswerLabel.text = correctAnswer
        correctAnswerLabel.hidden = true
        
        inputTextField.text = nil
        inputTextField.enabled = true
        
        startTimer()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.frame.origin.y = -keyboardFrame.size.height
        })
    }
    
    func keyboardWillHide() {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.frame.origin.y = 0
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        timer.invalidate()
        
        enteredAnswer = textField.text
        
        textField.enabled = false
        
        checkForCorrectAnswer()
        
        return true
    }
    
    func checkForCorrectAnswer() {
        if enteredAnswer!.lowercaseString == correctAnswer!.lowercaseString {
            print("Correct")
            currentScore++
            cardButton.enabled = true
            correctAnswerLabel.textColor = UIColor.greenColor()
        } else {
            print("Wrong Answer")
            showAlert(false)
            correctAnswerLabel.textColor = UIColor.redColor()
        }
        correctAnswerLabel.hidden = false
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
        inputTextField.enabled = false
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
