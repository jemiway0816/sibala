//
//  ViewController.swift
//  sibala
//
//  Created by jemiway on 2022/8/7.
//

import UIKit
import AVFoundation

var playerNum = 1
var player3:AVAudioPlayer?

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
    
    var getScore = 0
    var messageNum = 0
    var numArray = [0,0,0,0]
    var sound = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        if let url2 = Bundle.main.url(forResource: "骰子聲", withExtension: "mp3")
        {
            player3 = try? AVAudioPlayer(contentsOf: url2)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        
    }
    
    @IBAction func moveToPlayer2(_ sender: UISwipeGestureRecognizer)
    {
        if playerNum > 1
        {
            if let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "Player2ViewController") as? Player2ViewController
            {
                secondVC.firstVC = self
                print("set ok")
                self.present(secondVC, animated: true)
            }
    //        self.performSegue(withIdentifier: "gotoP2", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }
  
    let stringDic:[Int:String] =
    [
        0:"",
        3:"擲出 BiGi 有夠慘",
        333:"三個骰子相同，再擲一次",
        6666:"擲出 豹子!! 通殺",
        1234:"骰子都不同，再擲一次"
    ]
    
    @IBAction func playerNumStepper(_ sender: UIStepper)
    {
//        print (sender.value)
        playerNum = Int(sender.value)
        playerNumLabel.text = " \(playerNum) 人"
    }
    
    @IBAction func returnTextField(_ sender: Any)
    {
        view.endEditing(true)
    }
       
    func doCount(_ numArray:[Int])
    {
        var eyeCount = 0;
        var eyeNum = 0;
        var getNumOne = 0;
        var getNumTwo = 0;
        
        /*
        if sound == 0
        {
           print("play mp3")
           player3?.play()
        }
        */
        
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
                messageNum = 3
                // "擲出 BiGi 有夠慘"
            }
            else
            {
                messageNum = 0
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
            messageNum = 0
        }
        else if eyeCount == 3
        {
            messageNum = 333
            getScore = 0
            // "三個骰子相同，再擲一次"
        }
        else if eyeCount == 6
        {
            // 豹子
            getNumOne = numArray[0]
            getNumTwo = numArray[0]
            getScore = getNumOne+getNumTwo

            messageNum = 6666
            // "擲出 豹子!! 通殺"
        }
        else
        {
            messageNum = 1234
            getScore = 0
            // "骰子都不同，再擲一次"
        }
        
    }
    
    
    func getDice()
    {
        self.numArray[0] = Int.random(in: 1...6)
        self.numArray[1] = Int.random(in: 1...6)
        self.numArray[2] = Int.random(in: 1...6)
        self.numArray[3] = Int.random(in: 1...6)
    }
    
    func showDice()
    {
        self.numImageView1.image = UIImage(named: "dice"+String(self.numArray[0]))
        self.numImageView2.image = UIImage(named: "dice"+String(self.numArray[1]))
        self.numImageView3.image = UIImage(named: "dice"+String(self.numArray[2]))
        self.numImageView4.image = UIImage(named: "dice"+String(self.numArray[3]))
    }
    
    @IBAction func onPlay(_ sender: UIButton)
    {

        getDice()
        showDice()

        playerLabel.text = playerNameTextField.text! + " 擲出"
        playMessageLabel.text = ""

        doCount(numArray)
        
        playMessageLabel.text = stringDic[messageNum]
        
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

