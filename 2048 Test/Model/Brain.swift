//
//  Brain.swift
//  2048 Test
//
//  Created by Иван Зайцев on 03.02.2022.
//

import Foundation
import UIKit

class Brain {
    var data: [[Square?]] = (0...3).map{ _ in [Square?](repeating: nil, count: 7) }
    
    init(labels: [Int]) {
        for i in 0...3 {
            if labels[i] == 0 {
                data[3][i] = nil
            } else {
                data[3][i] = Square(xPosition: i, yPosition: 3, size: 78, color: .orange, label: labels[i])
            }
        }
        data[3][4] = Square(xPosition: 4, yPosition: 3, size: 78, color: .blue, label: 12345)
        //граничный квадрат
    }
    
    func completedMoveMethod (view: UIView) {
        // удали того кто просуммировался
        if  data[3][5] != nil {
            data[3][5]!.view.removeFromSuperview()
            data[3][5] = nil
        }
        if  data[3][6] != nil {
            data[3][6]!.view.removeFromSuperview()
            data[3][6] = nil
        }
        // тут пересчитываются координаты квадратов
        moveRowRight(view: view)

        // тут меняется картинка положение квадратов
        for i in 0...6 {
            if data[3][i] != nil {
                moveAll(square: data[3][i]!)
            }
        }
        // удвой числа если была сумма
        if data[3][5] != nil {
            data[3][data[3][5]!.xPosition]!.view.text = "\(data[3][5]!.label*2)"
            data[3][data[3][5]!.xPosition]!.label = (data[3][5]!.label*2)
            
        }
        if data[3][6] != nil {
            data[3][data[3][6]!.xPosition]!.view.text = "\(data[3][6]!.label*2)"
            data[3][data[3][6]!.xPosition]!.label = (data[3][6]!.label*2)
            
        }
        
        
        generate(view: view)
        print(data[3].map{$0 == nil})
        print("count of subviews is \(view.subviews.count)")
        

    }
    func moveAll(square: Square) {
        UIView.animate(withDuration: 0.2) {
            square.view.frame = CGRect(x: 12 + square.xPosition*90, y: 12 + square.yPosition*90, width: square.size, height: square.size)
        }
        
    }
    
    
    
    func moveRowRight(view: UIView) -> Int{ // подготовка перемещений
        var indexOfWhoLabelMultByTwo = -1
        for i in stride(from: 3, through: 0, by: -1) {
            if (data[3][i] != nil) {
                print("neighbour was \((data[3][i+1...4].first(where: {$0 != nil})!)!.view.text!)")
            }
            moveForSum(fromPosition: i, view: view)
            moveOrNot(fromPosition: i)
        }
        return indexOfWhoLabelMultByTwo
    }
    
    
    // если сосед готов к сумме, тогда эта функция
    func moveForSum(fromPosition i: Int, view: UIView) {
        //надо вот тут зашить проверку на готовность к сумме
        let neighbour = data[3][i+1...4].first(where: {$0 != nil})
        if let mySquare = data[3][i] {
            print("neighbour label is \((neighbour!)!.label), my label is \(mySquare.label)")
            if ((neighbour!)!.label == mySquare.label) {             // если мы готовы к сумме
                if (i == 0) {
                    mySquare.xPosition = (neighbour!)!.xPosition
                    (neighbour!)!.label = 999
                    data[3][6] = mySquare
                    
//                    date[3][i]!.color = .blue
                    mySquare.color = .blue
                    
                    data[3].remove(at: i)
                    data[3].insert(nil, at: i)
                    print("check \(mySquare.xPosition)")
                } else {
                    mySquare.xPosition = (neighbour!)!.xPosition
                    (neighbour!)!.label = 999
                    data[3][5] = mySquare
                    data[3].remove(at: i)
                    data[3].insert(nil, at: i)
                }
                view.bringSubviewToFront(data[3][mySquare.xPosition]!.view)
            }
        }
    }
    
    
    func moveOrNot(fromPosition i: Int) {
        // мы должны быть не nil
        //найти соседа
        let neighbour = data[3][i+1...4].first(where: {$0 != nil})
        
        //вычислить колво свободных клеток до него
        if let mySquare = data[3][i] {
            print("вошли в moveOrNot \(mySquare.label)")
            let distance = (neighbour!)!.xPosition - mySquare.xPosition
            mySquare.xPosition += (distance - 1) //обновили позицию на экране
            if (distance > 1) {
                data[3][mySquare.xPosition] = mySquare   // переложили view в массиве в новое место
                // удали только если это не суммирование перемещение
                data[3].remove(at: i)
                data[3].insert(nil, at: i)
            }
            // картинка пока  не переехала а массив обновился
            // картинка обновится когда мы сделаем свайп
        } else {
            // мы нил? лол
        }
        
        //переместиться на колво своб клеток (даже если их ноль)
        //если клеток было не ноль, то удалить вставить в массиве
    }
    func generate(view: UIView) {
        var countOfNil = 0
        for i in 0...15 {
            if (data[Int(i / 4)][i % 4] == nil) {
                countOfNil += 1
            }
        }
        let randomPosition = Int.random(in: 1...countOfNil)
        countOfNil = 0
        for i in 0...15 {
            if (data[Int(i / 4)][i % 4] == nil) {
                countOfNil += 1
                if (countOfNil == randomPosition) {
                    data[Int(i / 4)][i % 4] = Square(xPosition: i % 4, yPosition: Int(i / 4), size: 78, color: .red, label: 2)
                    view.addSubview(data[Int(i / 4)][i % 4]!.view)
                }
            }
            
        }
    }
}
