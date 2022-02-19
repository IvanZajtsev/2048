//
//  Brain.swift
//  2048 Test
//
//  Created by Иван Зайцев on 03.02.2022.
//

import Foundation
import UIKit

class Brain {
    var data: [[Square?]] = (0...7).map{ _ in [Square?](repeating: nil, count: 8) }
//    let widthOfPlayGround = UIScreen.main.bounds.size.width
    init(labels: [Int]) {
//        for i in 0...3 {
//            if labels[i] == 0 {
//                data[4][i+1] = nil
//            } else {
//                data[4][i+1] = Square(xPosition: i + 1, yPosition: 4, size: 78, color: .orange, label: labels[i])
//            }
//        }
        data[4][5] = Square(xPosition: 5, yPosition: 4, size: 78, color: .blue, label: 7)
        //граничный квадрат справа
        data[4][0] = Square(xPosition: 0, yPosition: 4, size: 78, color: .blue, label: 7)
        // граничный квадрат слева
        data[3][5] = Square(xPosition: 5, yPosition: 3, size: 78, color: .blue, label: 7)
        //граничный квадрат справа
        data[3][0] = Square(xPosition: 0, yPosition: 3, size: 78, color: .blue, label: 7)
        // граничный квадрат слева
        data[2][5] = Square(xPosition: 5, yPosition: 2, size: 78, color: .blue, label: 7)
        //граничный квадрат справа
        data[2][0] = Square(xPosition: 0, yPosition: 2, size: 78, color: .blue, label: 7)
        // граничный квадрат слева
        data[1][5] = Square(xPosition: 5, yPosition: 1, size: 78, color: .blue, label: 7)
        //граничный квадрат справа
        data[1][0] = Square(xPosition: 0, yPosition: 1, size: 78, color: .blue, label: 7)
        //________________________
        // граничный квадрат слева
        data[0][1] = Square(xPosition: 1, yPosition: 0, size: 78, color: .blue, label: 7)
        //граничный квадрат справа
        data[0][2] = Square(xPosition: 2, yPosition: 0, size: 78, color: .blue, label: 7)
        // граничный квадрат слева
        data[0][3] = Square(xPosition: 3, yPosition: 0, size: 78, color: .blue, label: 7)
        //граничный квадрат справа
        data[0][4] = Square(xPosition: 4, yPosition: 0, size: 78, color: .blue, label: 7)
        // граничный квадрат слева
        data[5][1] = Square(xPosition: 1, yPosition: 5, size: 78, color: .blue, label: 7)
        //граничный квадрат справа
        data[5][2] = Square(xPosition: 2, yPosition: 5, size: 78, color: .blue, label: 7)
        // граничный квадрат слева
        data[5][3] = Square(xPosition: 3, yPosition: 5, size: 78, color: .blue, label: 7)
        //граничный квадрат справа
        data[5][4] = Square(xPosition: 4, yPosition: 5, size: 78, color: .blue, label: 7)
        // граничный квадрат слева
    }
    
    func completedHorizontalMoveMethod (view: UIView, sign: Int) {
        // удали того кто просуммировался
        for i in 1...4 {
            if  data[i][6] != nil {
                data[i][6]!.view.removeFromSuperview()
                data[i][6] = nil
            }
            if  data[i][7] != nil {
                data[i][7]!.view.removeFromSuperview()
                data[i][7] = nil
            }
        }
        for j in 1...4 {
            if  data[6][j] != nil {
                data[6][j]!.view.removeFromSuperview()
                data[6][j] = nil
            }
            if  data[7][j] != nil {
                data[7][j]!.view.removeFromSuperview()
                data[7][j] = nil
            }
        }
        // тут пересчитываются координаты квадратов
        //‼️
        moveRowHorizontal(view: view, plusMinus: sign)
        //‼️
        // тут меняется картинка положение квадратов
        for i in 0...7 {
            for j in 0...7 {
                if data[j][i] != nil {
                    moveAll(square: data[j][i]!)
                }
            }
        }
        // удвой числа если была сумма
        for i in 1...4 {
            if data[i][6] != nil {
                data[i][data[i][6]!.xPosition]!.view.text = "\(data[i][6]!.label*2)"
                data[i][data[i][6]!.xPosition]!.label = (data[i][6]!.label*2)
                
            }
            if data[i][7] != nil {
                data[i][data[i][7]!.xPosition]!.view.text = "\(data[i][7]!.label*2)"
                data[i][data[i][7]!.xPosition]!.label = (data[i][7]!.label*2)
                
            }
        }
        
        
        generate(view: view)
        for i in 0...7 {
            print(data[i].map{($0 == nil) ? "⬜️" : "🅰️"})
        }
        print("count of subviews is \(view.subviews.count)")
        

    }
    func completedVerticalMoveMethod (view: UIView, sign: Int) {
        // удали того кто просуммировался
        for i in 1...4 {
            if  data[i][6] != nil {
                data[i][6]!.view.removeFromSuperview()
                data[i][6] = nil
            }
            if  data[i][7] != nil {
                data[i][7]!.view.removeFromSuperview()
                data[i][7] = nil
            }
        }
        for j in 1...4 {
            if  data[6][j] != nil {
                data[6][j]!.view.removeFromSuperview()
                data[6][j] = nil
            }
            if  data[7][j] != nil {
                data[7][j]!.view.removeFromSuperview()
                data[7][j] = nil
            }
        }
        // тут пересчитываются координаты квадратов
        //‼️
        moveRowVertical(view: view, plusMinus: sign)
        //‼️
        // тут меняется картинка положение квадратов
        for i in 0...7 {
            for j in 0...7 {
                if data[j][i] != nil {
                    moveAll(square: data[j][i]!)
                }
            }
        }
        //удвой числа если была сумма
        for j in 1...4 {
            if data[6][j] != nil {
                data[data[6][j]!.yPosition][j]!.view.text = "\(data[6][j]!.label*2)"
                data[data[6][j]!.yPosition][j]!.label = (data[6][j]!.label*2)
                
            }
            if data[7][j] != nil {
                data[data[7][j]!.yPosition][j]!.view.text = "\(data[7][j]!.label*2)"
                data[data[7][j]!.yPosition][j]!.label = (data[7][j]!.label*2)
                
            }
        }
        
        
        generate(view: view)
        for i in 0...7 {
            print(data[i].map{($0 == nil) ? "⬜️" : "🅰️"})
        }
        print("count of subviews is \(view.subviews.count)")
        
        
    }
    
    let Multy = (0.1964+0.0268) * UIScreen.main.bounds.size.width
    //(widthOfPlayGround*0.0268 + (square.yPosition - 1)*(0.1964+0.0268)*widthOfPlayGround)
    func calcNewPos(square: Square) ->[CGFloat]{
        let Multy = (0.1964+0.0268) * UIScreen.main.bounds.size.width
        let x = 0.0268 * UIScreen.main.bounds.size.width + Multy * (CGFloat(square.xPosition) - 1.0)
        let y = 0.0268 * UIScreen.main.bounds.size.width + Multy * (CGFloat(square.yPosition) - 1.0)
        return [x,y]
    }
    func moveAll(square: Square) {
        
        UIView.animate(withDuration: 0.1) {
//            square.view.frame = CGRect(x: , y: widthOfPlayGround*0.0268 + (square.yPosition - 1)*(0.1964+0.0268)*widthOfPlayGround, width: square.size, height: square.size)
//            square.view.frame = CGRect(x: self.calcNewPos(square: square)[0], y: self.calcNewPos(square: square)[1] , width: square.size, height: square.size)
            square.view.frame = CGRect(x: self.calcNewPos(square: square)[0], y: self.calcNewPos(square: square)[1], width: CGFloat(square.size), height: CGFloat(square.size))
        }
        
    }
    
    
    
    func moveRowHorizontal(view: UIView, plusMinus: Int) { // подготовка перемещений
        for i in ((plusMinus == 1) ? stride(from: 4, through: 1, by: -1)  : stride(from: 1, through: 4, by: 1)  ) {
//            if (data[3][i] != nil) {
//                print("neighbour was \((data[3][i+1...5].first(where: {$0 != nil})!)!.view.text!)")
//            }
            moveForSumHorizontal(fromPosition: i, view: view, LorR: plusMinus)
            moveOrNotHorizontal(fromPosition: i, LorR: plusMinus)
        }
    }
    func moveRowVertical(view: UIView, plusMinus: Int) { // подготовка перемещений
        for j in ((plusMinus == 1) ? stride(from: 4, through: 1, by: -1)  : stride(from: 1, through: 4, by: 1)  ) {
//            if (data[3][i] != nil) {
//                print("neighbour was \((data[3][i+1...5].first(where: {$0 != nil})!)!.view.text!)")
//            }
            moveForSumVertical(fromPosition: j, view: view, UorD: plusMinus)
            moveOrNotVertical(fromPosition: j, UorD: plusMinus)
        }
    }
    
    
    // если сосед готов к сумме, тогда эта функция
    func moveForSumHorizontal(fromPosition i: Int, view: UIView, LorR: Int) {
        for j in 1...4 {
            //надо вот тут зашить проверку на готовность к сумме
            let neighbour = (LorR == 1) ? data[j][i+1...5].first(where: {$0 != nil}) : data[j][0...i-1].last(where: {$0 != nil})
            if let mySquare = data[j][i] {
//                print("neighbour label is \((neighbour!)!.label), my label is \(mySquare.label)")
                if ((neighbour!)!.label == mySquare.label) {             // если мы готовы к сумме
                    if ((i == 1 && LorR == 1) || (i == 4 && LorR == -1)) {
                        mySquare.xPosition = (neighbour!)!.xPosition
                        (neighbour!)!.label = 999
                        data[j][7] = mySquare
                        
                        //                    date[3][i]!.color = .blue
                        mySquare.color = .blue
                        
                        data[j].remove(at: i)
                        data[j].insert(nil, at: i)
//                        print("check \(mySquare.xPosition)")
                    } else {
                        mySquare.xPosition = (neighbour!)!.xPosition
                        (neighbour!)!.label = 999
                        data[j][6] = mySquare
                        data[j].remove(at: i)
                        data[j].insert(nil, at: i)
                    }
                    view.bringSubviewToFront(data[j][mySquare.xPosition]!.view)
                }
            }
        }
    }
    
    func moveForSumVertical(fromPosition j: Int, view: UIView, UorD: Int) {
        for i in 1...4 {
            //надо вот тут зашить проверку на готовность к сумме
//            print("j = " + "\(j)" + "i = " + "\(i)")
            let column = [data[0][i], data[1][i], data[2][i], data[3][i], data[4][i], data[5][i] ]
            let neighbour = (UorD == 1) ? column[j+1...5].first(where: {$0 != nil}) : column[0...j-1].last(where: {$0 != nil})
            if let mySquare = data[j][i] {
                print("neighbour label is \((neighbour!)!.label), my label is \(mySquare.label)")
                if ((neighbour!)!.label == mySquare.label) {             // если мы готовы к сумме
                    if ((j == 1 && UorD == 1) || (j == 4 && UorD == -1)) {
                        mySquare.yPosition = (neighbour!)!.yPosition
                        (neighbour!)!.label = 999
                        data[7][i] = mySquare
                        
                        //                    date[3][i]!.color = .blue
                        mySquare.color = .blue
                        
                        data[j].remove(at: i)
                        data[j].insert(nil, at: i)
//                        print("check \(mySquare.yPosition)")
                    } else {
                        mySquare.yPosition = (neighbour!)!.yPosition
                        print("(neighbour!)!.yPosition =" + "\((neighbour!)!.yPosition)")
                        mySquare.color = .blue
                        (neighbour!)!.label = 999
                        data[6][i] = mySquare
                        print("mySquare.ypos = \(mySquare.yPosition)")
                        data[j].remove(at: i)
                        data[j].insert(nil, at: i)
                    }
                    view.bringSubviewToFront(data[mySquare.yPosition][i]!.view)
                }
            }
        }
    }
    
    
    func moveOrNotHorizontal(fromPosition i: Int, LorR: Int) {
        for j in 1...4 {
            // мы должны быть не nil
            //найти соседа
            let neighbour = (LorR == 1) ? data[j][i+1...5].first(where: {$0 != nil}) : data[j][0...i-1].last(where: {$0 != nil})

            //вычислить колво свободных клеток до него
            if let mySquare = data[j][i] {
//                print("вошли в moveOrNot \(mySquare.label)")
                let distance = abs((neighbour!)!.xPosition - mySquare.xPosition)
                mySquare.xPosition += (distance - 1) * LorR //обновили позицию на экране
                if (distance > 1) {
                    data[j][mySquare.xPosition] = mySquare   // переложили view в массиве в новое место
                    // удали только если это не суммирование перемещение
                    data[j].remove(at: i)
                    data[j].insert(nil, at: i)
                }
                // картинка пока  не переехала а массив обновился
                // картинка обновится когда мы сделаем свайп
            } else {
                // мы нил? лол
            }
            
            //переместиться на колво своб клеток (даже если их ноль)
            //если клеток было не ноль, то удалить вставить в массиве
        }
    }
    func moveOrNotVertical(fromPosition j: Int, UorD: Int) {
        //работаем по столбцам
        for i in 1...4 {
            // мы должны быть не nil
            //найти соседа
            let column = [data[0][i], data[1][i], data[2][i], data[3][i], data[4][i], data[5][i] ]
            let neighbour = (UorD == 1) ? column[j+1...5].first(where: {$0 != nil}) : column[0...j-1].last(where: {$0 != nil})
            //вычислить колво свободных клеток до него
            if let mySquare = data[j][i] {
                let distance = abs((neighbour!)!.yPosition - mySquare.yPosition)
                mySquare.yPosition += (distance - 1) * UorD //обновили позицию на экране
                if (distance > 1) {
                    data[mySquare.yPosition][i] = mySquare   // переложили view в массиве в новое место
                    // удали только если это не суммирование перемещение
                    data[j].remove(at: i)
                    data[j].insert(nil, at: i)
                }
                // картинка пока  не переехала а массив обновился
                // картинка обновится когда мы сделаем свайп
            } else {
                // мы нил? лол
            }
            
            //переместиться на колво своб клеток (даже если их ноль)
            //если клеток было не ноль, то удалить вставить в массиве
        }
    }
    func generate(view: UIView) {
        var countOfNil = 0
        for i in 0...15 {
            if (data[Int(i / 4) + 1][i % 4 + 1] == nil) {
                countOfNil += 1
            }
        }
        let randomPosition = Int.random(in: 1...countOfNil)
        countOfNil = 0
        for i in 0...15 {
            if (data[Int(i / 4) + 1][i % 4 + 1] == nil) {
                countOfNil += 1
                if (countOfNil == randomPosition) {
                    data[Int(i / 4) + 1][i % 4 + 1] = Square(xPosition: i % 4 + 1, yPosition: Int(i / 4)  + 1, size: (0.1946 * UIScreen.main.bounds.size.width), color: .red, label: 2)
                    view.addSubview(data[Int(i / 4) + 1][i % 4 + 1]!.view)
                }
            }
            
        }
    }
}
