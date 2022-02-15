//
//  Brain.swift
//  2048 Test
//
//  Created by Иван Зайцев on 03.02.2022.
//

import Foundation
import UIKit

class Brain {
    var data: [[Square?]] = (0...3).map{ _ in [Square?](repeating: nil, count: 8) }
    
    init(labels: [Int]) {
        for i in 0...3 {
            if labels[i] == 0 {
                data[3][i+1] = nil
            } else {
                data[3][i+1] = Square(xPosition: i + 1, yPosition: 3, size: 78, color: .orange, label: labels[i])
            }
        }
        data[3][5] = Square(xPosition: 5, yPosition: 3, size: 78, color: .blue, label: 12345)
        //граничный квадрат справа
        data[3][0] = Square(xPosition: 0, yPosition: 3, size: 78, color: .blue, label: 12345)
        // граничный квадрат слева
        data[2][5] = Square(xPosition: 5, yPosition: 2, size: 78, color: .blue, label: 12345)
        //граничный квадрат справа
        data[2][0] = Square(xPosition: 0, yPosition: 2, size: 78, color: .blue, label: 12345)
        // граничный квадрат слева
        data[1][5] = Square(xPosition: 5, yPosition: 1, size: 78, color: .blue, label: 12345)
        //граничный квадрат справа
        data[1][0] = Square(xPosition: 0, yPosition: 1, size: 78, color: .blue, label: 12345)
        // граничный квадрат слева
        data[0][5] = Square(xPosition: 5, yPosition: 0, size: 78, color: .blue, label: 12345)
        //граничный квадрат справа
        data[0][0] = Square(xPosition: 0, yPosition: 0, size: 78, color: .blue, label: 12345)
        // граничный квадрат слева
    }
    
    func completedMoveMethod (view: UIView, sign: Int) {
        // удали того кто просуммировался
        for i in 0...3 {
            if  data[i][6] != nil {
                data[i][6]!.view.removeFromSuperview()
                data[i][6] = nil
            }
            if  data[i][7] != nil {
                data[i][7]!.view.removeFromSuperview()
                data[i][7] = nil
            }
        }
        // тут пересчитываются координаты квадратов
        //‼️
        moveRowRight(view: view, plusMinus: sign)
        //‼️
        // тут меняется картинка положение квадратов
        for i in 0...7 {
            for j in 0...3 {
                if data[j][i] != nil {
                    moveAll(square: data[j][i]!)
                }
            }
        }
        // удвой числа если была сумма
        for i in 0...3 {
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
        for i in 0...3 {
            print(data[i].map{$0 == nil})
        }
        print("count of subviews is \(view.subviews.count)")
        

    }
    func moveAll(square: Square) {
        UIView.animate(withDuration: 0.2) {
            square.view.frame = CGRect(x: 12 + (square.xPosition - 1)*90, y: 12 + square.yPosition*90, width: square.size, height: square.size)
        }
        
    }
    
    
    
    func moveRowRight(view: UIView, plusMinus: Int) { // подготовка перемещений
        for i in ((plusMinus == 1) ? stride(from: 4, through: 1, by: -1)  : stride(from: 1, through: 4, by: 1)  ) {
//            if (data[3][i] != nil) {
//                print("neighbour was \((data[3][i+1...5].first(where: {$0 != nil})!)!.view.text!)")
//            }
            moveForSum(fromPosition: i, view: view, LorR: plusMinus)
            moveOrNot(fromPosition: i, LorR: plusMinus)
        }
    }
    
    
    // если сосед готов к сумме, тогда эта функция
    func moveForSum(fromPosition i: Int, view: UIView, LorR: Int) {
        for j in 0...3 {
            //надо вот тут зашить проверку на готовность к сумме
            let neighbour = (LorR == 1) ? data[j][i+1...5].first(where: {$0 != nil}) : data[j][0...i-1].last(where: {$0 != nil})
            if let mySquare = data[j][i] {
                print("neighbour label is \((neighbour!)!.label), my label is \(mySquare.label)")
                if ((neighbour!)!.label == mySquare.label) {             // если мы готовы к сумме
                    if ((i == 1 && LorR == 1) || (i == 4 && LorR == -1)) {
                        mySquare.xPosition = (neighbour!)!.xPosition
                        (neighbour!)!.label = 999
                        data[j][7] = mySquare
                        
                        //                    date[3][i]!.color = .blue
                        mySquare.color = .blue
                        
                        data[j].remove(at: i)
                        data[j].insert(nil, at: i)
                        print("check \(mySquare.xPosition)")
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
    
    
    func moveOrNot(fromPosition i: Int, LorR: Int) {
        for j in 0...3 {
            // мы должны быть не nil
            //найти соседа
            let neighbour = (LorR == 1) ? data[j][i+1...5].first(where: {$0 != nil}) : data[j][0...i-1].last(where: {$0 != nil})

            //вычислить колво свободных клеток до него
            if let mySquare = data[j][i] {
                print("вошли в moveOrNot \(mySquare.label)")
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
    func generate(view: UIView) {
        var countOfNil = 0
        for i in 0...15 {
            if (data[Int(i / 4)][i % 4 + 1] == nil) {
                countOfNil += 1
            }
        }
        let randomPosition = Int.random(in: 1...countOfNil)
        countOfNil = 0
        for i in 0...15 {
            if (data[Int(i / 4)][i % 4 + 1] == nil) {
                countOfNil += 1
                if (countOfNil == randomPosition) {
                    data[Int(i / 4)][i % 4 + 1] = Square(xPosition: i % 4 + 1, yPosition: Int(i / 4), size: 78, color: .red, label: 2)
                    view.addSubview(data[Int(i / 4)][i % 4 + 1]!.view)
                }
            }
            
        }
    }
}
