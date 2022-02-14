//
//  Brain.swift
//  2048 Test
//
//  Created by Иван Зайцев on 03.02.2022.
//

import Foundation
import UIKit

class Brain {
    var date: [[Square?]] = (0...3).map{ _ in [Square?](repeating: nil, count: 7) }
    
    init(labels: [Int]) {
        for i in 0...3 {
            if labels[i] == 0 {
                date[3][i] = nil
            } else {
                date[3][i] = Square(xPosition: i, yPosition: 3, size: 78, color: .orange, label: labels[i])
            }
        }
        date[3][4] = Square(xPosition: 4, yPosition: 3, size: 78, color: .blue, label: 12345)
        //граничный квадрат
        //        date[3][0] = Square(xPosition: 0, yPosition: 3, size: 78, color: .orange, label: 4)
        //        date[3][1] = Square(xPosition: 1, yPosition: 3, size: 78, color: .orange, label: 4)
        ////        date[3][2] = Square(xPosition: 2, yPosition: 3, size: 78, color: .blue, label: 4)
        //        date[3][2] = Square(xPosition: 2, yPosition: 3, size: 78, color: .orange, label: 2)
        //        date[3][3] = Square(xPosition: 3, yPosition: 3, size: 78, color: .orange, label: 2)
//        date[0][0] = Square(xPosition: 0, yPosition: 0, size: 78, color: .lightGray, label: 2)
//        date[0][1] = Square(xPosition: 1, yPosition: 0, size: 78, color: .darkGray, label: 4)
//        date[3][3]?.view.addSubview(<#T##view: UIView##UIView#>)
    }
    func moveRowRight(view: UIView) -> Int{ // подготовка перемещений
        var indexOfWhoLabelMultByTwo = -1
        for i in stride(from: 3, through: 0, by: -1) {
            if (date[3][i] != nil) {
                print("neighbour was \((date[3][i+1...4].first(where: {$0 != nil})!)!.view.text!)")
            }
            
            moveForSum(fromPosition: i, view: view)
            
            //ищем ближайшего соседа справа
            //            let neighbour = date[3][i+1...4].first(where: {$0 != nil})
            //            if (date[3][i] != nil) {
            //                print("neighbour was \(neighbour!!.label)")
            //            }
            //если можно просуммироваться,
            //            if (neighbour != nil) && (date[3][i] != nil) && (date[3][i]!.label == (neighbour!)!.label) {
            //                indexOfwhoWillBeDeleted = i
            //                //поедем на его место, а его текст удвоим
            //                date[3][i]!.xPosition = (neighbour!)!.xPosition
            //                //                date[3][(neighbour!)!.xPosition] = date[3][i]
            //                //                date[3].remove(at: i)
            //                //                date[3].insert(nil, at: i)
            //                (neighbour!)!.view.text = "\((neighbour!)!.label*2)"
            //                (neighbour!)!.label *= 2
            //                //двигаем того кто стоит сразу после суммирующихся
            //                if (i>0) && (date[3][i-1] != nil) {
            //                    date[3][i-1]!.xPosition = (neighbour!)!.xPosition - 1
            //                }
            //типа надо пропустить итерацию
            //            } else {
            moveOrNot(fromPosition: i)
            //            }
        }
        return indexOfWhoLabelMultByTwo
    }
    
    
    
    // если сосед готов к сумме, тогда эта функция
    func moveForSum(fromPosition i: Int, view: UIView) {
        //надо вот тут зашить проверку на готовность к сумме
        let neighbour = date[3][i+1...4].first(where: {$0 != nil})
        if let mySquare = date[3][i] {
            print("neighbour label is \((neighbour!)!.label), my label is \(mySquare.label)")
            if ((neighbour!)!.label == mySquare.label) {             // если мы готовы к сумме
                if (i == 0) {
                    mySquare.xPosition = (neighbour!)!.xPosition
                    (neighbour!)!.label = 999
                    date[3][6] = mySquare
                    
//                    date[3][i]!.color = .blue
                    mySquare.color = .blue
                    
                    date[3].remove(at: i)
                    date[3].insert(nil, at: i)
                    print("check \(mySquare.xPosition)")
                } else {
                    mySquare.xPosition = (neighbour!)!.xPosition
                    (neighbour!)!.label = 999
                    date[3][5] = mySquare
                    date[3].remove(at: i)
                    date[3].insert(nil, at: i)
                }
                view.bringSubviewToFront(date[3][mySquare.xPosition]!.view)
            }
        }
    }
    
    
    func moveOrNot(fromPosition i: Int) {
        // мы должны быть не nil
        //найти соседа
        let neighbour = date[3][i+1...4].first(where: {$0 != nil})
        
        //вычислить колво свободных клеток до него
        if let mySquare = date[3][i] {
            print("вошли в moveOrNot \(mySquare.label)")
            let distance = (neighbour!)!.xPosition - mySquare.xPosition
            mySquare.xPosition += (distance - 1) //обновили позицию на экране
            if (distance > 1) {
                date[3][mySquare.xPosition] = mySquare   // переложили view в массиве в новое место
                // удали только если это не суммирование перемещение
                date[3].remove(at: i)
                date[3].insert(nil, at: i)
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
            if (date[Int(i / 4)][i % 4] == nil) {
                countOfNil += 1
            }
        }
        let randomPosition = Int.random(in: 1...countOfNil)
        countOfNil = 0
        for i in 0...15 {
            if (date[Int(i / 4)][i % 4] == nil) {
                countOfNil += 1
                if (countOfNil == randomPosition) {
                    date[Int(i / 4)][i % 4] = Square(xPosition: i % 4, yPosition: Int(i / 4), size: 78, color: .red, label: 2)
                    view.addSubview(date[Int(i / 4)][i % 4]!.view)
                }
            }
            
        }
    }
}

// 2428 работает
//  2400
//  0022

//    func moveWhileFree(position p: Int) -> Int {
//        var i=p
//        while (i<4)  && (date[3][i+1] == nil){
//            i += 1
//        }
//        return i
//    }






//if (date[3][i+1] == nil) && (date[3][i] != nil) { //если справа свободно и мы не nil
//    date[3][i]!.xPosition = date[3][i+1...4].first(where: {$0 != nil}).
//    date[3][i+1] = date[3][i]
//    date[3].remove(at: i)
//    date[3].insert(nil, at: i)
//    // картинки переехали а массив не обновился





//func moveRowRight() {
//    // одна замена
//    var readyToSum = [Bool](repeating: false, count: 4)
//    //тут подсчет этих булеанов обоссаных
//    readyToSum = [false, true, false, false]
//    for i in 1...2 {                             // а что с самым левым
//        let q = 3-i
//        if readyToSum[q] {
//            //подвинь все если свободно
//            date[3][q]!.view.text = "\(date[3][q]!.label*2)"
//            date[3][q]!.xPosition = moveWhileFree(position: q) //не зависит от q
//            date[3][q-1]!.xPosition = moveWhileFree(position: q)
//            //переместить view которое date[3][i-1]
//            //   !!!    анимация увеличения клетки
//
//            //переместить view которое date[3][i-1]
//        } else if (date[3][q] != nil) {
//            //подвинь если свободно то есть справа только nil-ы
////                date[3][q+1] = Square(xPosition: date[3][q]!.xPosition, yPosition: date[3][q]!.yPosition, size: 78, color: .green, label: date[3][q]!.label) // это РОВНО на один шаг вправо
//            date[3][q]!.xPosition = moveWhileFree(position: q)
//            date[3][q+1] = date[3][q]
//            date[3].remove(at: q)
//            date[3].insert(nil, at: q)
//
//            //и переместить view
//        }
//    }
//    //и тут уже в конце движения уничтожить лишние квадры date[3][i-1] вообще все которые сталит чистыми
//
//}
//



//func moveRowRight() -> Int{ // подготовка перемещений
//    var indexOfwhoWillBeDeleted = -1
//    for i in stride(from: 3, through: 0, by: -1) {
//
//
//        //ищем ближайшего соседа справа
//        let neighbour = date[3][i+1...4].first(where: {$0 != nil})
//        if (date[3][i] != nil) {
//            print("neighbour was \(neighbour!!.label)")
//        }
//        //если можно просуммироваться,
//        if (neighbour != nil) && (date[3][i] != nil) && (date[3][i]!.label == (neighbour!)!.label) {
//            indexOfwhoWillBeDeleted = i
//            //поедем на его место, а его текст удвоим
//            date[3][i]!.xPosition = (neighbour!)!.xPosition
//            //                date[3][(neighbour!)!.xPosition] = date[3][i]
//            //                date[3].remove(at: i)
//            //                date[3].insert(nil, at: i)
//            (neighbour!)!.view.text = "\((neighbour!)!.label*2)"
//            (neighbour!)!.label *= 2
//            //двигаем того кто стоит сразу после суммирующихся
//            if (i>0) && (date[3][i-1] != nil) {
//                date[3][i-1]!.xPosition = (neighbour!)!.xPosition - 1
//            }
//            //типа надо пропустить итерацию
//        } else {
//            moveOrNot(fromPosition: i)
//        }
//    }
//    return indexOfwhoWillBeDeleted
//}
