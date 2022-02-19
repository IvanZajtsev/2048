//
//  ViewController.swift
//  2048 Test
//
//  Created by Иван Зайцев on 31.01.2022.
//

import UIKit

class ViewController: UIViewController {
    func showConnectionAlert() {
        let alert = UIAlertController(title: "Передача данных выключена", message: "Для доступа к данным включите передачу данных по сотовой сети или используйте WI-FI. Затем перейдите на первый экран и потяните для обновления или выберите другую группу акций.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {action in
        }))
        present(alert, animated:  true)
    }
    
    @IBOutlet weak var mainView: UIView!
    let fieldSquareColor = UIColor(displayP3Red: 204/255, green: 193/255, blue: 183/255, alpha: 1)

    var brain = Brain(labels: [0,0,0,0])
    override func viewDidLoad() {
        print(UIScreen.main.bounds.size.width)
        super.viewDidLoad()
        //[Int(i / 4) + 1][i % 4 + 1]
        for i in 0...15 {
            let view = UIView(frame: CGRect(x: 0.0268 * UIScreen.main.bounds.size.width + brain.Multy * CGFloat(Int(i / 4)),
                                            y: 0.0268 * UIScreen.main.bounds.size.width + brain.Multy * CGFloat((i % 4)),
                                            width: (0.1946 * UIScreen.main.bounds.size.width),
                                            height: (0.1946 * UIScreen.main.bounds.size.width)))
            view.backgroundColor = fieldSquareColor
            view.layer.cornerRadius = 7
            mainView.addSubview(view)
        }
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
        brain.generate(view: mainView)
    }
    func showAlert() {
        if brain.gameIsOver == true {
            let alert = UIAlertController(title: "Game is over :(", message: "Press restart", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart", style: .cancel, handler: {action in
                self.brain.gameIsOver = false
                for i in 1...7 {
                    for j in 1...7 {
                        if i != 5 && j != 5 {
                            self.brain.data[j][i]?.view.removeFromSuperview()
                            self.brain.data[j][i] = nil
    //                        moveAll(square: <#T##Square#>)
                        }
                    }
                }
                self.brain.anythingWasMoved = true
                self.brain.generate(view: self.mainView)
            }))
            present(alert, animated:  true)
            
        }
    }
    
    @objc func upGestureFired(_ gesture: UISwipeGestureRecognizer) {
        brain.completedVerticalMoveMethod(view: mainView, sign: -1)
        showAlert()
    }
    @objc func downGestureFired(_ gesture: UISwipeGestureRecognizer) {
        brain.completedVerticalMoveMethod(view: mainView, sign: 1)
        showAlert()
    }
    @objc func leftGestureFired(_ gesture: UISwipeGestureRecognizer) {
        brain.completedHorizontalMoveMethod(view: mainView, sign: -1)
        showAlert()
    }
    @objc func rightGestureFired(_ gesture: UISwipeGestureRecognizer) {
        //‼️метод из брейна который все двигает и берет на вход вью
        brain.completedHorizontalMoveMethod(view: mainView, sign: +1)
        showAlert()
//        print(brain.data)
        
    }
}
