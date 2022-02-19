//
//  ViewController.swift
//  2048 Test
//
//  Created by Иван Зайцев on 31.01.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainView: UIView!
    
    var brain = Brain(labels: [2,64,128,2048])
    override func viewDidLoad() {
        print(UIScreen.main.bounds.size.width)
        super.viewDidLoad()
        for i in 1...4 {
            if brain.data[4][i] != nil {
                mainView.addSubview(brain.data[4][i]!.view)
            }
        }

        let rightGestureRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(rightGestureFired(_:)))
        let leftGestureRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(leftGestureFired(_:)))
        let upGestureRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(upGestureFired(_:)))
        let downGestureRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(downGestureFired(_:)))
        rightGestureRecogniser.direction = .right
        leftGestureRecogniser.direction = .left
        upGestureRecogniser.direction = .up
        downGestureRecogniser.direction = .down
        mainView.addGestureRecognizer(rightGestureRecogniser)
        mainView.addGestureRecognizer(leftGestureRecogniser)
        mainView.addGestureRecognizer(upGestureRecogniser)
        mainView.addGestureRecognizer(downGestureRecogniser)
        mainView.isUserInteractionEnabled = true
    }
    
    @objc func upGestureFired(_ gesture: UISwipeGestureRecognizer) {
        brain.completedVerticalMoveMethod(view: mainView, sign: -1)
    }
    @objc func downGestureFired(_ gesture: UISwipeGestureRecognizer) {
        brain.completedVerticalMoveMethod(view: mainView, sign: 1)
    }
    @objc func leftGestureFired(_ gesture: UISwipeGestureRecognizer) {
        brain.completedHorizontalMoveMethod(view: mainView, sign: -1)
    }
    @objc func rightGestureFired(_ gesture: UISwipeGestureRecognizer) {
        //‼️метод из брейна который все двигает и берет на вход вью
        brain.completedHorizontalMoveMethod(view: mainView, sign: +1)
//        print(brain.data)
        
    }
}
