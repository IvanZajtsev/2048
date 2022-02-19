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
        self.view = UITextField(frame: CGRect(x: 0.0268 * UIScreen.main.bounds.size.width + Multy * (CGFloat(xPosition) - 1.0),
                                              y: 0.0268 * UIScreen.main.bounds.size.width + Multy * (CGFloat(yPosition) - 1.0),
                                              width: size,
                                              height: size))
        
        self.view.isUserInteractionEnabled = false
        self.view.layer.cornerRadius = 7
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.size = size
        self.color = color
        self.view.backgroundColor = color
        self.label = label
//        updateTextFont(view: view)
        view.text = String(label)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumFontSize = 1
        view.font = view.font?.withSize(35)
        view.font = .boldSystemFont(ofSize: 35)
//        view.font = UIFont(name: (view.font?.fontName)!, size: CGFloat(40))
        //тут я убрал таймс нью роман
    }
    deinit {
        print("square deleted")
    }
//    func updateTextFont(view: UILabel) {
//        if (view.text.isEmpty || view.bounds.size.equalTo(CGSize.zero)) {
//            return;
//        }
//
//        let textViewSize = view.frame.size;
//        let fixedWidth = textViewSize.width;
//        let expectSize = view.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)));
//
//        var expectFont = view.font;
//        if (expectSize.height > textViewSize.height) {
//            while (view.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height > textViewSize.height) {
//                expectFont = view.font!.withSize(view.font!.pointSize - 1)
//                view.font = expectFont
//            }
//        }
//        else {
//            while (view.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height < textViewSize.height) {
//                expectFont = view.font;
//                view.font = view.font!.withSize(view.font!.pointSize + 1)
//            }
//            view.font = expectFont;
//        }
//    }
}
