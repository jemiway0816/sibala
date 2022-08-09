//
//  Player3ViewController.swift
//  sibala
//
//  Created by jemiway on 2022/8/8.
//

import UIKit

var p3NumArray = [0,0,0,0]
var p3GetScore = 0

class Player3ViewController: UIViewController
{
    var firstVC:ViewController?
    
    @IBOutlet weak var p3PlayerNameTextField: UITextField!
    @IBOutlet weak var p3PlayerLabel: UILabel!
    @IBOutlet weak var p3PlayMessageLabel: UILabel!

    @IBOutlet weak var p3NumImageView1: UIImageView!
    @IBOutlet weak var p3NumImageView2: UIImageView!
    @IBOutlet weak var p3NumImageView3: UIImageView!
    @IBOutlet weak var p3NumImageView4: UIImageView!
    
    @IBOutlet weak var p3ScoreLabel: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        print(p3GetScore)
        p3ScoreLabel.text = String(p3GetScore)
        showDice()
    }
    
    func getDice()
    {
        p3NumArray[0] = Int.random(in: 1...6)
        p3NumArray[1] = Int.random(in: 1...6)
        p3NumArray[2] = Int.random(in: 1...6)
        p3NumArray[3] = Int.random(in: 1...6)
    }
    func showDice()
    {
        p3NumImageView1.image = UIImage(named:"dice"+String(p3NumArray[0]))
        p3NumImageView2.image = UIImage(named: "dice"+String(p3NumArray[1]))
        p3NumImageView3.image = UIImage(named: "dice"+String(p3NumArray[2]))
        p3NumImageView4.image = UIImage(named: "dice"+String(p3NumArray[3]))
    }
    
    
    @IBAction func onPlay(_ sender: Any)
    {
        getDice()
        showDice()

        p3PlayerLabel.text = p3PlayerNameTextField.text! + " 擲出"
        p3PlayMessageLabel.text = ""

        firstVC?.doCount(p3NumArray)
       
        if let aNum = firstVC?.getScore
        {
            p3GetScore = aNum
        }
        else
        {
            p3GetScore = 0
        }
        
        p3PlayMessageLabel.text = firstVC?.stringDic[firstVC!.messageNum]
        
        // print score
        if p3GetScore == 0
        {
            p3ScoreLabel.text = ""
        }
        else
        {
            p3ScoreLabel.text = String(p3GetScore)
            p3PlayerLabel.text = p3PlayerLabel.text! + " " + String(p3GetScore) + " 點"
        }
    }
    
    @IBAction func p3ReturnBack(_ sender: Any)
    {
        view.endEditing(true)
    }
    
    
    @IBAction func moveToPlayer2(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
