//
//  ViewController.swift
//  sibala
//
//  Created by jemiway on 2022/8/7.
//

import UIKit
import AVFoundation

var soundOnOff = 0

class ViewController: UIViewController {

    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playMessageLabel: UILabel!

    @IBOutlet var diceValueImgView: [UIImageView]!
    
    @IBOutlet weak var playerNumLabel: UILabel!
    @IBOutlet weak var scoreLabel: UITextField!
    
    @IBOutlet weak var playerOletSegment: UISegmentedControl!
    @IBOutlet weak var tintValueLabel: UILabel!
    
    @IBOutlet weak var mainBackImageView: UIImageView!
    @IBOutlet weak var adjustBackImageView: UIImageView!
    
    var whichPlayer = 0         // 現在是哪個玩家 0 1 2 3
    var playerNameArray:[String] = ["John","Mary","Tom","Amy"]      // 預設玩家名
    var gotScore = 0
    var messageValue = 0
    var numArray = [0,0,0,0]
    var mp3Player:AVAudioPlayer?
    var backTint:Float = 1
    
    // 每個玩家骰子點數與訊息的結構
    struct DiceValue
    {
        var diceArray:[Int] = [0,0,0,0]
        var diceScore = 0
        var msgValue = 0
    }
    
    // 玩家資訊的陣列
    var playerDiceValue:[DiceValue] =
    [
        DiceValue(diceArray: [0,0,0,0], diceScore: 0, msgValue: 0),
        DiceValue(diceArray: [0,0,0,0], diceScore: 0, msgValue: 0),
        DiceValue(diceArray: [0,0,0,0], diceScore: 0, msgValue: 0),
        DiceValue(diceArray: [0,0,0,0], diceScore: 0, msgValue: 0)
    ]
    
    // 顯示訊息字典
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
    
        // 載入聲音
        if let url = Bundle.main.url(forResource: "骰子聲", withExtension: "mp3")
        {
            mp3Player = try? AVAudioPlayer(contentsOf: url)
        }
    }
    
    @IBAction func soundSwitch(_ sender: UISwitch)
    {
        if sender.isOn == true
        {
            soundOnOff = 1
        }
        else
        {
            soundOnOff = 0
        }
    }
    
    @IBAction func tintAdjustSlide(_ sender: UISlider)
    {
        // 調整背景圖透明度
        tintValueLabel.text = String(Int(sender.value * 255))
        adjustBackImageView.alpha = CGFloat(sender.value)
        backTint = sender.value
    }
    
    @IBAction func playerSegment(_ sender: UISegmentedControl)
    {
        // 切換玩家
        playerNameTextField.text = playerNameArray[sender.selectedSegmentIndex]
        whichPlayer = sender.selectedSegmentIndex
        updateUI()
    }
    
    @IBAction func returnTextField(_ sender: Any)
    {
        // 更改玩家名
        playerNameArray[whichPlayer] = playerNameTextField.text!
        view.endEditing(true)
    }
       
    func doCount(_ numArray:[Int])
    {
        var eyeCount = 0;
        var eyeNum = 0;
        var getNumOne = 0;
        var getNumTwo = 0;
        
        if soundOnOff == 1
        {
//            print("play mp3")
            mp3Player?.play()
        }
        
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
        // 顯示訊息
        playerLabel.text = playerNameTextField.text! + " 擲出 \(playerDiceValue[whichPlayer].diceScore) 點"
        playMessageLabel.text = stringDic[playerDiceValue[whichPlayer].msgValue]
        
        if playerDiceValue[whichPlayer].diceScore == 0
        {
            scoreLabel.text = ""
        }
        else
        {
            // 顯示骰子點數
            scoreLabel.text = String(playerDiceValue[whichPlayer].diceScore)
        }
        
        for i in 0...3
        {
            // 更換四顆骰子的點數圖片
            diceValueImgView[i].image = UIImage(named: "dice"+String(playerDiceValue[whichPlayer].diceArray[i]))
        }
    }
    
    @IBAction func onPlay(_ sender: UIButton)
    {
        for i in 0...3
        {
            numArray[i] = Int.random(in: 1...6)
            playerDiceValue[whichPlayer].diceArray[i] = numArray[i]         // 儲存骰子點數
        }
        
        doCount(numArray)   // 計算點數放進gotScore，顯示訊息index放進messageValue
        playerDiceValue[whichPlayer].diceScore = gotScore       // 記錄玩家分數
        playerDiceValue[whichPlayer].msgValue = messageValue    // 記錄顯示訊息
        updateUI()
    }
}

