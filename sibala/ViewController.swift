//
//  ViewController.swift
//  sibala
//
//  Created by jemiway on 2022/8/7.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playMessageLabel: UILabel!

    @IBOutlet weak var numImageView1: UIImageView!
    @IBOutlet weak var numImageView2: UIImageView!
    @IBOutlet weak var numImageView3: UIImageView!
    @IBOutlet weak var numImageView4: UIImageView!
    
    @IBOutlet weak var playerNumLabel: UILabel!
    @IBOutlet weak var scoreLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var playerNum = 1
    @IBAction func playerNumStepper(_ sender: UIStepper)
    {
        print (sender.value)
        playerNum = Int(sender.value)
        
        playerNumLabel.text = " \(playerNum) 人"
    }
    
    @IBAction func returnTextField(_ sender: Any)
    {
        view.endEditing(true)
    }
    var numArray = [0,0,0,0]
    
    @IBAction func onPlay(_ sender: UIButton)
    {
        var eyeCount = 0;
        var eyeNum = 0;
        var getNumOne = 0;
        var getNumTwo = 0;
        var getScore = 0;
                
        numArray[0] = Int.random(in: 1...6)
        numArray[1] = Int.random(in: 1...6)
        numArray[2] = Int.random(in: 1...6)
        numArray[3] = Int.random(in: 1...6)
        
        numImageView1.image = UIImage(systemName: "die.face."+String(numArray[0]))
        numImageView2.image = UIImage(systemName: "die.face."+String(numArray[1]))
        numImageView3.image = UIImage(systemName: "die.face."+String(numArray[2]))
        numImageView4.image = UIImage(systemName: "die.face."+String(numArray[3]))

        playerLabel.text = playerNameTextField.text! + " 擲出"
        playMessageLabel.text = ""
        
        for indexOne in 0...2
        {
            for indexTwo in (indexOne+1)...3
            {
                if numArray[indexOne] == numArray[indexTwo]
                {
                    eyeCount += 1
                    eyeNum = numArray[indexOne]
                }
            }
        }
        
        if eyeCount == 1
        {
            for index in 0...3
            {
                if numArray[index] != eyeNum
                {
                    getNumOne = numArray[index]
                }
            }
            for index in 0...3
            {
                if numArray[index] != eyeNum && numArray[index] != getNumOne
                {
                    getNumTwo = numArray[index]
                }
            }
            if (getNumOne+getNumTwo) == 3
            {
                playMessageLabel.text = "擲出 BiGi 有夠慘"
            }
            getScore = getNumOne+getNumTwo
        }
        else if eyeCount == 2
        {
            for index in 0...3
            {
                if numArray[index] != eyeNum
                {
                    getNumOne = numArray[index]
                    break
                }
            }
            if getNumOne > eyeNum
            {
                getScore = getNumOne+getNumOne
            }
            else
            {
                getScore = eyeNum+eyeNum
            }
        }
        else if eyeCount == 3
        {
            playMessageLabel.text = "三個骰子相同，再擲一次"
        }
        else if eyeCount == 6
        {
            // 豹子
            getNumOne = numArray[0]
            getNumTwo = numArray[0]
            getScore = getNumOne+getNumTwo
            
            playMessageLabel.text = "擲出 豹子!! 通殺"
        }
        else
        {
            playMessageLabel.text = "骰子都不同，再擲一次"
        }
        
        // print score
        if getScore == 0
        {
            scoreLabel.text = ""
        }
        else
        {
            scoreLabel.text = String(getScore)
            playerLabel.text = playerLabel.text! + " " + String(getScore) + " 點"
        }
    }
}

