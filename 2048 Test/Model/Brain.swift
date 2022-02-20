//
//  Brain.swift
//  2048 Test
//
//  Created by Иван Зайцев on 03.02.2022.
//

import Foundation
import UIKit

class Brain {
    var anythingWasMoved = true
    var gameIsOver = false
    let Multy = (0.1964+0.0268) * UIScreen.main.bounds.size.width
    let fieldColor = UIColor(displayP3Red: 239/255, green: 223/255, blue: 204/255, alpha: 1)
    let colr2 = UIColor(displayP3Red: 239/255, green: 230/255, blue: 221/255, alpha: 1)
    let colr4 = UIColor(displayP3Red: 235/255, green: 224/255, blue: 204/255, alpha: 1)
    let colr8 = UIColor(displayP3Red: 234/255, green: 180/255, blue: 131/255, alpha: 1)
    let colr16 = UIColor(displayP3Red: 234/255, green: 162/255, blue: 114/255, alpha: 1)
    let colr32 = UIColor(displayP3Red: 240/255, green: 150/255, blue: 113/255, alpha: 1)
    let colr64 = UIColor(displayP3Red: 238/255, green: 124/255, blue: 81/255, alpha: 1)
    let colr128 = UIColor(displayP3Red: 238/255, green: 210/255, blue: 134/255, alpha: 1)
    let colr256 = UIColor(displayP3Red: 238/255, green: 208/255, blue: 122/255, alpha: 1)
    let colr512 = UIColor(displayP3Red: 238/255, green: 203/255, blue: 107/255, alpha: 1)
    let colr1024 = UIColor(displayP3Red: 237/255, green: 200/255, blue: 92/255, alpha: 1)
    let colr2048 = UIColor(displayP3Red: 238/255, green: 197/255, blue: 80/255, alpha: 1)
    let colors: [String: UIColor]
    var data: [[Square?]] = (0...7).map{ _ in [Square?](repeating: nil, count: 8) }
    
    
    init(labels: [Int]) {
        colors = ["2" : colr2 ,"4" : colr4, "8": colr8 ,"16": colr16,"32": colr32,"64": colr64,"128": colr128 ,"256": colr256,"512": colr512,"1024": colr1024, "2048": colr2048]
        // инициализация, если хотим проверить лейблы
        for i in 0...3 {
            if labels[i] == 0 {
                data[4][i+1] = nil
            } else {
                data[4][i+1] = Square(xPosition: i + 1, yPosition: 4, size: (0.1946 * UIScreen.main.bounds.size.width), color: colors["\(labels[i])"]!, label: labels[i])
                data[4][i+1]?.view.textColor = .black
            }
        }
        // создание граничных квадратов
        for k in 1...4 {
            data[k][5] = Square(xPosition: 5, yPosition: k, size: 78, color: .blue, label: 7)
            data[k][0] = Square(xPosition: 0, yPosition: k, size: 78, color: .blue, label: 7)
        }
        
        for c in 1...4 {
            data[0][c] = Square(xPosition: c, yPosition: 0, size: 78, color: .blue, label: 7)
            data[5][c] = Square(xPosition: c, yPosition: 5, size: 78, color: .blue, label: 7)
        }
        
    }
    
    func completedHorizontalMoveMethod (view: UIView, sign: Int) {
        // удали того кто просуммировался ГОР
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
        // удали того кто просуммировался ВЕРТ
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
                    if (i == 6 || i == 7) {
                        UIView.animate(withDuration: 0.15) {
                            if let mySquare = self.data[j][self.data[j][i]!.xPosition] {
                                mySquare.view.transform = CGAffineTransform(scaleX: 2.7, y: 2.7)
                                mySquare.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                            }
                        }
                    }
                }
            }
        }
        // удвой числа если была сумма
        for i in 1...4 {
            if data[i][6] != nil {
                data[i][data[i][6]!.xPosition]!.view.text = "\(data[i][6]!.label*2)"
                data[i][data[i][6]!.xPosition]!.label = (data[i][6]!.label*2)
                data[i][data[i][6]!.xPosition]!.view.backgroundColor = colors["\(data[i][data[i][6]!.xPosition]!.view.text!)"] ?? .red
                
            }
            if data[i][7] != nil {
                data[i][data[i][7]!.xPosition]!.view.text = "\(data[i][7]!.label*2)"
                data[i][data[i][7]!.xPosition]!.label = (data[i][7]!.label*2)
                data[i][data[i][7]!.xPosition]!.view.backgroundColor = colors["\(data[i][data[i][7]!.xPosition]!.view.text!)"] ?? .red
            }
        }
        
        // создание нового квадрата
        generate(view: view)
        anythingWasMoved = false
        
        // отладка
        
//        for i in 0...7 {
//            print(data[i].map{($0 == nil) ? "⬜️" : "🅰️"})
//        }
//        print("count of subviews is \(view.subviews.count)")
        

    }
    func completedVerticalMoveMethod (view: UIView, sign: Int) {
        // удали того кто просуммировался ГОР
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
        // удали того кто просуммировался ВЕРТ
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
                    if (j == 6 || j == 7) {
                        UIView.animate(withDuration: 0.15) {
                            if let mySquare = self.data[self.data[j][i]!.yPosition][i] {
                                mySquare.view.transform = CGAffineTransform(scaleX: 2.7, y: 2.7)
                                mySquare.view.transform = CGAffineTransform(scaleX: 1, y: 1)
//                                print("trans")
                            }
                        }
                    }
                }
            }
        }
        //удвой числа если была сумма
        for j in 1...4 {
            if data[6][j] != nil {
                data[data[6][j]!.yPosition][j]!.view.text = "\(data[6][j]!.label*2)"
                data[data[6][j]!.yPosition][j]!.label = (data[6][j]!.label*2)
                data[data[6][j]!.yPosition][j]!.view.backgroundColor = colors["\(data[data[6][j]!.yPosition][j]!.view.text!)"] ?? .red
            }
            if data[7][j] != nil {
                data[data[7][j]!.yPosition][j]!.view.text = "\(data[7][j]!.label*2)"
                data[data[7][j]!.yPosition][j]!.label = (data[7][j]!.label*2)
                data[data[7][j]!.yPosition][j]!.view.backgroundColor = colors["\(data[data[7][j]!.yPosition][j]!.view.text!)"] ?? .red
            }
        }
        
        // создание нового квадрата
        generate(view: view)
        anythingWasMoved = false
        
//        ОТЛАДКА
//        for i in 0...7 {
//            print(data[i].map{($0 == nil) ? "⬜️" : "🅰️"})
//        }
//        print("count of subviews is \(view.subviews.count)")
    }
    
    
    func calcNewPos(square: Square) ->[CGFloat]{
        let Multy = (0.1964+0.0268) * UIScreen.main.bounds.size.width
        let x = 0.0268 * UIScreen.main.bounds.size.width + Multy * (CGFloat(square.xPosition) - 1.0)
        let y = 0.0268 * UIScreen.main.bounds.size.width + Multy * (CGFloat(square.yPosition) - 1.0)
        return [x,y]
    }
    func moveAll(square: Square) {
        
        UIView.animate(withDuration: 0.15) {
            square.view.frame = CGRect(x: self.calcNewPos(square: square)[0], y: self.calcNewPos(square: square)[1], width: CGFloat(square.size), height: CGFloat(square.size))
        }
    }
    
    
    
    func moveRowHorizontal(view: UIView, plusMinus: Int) { // подготовка перемещений
        for i in ((plusMinus == 1) ? stride(from: 4, through: 1, by: -1)  : stride(from: 1, through: 4, by: 1)  ) {
            moveForSumHorizontal(fromPosition: i, view: view, LorR: plusMinus)
            moveOrNotHorizontal(fromPosition: i, LorR: plusMinus)
        }
    }
    func moveRowVertical(view: UIView, plusMinus: Int) { // подготовка перемещений
        for j in ((plusMinus == 1) ? stride(from: 4, through: 1, by: -1)  : stride(from: 1, through: 4, by: 1)  ) {
            moveForSumVertical(fromPosition: j, view: view, UorD: plusMinus)
            moveOrNotVertical(fromPosition: j, UorD: plusMinus)
        }
    }
    
    
    // если сосед готов к сумме, тогда эта функция
    func moveForSumHorizontal(fromPosition i: Int, view: UIView, LorR: Int) {
        for j in 1...4 {
            let neighbour = (LorR == 1) ? data[j][i+1...5].first(where: {$0 != nil}) : data[j][0...i-1].last(where: {$0 != nil})
            if let mySquare = data[j][i] {
                // если мы готовы к сумме
                if ((neighbour!)!.label == mySquare.label) {
                    anythingWasMoved = true
                    if ((i == 1 && LorR == 1) || (i == 4 && LorR == -1)) {
                        mySquare.xPosition = (neighbour!)!.xPosition
                        (neighbour!)!.label = 999
                        data[j][7] = mySquare
                        data[j].remove(at: i)
                        data[j].insert(nil, at: i)
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
            let column = [data[0][i], data[1][i], data[2][i], data[3][i], data[4][i], data[5][i] ]
            let neighbour = (UorD == 1) ? column[j+1...5].first(where: {$0 != nil}) : column[0...j-1].last(where: {$0 != nil})
            if let mySquare = data[j][i] {
                // если мы готовы к сумме
                if ((neighbour!)!.label == mySquare.label) {
                    anythingWasMoved = true
                    if ((j == 1 && UorD == 1) || (j == 4 && UorD == -1)) {
                        mySquare.yPosition = (neighbour!)!.yPosition
                        (neighbour!)!.label = 999
                        data[7][i] = mySquare
                        data[j].remove(at: i)
                        data[j].insert(nil, at: i)
                    } else {
                        mySquare.yPosition = (neighbour!)!.yPosition
                        mySquare.color = .blue
                        (neighbour!)!.label = 999
                        data[6][i] = mySquare
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
            let neighbour = (LorR == 1) ? data[j][i+1...5].first(where: {$0 != nil}) : data[j][0...i-1].last(where: {$0 != nil})
            if let mySquare = data[j][i] {
                //вычислить колво свободных клеток до него
                let distance = abs((neighbour!)!.xPosition - mySquare.xPosition)
                mySquare.xPosition += (distance - 1) * LorR //обновили координату
                if (distance > 1) {
                    anythingWasMoved = true
                    data[j][mySquare.xPosition] = mySquare   // переложили view в массиве в новое место
                    data[j].remove(at: i)
                    data[j].insert(nil, at: i)
                }
                // картинка пока  не переехала а массив обновился
                // картинка обновится когда мы сделаем свайп
            }
        }
    }
    func moveOrNotVertical(fromPosition j: Int, UorD: Int) {
        //работаем по столбцам
        for i in 1...4 {
            // нашли столбец, тк потом пригодится
            let column = [data[0][i], data[1][i], data[2][i], data[3][i], data[4][i], data[5][i] ]
            let neighbour = (UorD == 1) ? column[j+1...5].first(where: {$0 != nil}) : column[0...j-1].last(where: {$0 != nil})
            if let mySquare = data[j][i] {
                //вычислить колво свободных клеток до него
                let distance = abs((neighbour!)!.yPosition - mySquare.yPosition)
                mySquare.yPosition += (distance - 1) * UorD //обновили позицию на экране
                if (distance > 1) {
                    anythingWasMoved = true
                    data[mySquare.yPosition][i] = mySquare   // переложили view в массиве в новое место
                    data[j].remove(at: i)
                    data[j].insert(nil, at: i)
                }
                // картинка пока  не переехала а массив обновился
                // картинка обновится когда мы сделаем свайп
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
        if anythingWasMoved {
            let randomPosition = Int.random(in: 1...countOfNil)
            countOfNil = 0
            for i in 0...15 {
                if (data[Int(i / 4) + 1][i % 4 + 1] == nil) {
                    countOfNil += 1
                    if (countOfNil == randomPosition) {
                        data[Int(i / 4) + 1][i % 4 + 1] = Square(xPosition: i % 4 + 1, yPosition: Int(i / 4)  + 1, size: (0.1946 * UIScreen.main.bounds.size.width), color: colr2, label: 2)
                        data[Int(i / 4) + 1][i % 4 + 1]!.view.isHidden = true
                        view.addSubview(data[Int(i / 4) + 1][i % 4 + 1]!.view)
                        UIView.animate(withDuration: 0) {
                                                self.data[Int(i / 4) + 1][i % 4 + 1]!.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                                            }
                        data[Int(i / 4) + 1][i % 4 + 1]!.view.isHidden = false
                        data[Int(i / 4) + 1][i % 4 + 1]!.view.textColor = .black
                        UIView.animate(withDuration: 0.4) {
                            self.data[Int(i / 4) + 1][i % 4 + 1]!.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                        }
                    }
                }
            }
        } else {
            if countOfNil == 0 {
               gameIsOver = true
                return
            }
        }
    }
}
