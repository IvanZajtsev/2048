//
//  Square.swift
//  2048 Test
//
//  Created by Иван Зайцев on 31.01.2022.
//

import Foundation
import UIKit

class Square {
    var view: UITextField
    var xPosition: Int
    var yPosition: Int
    let size: CGFloat
    var color: UIColor
    var label: Int
    let widthOfPlayGround = UIScreen.main.bounds.size.width
    let Multy = (0.1964+0.0268) * UIScreen.main.bounds.size.width
    init() {
        view = UITextField()
        xPosition = 0
        yPosition = 0
        size = 0.0
        color = .red
        label = 0
    }
    init(xPosition: Int, yPosition: Int, size: CGFloat, color: UIColor, label: Int) {
//        self.view = UITextField(frame: CGRect(x: ((xPosition - 1) * ((0.1964+0.0268)*widthOfPlayGround) + widthOfPlayGround * 0.0268), y:((yPosition - 1) * ((0.1964+0.0268)*widthOfPlayGround) + widthOfPlayGround * 0.0268), width: size, height: size))
        self.view = UITextField(frame: CGRect(x: 0.0268 * UIScreen.main.bounds.size.width + Multy * (CGFloat(xPosition) - 1.0),
                                              y: 0.0268 * UIScreen.main.bounds.size.width + Multy * (CGFloat(yPosition) - 1.0),
                                              width: size,
                                              height: size))
        
        self.view.isUserInteractionEnabled = false
        self.view.layer.cornerRadius = 15
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.size = size
        self.color = color
        self.view.backgroundColor = color
        self.label = label
        view.text = String(label)
        view.textAlignment = .center
        view.font = UIFont(name: (view.font?.fontName)!, size: CGFloat(40))
        //тут я убрал таймс нью роман
    }
    deinit {
        print("square deleted")
    }
}
