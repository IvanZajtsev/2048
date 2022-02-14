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
            if brain.date[3][i] != nil {
                mainView.addSubview(brain.date[3][i]!.view)
            }
        }
//        mainView.addSubview(brain.date[0][0]!.view)
//        mainView.addSubview(brain.date[0][1]!.view)
//        mainView.addSubview(brain.date[3][0]!.view)
//        mainView.addSubview(brain.date[3][1]!.view)
//        mainView.addSubview(brain.date[3][2]!.view)
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
    func move(square: Square, xDirection: Int, yDirection: Int) {
        square.xPosition += xDirection
        square.yPosition += yDirection
        UIView.animate(withDuration: 0.08) {
            square.view.frame = CGRect(x: 12 + square.xPosition*90, y: 12 + square.yPosition*90, width: square.size, height: square.size)
        }
        
    }
    func moveNotButtons(square: Square) {
        UIView.animate(withDuration: 0.2) {
            square.view.frame = CGRect(x: 12 + square.xPosition*90, y: 12 + square.yPosition*90, width: square.size, height: square.size)
        }
        
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func deleteButton(_ sender: UIButton) {
//        brain.date[0][1]!.view.removeFromSuperview()
//        brain.date[0][1] = nil
        
        
//        var square3: Square? = Square(xPosition: 12, yPosition: 102, size: 78, color: .green, label: "8")
//        mainView.addSubview(brain.date[3][0]!.view)
        
        
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
        
        
        
        
        // удали того кто просуммировался
        if brain.date[3][5] != nil {
            brain.date[3][5]!.view.removeFromSuperview()
            brain.date[3][5] = nil
        }
        if brain.date[3][6] != nil {
            brain.date[3][6]!.view.removeFromSuperview()
            brain.date[3][6] = nil
        }
        // тут пересчитываются координаты квадратов
        let indexOfWhoLabelMultByTwo = brain.moveRowRight(view: mainView)
//        if brain.date[3][5] != nil {
//            mainView.bringSubviewToFront(brain.date[3][5]!.view)
//        }
//        if brain.date[3][6] != nil {
//            mainView.bringSubviewToFront(brain.date[3][6]!.view)
//        }
        // обнови положение квадратов
        for i in 0...6 {
            if brain.date[3][i] != nil {
                moveNotButtons(square: brain.date[3][i]!)
            }
        }
        if brain.date[3][5] != nil {
            brain.date[3][brain.date[3][5]!.xPosition]!.view.text = "\(brain.date[3][5]!.label*2)"
            brain.date[3][brain.date[3][5]!.xPosition]!.label = (brain.date[3][5]!.label*2)
            
        }
        if brain.date[3][6] != nil {
            brain.date[3][brain.date[3][6]!.xPosition]!.view.text = "\(brain.date[3][6]!.label*2)"
            brain.date[3][brain.date[3][6]!.xPosition]!.label = (brain.date[3][6]!.label*2)
            
        }
        
        //проверка на не нил!!!!!!!!!!!!!
       
        
        
        
//            print("index = \(indexOfWhoLabelMultByTwo)")
//            brain.date[3][indexOfWhoLabelMultByTwo]!.view.text = "\(brain.date[3][indexOfWhoLabelMultByTwo]!.label*2)"
//            brain.date[3][indexOfWhoLabelMultByTwo]!.label *= 2
//        }
        
        
        // а тут надо удалить те, которые просуммировались с кем-то
        
        brain.generate(view: mainView)
        print(brain.date[3].map{$0 == nil})
        print("count of subviews is \(mainView.subviews.count)")
        
//        brain.date[3][0] = nil
//        print(brain.date[3][3]!.color)
//        print(brain.date[3].map{$0 == nil})
//        print(brain.date[3][1]!.color, brain.date[3][3]!.color )
        
    }
}

