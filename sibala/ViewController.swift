//
//  ViewController.swift
//  sibala
//
//  Created by jemiway on 2022/8/7.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playMessageLabel: UILabel!

    @IBOutlet var diceValueImgView: [UIImageView]!
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var playerNumLabel: UILabel!
    @IBOutlet weak var scoreLabel: UITextField!
    
    @IBOutlet weak var playerOletSegment: UISegmentedControl!
    @IBOutlet weak var tintValueLabel: UILabel!
    
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var playerNum = 1           // 有幾個玩家
    var whichPlayer = 0         // 現在是哪個玩家 0 1 2 3
    var playerNameArray:[String] = ["John","Mary","Tom","Amy"]
    var playerScoreArray:[Int] = [0,0,0,0]
    var gotScore = 0
    var messageValue = 0
    var numArray = [0,0,0,0]
    var player3:AVAudioPlayer?
    
    struct DiceValue
    {
        var dice1 = 0
        var dice2 = 0
        var dice3 = 0
        var dice4 = 0
        var diceScore = 0
        var msgValue = 0
    }
    var playerDiceValue:[DiceValue] =
    [
        DiceValue(dice1: 0, dice2: 0, dice3: 0, dice4: 0, diceScore: 0 ,msgValue: 0),
        DiceValue(dice1: 0, dice2: 0, dice3: 0, dice4: 0, diceScore: 0 ,msgValue: 0),
        DiceValue(dice1: 0, dice2: 0, dice3: 0, dice4: 0, diceScore: 0 ,msgValue: 0),
        DiceValue(dice1: 0, dice2: 0, dice3: 0, dice4: 0, diceScore: 0 ,msgValue: 0)
    ]
    
    let stringDic:[Int:String] =
    [
        0:"",
        3:"擲出 BiGi 有夠慘",
        333:"三個骰子相同，再擲一次",
        6666:"擲出 豹子!! 通殺",
        1234:"骰子都不同，再擲一次"
    ]
    
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
    
    @IBAction func tintAdjustSlide(_ sender: UISlider)
    {
        tintValueLabel.text = String(Int(sender.value * 255))
        
        backImageView
    }
    
    @IBAction func playerSegment(_ sender: UISegmentedControl)
    {
        playerNameTextField.text = playerNameArray[sender.selectedSegmentIndex]
        whichPlayer = sender.selectedSegmentIndex
        updateUI()
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
        if soundSwitch.isOn == true
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
                messageValue = 3
                // "擲出 BiGi 有夠慘"
            }
            else
            {
                messageValue = 0
            }
            gotScore = getNumOne+getNumTwo
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
                gotScore = getNumOne+getNumOne
            }
            else
            {
                gotScore = eyeNum+eyeNum
            }
            messageValue = 0
        }
        else if eyeCount == 3
        {
            messageValue = 333
            gotScore = 0
            // "三個骰子相同，再擲一次"
        }
        else if eyeCount == 6
        {
            // 豹子
            getNumOne = numArray[0]
            getNumTwo = numArray[0]
            gotScore = getNumOne+getNumTwo

            messageValue = 6666
            // "擲出 豹子!! 通殺"
        }
        else
        {
            messageValue = 1234
            gotScore = 0
            // "骰子都不同，再擲一次"
        }
    }
    
    func updateUI()
    {
        playerLabel.text = playerNameTextField.text! + " 擲出"
        playMessageLabel.text = stringDic[playerDiceValue[whichPlayer].msgValue]
        
        scoreLabel.text = String(playerDiceValue[whichPlayer].diceScore)

        diceValueImgView[0].image = UIImage(named: "dice"+String(playerDiceValue[whichPlayer].dice1))
        diceValueImgView[1].image = UIImage(named: "dice"+String(playerDiceValue[whichPlayer].dice2))
        diceValueImgView[2].image = UIImage(named: "dice"+String(playerDiceValue[whichPlayer].dice3))
        diceValueImgView[3].image = UIImage(named: "dice"+String(playerDiceValue[whichPlayer].dice4))
    }
    
    
    @IBAction func onPlay(_ sender: UIButton)
    {
        for i in 0...3
        {
            numArray[i] = Int.random(in: 1...6)
            diceValueImgView[i].image = UIImage(named: "dice"+String(numArray[i]))
            switch i
            {
                case 0:
                    playerDiceValue[whichPlayer].dice1 = numArray[i]
                case 1:
                    playerDiceValue[whichPlayer].dice2 = numArray[i]
                case 2:
                    playerDiceValue[whichPlayer].dice3 = numArray[i]
                case 3:
                    playerDiceValue[whichPlayer].dice4 = numArray[i]
                default:
                    print("out of range")
            }
        }
        
        doCount(numArray)   // 計算點數放進gotScore，顯示訊息index放進messageValue
        playerDiceValue[whichPlayer].diceScore = gotScore   // 記錄玩家分數
        playerDiceValue[whichPlayer].msgValue = messageValue
        
        // print score
        if gotScore == 0
        {
            scoreLabel.text = ""
        }
        else
        {
            scoreLabel.text = String(gotScore)
            playerLabel.text = playerLabel.text! + " \(gotScore) 點"
        }
    }
}

