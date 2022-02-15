//
//  ViewController.swift
//  2048 Test
//
//  Created by Иван Зайцев on 31.01.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainView: UIView!
    
    var brain = Brain(labels: [0,0,0,0])
//    var square1: Square? = Square(xPosition: 12, yPosition: 12, size: 78, color: .lightGray, label: "2")
//    var square2: Square? = Square(xPosition: 102, yPosition: 12, size: 78, color: .darkGray, label: "4")
//
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...3 {
            if brain.data[3][i] != nil {
                mainView.addSubview(brain.data[3][i]!.view)
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
    func moveOnePosition(square: Square, xDirection: Int, yDirection: Int) {
        square.xPosition += xDirection
        square.yPosition += yDirection
        UIView.animate(withDuration: 0.08) {
            square.view.frame = CGRect(x: 12 + square.xPosition*90, y: 12 + square.yPosition*90, width: square.size, height: square.size)
        }
        
    }
    func moveAll(square: Square) {
        UIView.animate(withDuration: 0.2) {
            square.view.frame = CGRect(x: 12 + square.xPosition*90, y: 12 + square.yPosition*90, width: square.size, height: square.size)
        }
        
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func deleteButton(_ sender: UIButton) {
    }
    @IBAction func leftButton(_ sender: UIButton) {
//        move(square: brain.date[0][0]!, xDirection: -1, yDirection: 0)
    }
    
    @IBAction func rightButton(_ sender: UIButton) {
//        move(square: brain.date[0][0]!, xDirection: +1, yDirection: 0)
    }
    
    
    @objc func upGestureFired(_ gesture: UISwipeGestureRecognizer) {
//        move(square: brain.date[0][0]!, xDirection: 0, yDirection: -1)
    }
    @objc func downGestureFired(_ gesture: UISwipeGestureRecognizer) {
//        move(square: brain.date[0][0]!, xDirection: 0, yDirection: 1)
    }
    @objc func leftGestureFired(_ gesture: UISwipeGestureRecognizer) {
//        move(square: brain.date[0][0]!, xDirection: -1, yDirection: 0)
    }
    @objc func rightGestureFired(_ gesture: UISwipeGestureRecognizer) {
//        move(square: brain.date[0][0]!, xDirection: 1, yDirection: 0)
        
        //‼️метод из брейна который все двигает и берет на вход вью
        brain.completedMoveMethod(view: mainView)
       
//        brain.date[3][0] = nil
//        print(brain.date[3][3]!.color)
//        print(brain.date[3].map{$0 == nil})
//        print(brain.date[3][1]!.color, brain.date[3][3]!.color )
        
    }
}








//// удали того кто просуммировался
//if brain.data[3][5] != nil {
//    brain.data[3][5]!.view.removeFromSuperview()
//    brain.data[3][5] = nil
//}
//if brain.data[3][6] != nil {
//    brain.data[3][6]!.view.removeFromSuperview()
//    brain.data[3][6] = nil
//}
//// тут пересчитываются координаты квадратов
////        let indexOfWhoLabelMultByTwo = brain.moveRowRight(view: mainView)
//
//// обнови положение квадратов
//for i in 0...6 {
//    if brain.data[3][i] != nil {
//        moveAll(square: brain.data[3][i]!)
//    }
//}
//// удвой числа если была сумма
//if brain.data[3][5] != nil {
//    brain.data[3][brain.data[3][5]!.xPosition]!.view.text = "\(brain.data[3][5]!.label*2)"
//    brain.data[3][brain.data[3][5]!.xPosition]!.label = (brain.data[3][5]!.label*2)
//
//}
//if brain.data[3][6] != nil {
//    brain.data[3][brain.data[3][6]!.xPosition]!.view.text = "\(brain.data[3][6]!.label*2)"
//    brain.data[3][brain.data[3][6]!.xPosition]!.label = (brain.data[3][6]!.label*2)
//
//}
//
//
//brain.generate(view: mainView)
//print(brain.data[3].map{$0 == nil})
//print("count of subviews is \(mainView.subviews.count)")
