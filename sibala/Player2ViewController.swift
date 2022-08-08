//
//  Player2ViewController.swift
//  sibala
//
//  Created by jemiway on 2022/8/8.
//

import UIKit

class Player2ViewController: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
}

    @IBAction func moveToPlayer1(_ sender: UISwipeGestureRecognizer)
    {
        self.dismiss(animated: true)
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
