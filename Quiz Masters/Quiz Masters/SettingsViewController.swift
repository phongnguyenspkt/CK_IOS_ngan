//
//  SettingsViewController.swift
//  Quiz Masters
//
// 
//
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var gameModeButtons: [UIButton]!
    
    @IBAction func gameModeButtonHandler(sender: UIButton) {
        for button in gameModeButtons {
            if sender != button {
                button.alpha = 0.7
            } else {
                button.alpha = 1.0
                gameMode = button.tag
            }
        }
    }
    
    @IBAction func playButtonHandler(sender: AnyObject) {
        var vc: UIViewController?
        switch gameMode {
        case 0:
            //Multiplechoice Quiz
            vc = storyboard?.instantiateViewControllerWithIdentifier("multipleChoiceViewController") as! MultipleChoiceViewController
            break
        case 1:
            //Right or Wrong Quiz
            vc = storyboard?.instantiateViewControllerWithIdentifier("rightOrWrongViewController") as! RightOrWrongViewController
            break
        case 2:
            //Single Choice Quiz
            vc = storyboard?.instantiateViewControllerWithIdentifier("inputViewController") as! InputViewController
            break
        case 3:
            //Image Quiz
            vc = storyboard?.instantiateViewControllerWithIdentifier("imageViewController") as! ImageViewController
            break
        default:
            break
        }
        if vc != nil {
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    var gameMode = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: UIImage(named: bgImage!)!)
        
        for (idx,button) in gameModeButtons.enumerate() {
            button.tag = idx
            if button.tag != 0 {
                button.alpha = 0.7
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
