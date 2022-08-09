//
//  Player2ViewController.swift
//  sibala
//
//  Created by jemiway on 2022/8/8.
//

import UIKit


class Player2ViewController: UIViewController
{
   
    @IBOutlet weak var p2PlayerNameTextField: UITextField!
    @IBOutlet weak var p2PlayerLabel: UILabel!
    @IBOutlet weak var p2PlayMessageLabel: UILabel!
    
    @IBOutlet weak var p2NumImageView1: UIImageView!
    @IBOutlet weak var p2NumImageView2: UIImageView!
    @IBOutlet weak var p2NumImageView3: UIImageView!
    @IBOutlet weak var p2NumImageView4: UIImageView!

    @IBOutlet weak var p2ScoreLabel: UITextField!
    
    var firstVC:ViewController?
    var numArray = [0,0,0,0]
    var p2GetScore = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        print(p2GetScore)
    }
    
    @IBAction func onPlay(_ sender: Any)
    {
        
        self.numArray[0] = Int.random(in: 1...6)
        self.numArray[1] = Int.random(in: 1...6)
        self.numArray[2] = Int.random(in: 1...6)
        self.numArray[3] = Int.random(in: 1...6)
    
        self.p2NumImageView1.image = UIImage(named: "dice"+String(self.numArray[0]))
        self.p2NumImageView2.image = UIImage(named: "dice"+String(self.numArray[1]))
        self.p2NumImageView3.image = UIImage(named: "dice"+String(self.numArray[2]))
        self.p2NumImageView4.image = UIImage(named: "dice"+String(self.numArray[3]))

        p2PlayerLabel.text = p2PlayerNameTextField.text! + " 擲出"
        p2PlayMessageLabel.text = ""

        firstVC?.doCount(numArray)
       
        if let aNum = firstVC?.getScore
        {
            p2GetScore = aNum
        }
        
        p2PlayMessageLabel.text = firstVC?.stringDic[firstVC!.messageNum]
        
        // print score
        if p2GetScore == 0
        {
            p2ScoreLabel.text = ""
        }
        else
        {
            p2ScoreLabel.text = String(p2GetScore)
            p2PlayerLabel.text = p2PlayerLabel.text! + " " + String(p2GetScore) + " 點"
        }
    }

    @IBAction func p2ReturnBack(_ sender: Any)
    {
        view.endEditing(true)
    }
    
    @IBAction func moveToPlayer3(_ sender: UISwipeGestureRecognizer)
    {
        print("aaa")
        if let thridVC = self.storyboard?.instantiateViewController(withIdentifier: "Player3ViewController") as? Player3ViewController
        {
            print("bbb")
            thridVC.firstVC = self.firstVC
            self.present(thridVC, animated: true)
        }
    }
    @IBAction func moveToPlayer1(_ sender: UISwipeGestureRecognizer)
    {
        self.dismiss(animated: true)
        
//        self.navigationController?.popViewController(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

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
