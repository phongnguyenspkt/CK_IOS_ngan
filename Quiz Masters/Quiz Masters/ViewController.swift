//
//  ViewController.swift
//  Quiz Masters
//
//  
//
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var highscoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib. 
        view.backgroundColor = UIColor(patternImage: UIImage(named: bgImage!)!)
        
        loadQuizData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let score = NSUserDefaults.standardUserDefaults().integerForKey("score")
        let highscore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        
        scoreLabel.text = "Score: \(score)"
        highscoreLabel.text = "Highscore: \(highscore)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadQuizData() {
        //Multiple Choice Data
        let pathMC = NSBundle.mainBundle().pathForResource("MultipleChoice", ofType: "plist")
        let dictMC = NSDictionary(contentsOfFile: pathMC!)
        mcArray = dictMC!["Questions"]!.mutableCopy() as? Array
        
        //Single Choice Data
        let pathSC = NSBundle.mainBundle().pathForResource("SingleChoice", ofType: "plist")
        let dictSC = NSDictionary(contentsOfFile: pathSC!)
        scArray = dictSC!["Questions"]!.mutableCopy() as? Array
        
        //Right or Wrong Data
        let pathROW = NSBundle.mainBundle().pathForResource("RightOrWrong", ofType: "plist")
        let dictROW = NSDictionary(contentsOfFile: pathROW!)
        rowArray = dictROW!["Questions"]!.mutableCopy() as? Array
        
        //Imgage Quiz Data
        let pathIMG = NSBundle.mainBundle().pathForResource("ImageQuiz", ofType: "plist")
        let dictIMG = NSDictionary(contentsOfFile: pathIMG!)
        imgArray = dictIMG!["Questions"]!.mutableCopy() as? Array
        
        check()
    }
    
    func check() {
        print(mcArray)
        print(scArray)
        print(imgArray)
        print(rowArray)
    }
    
    
    
    
    
    
    
    
    

}

