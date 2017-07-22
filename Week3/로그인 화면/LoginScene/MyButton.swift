//
//  MyButton.swift
//  LoginScene
//
//  Created by Alpaca on 2017. 7. 16..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class MyButton: UIView {
    
    var stateLabel: UILabel = UILabel()
    var backGroundImageView: UIImageView = UIImageView()
    var controlState: UIControlState = .normal
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
        print("MyButton Load")
        
        // button으로써 누를 수 있도록
        self.isUserInteractionEnabled = true
        
        /* stateLabel */
        stateLabel = UILabel(frame: CGRect.init())
        self.addSubview(stateLabel)
        
        // stateLabel의 텍스트 설정
        stateLabel.text = "My Button"
        stateLabel.textAlignment = .center
        stateLabel.adjustsFontSizeToFitWidth = true
        
        // label의 제약 설정
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        /* backGroundImageView */
        backGroundImageView = UIImageView(image: #imageLiteral(resourceName: "74CVLoJ2_bYGQV_3gAdRT_257508"))
        self.addSubview(backGroundImageView)
        
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        // backGroundImageView 설정
        backGroundImageView.alpha = 0.3
        backGroundImageView.sizeToFit()
        
        
        /* controlState */
        stateLabel.text = "normal"
        stateLabel.textColor = UIColor.yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 탭 시 변화하는 메서드 구현
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if controlState == UIControlState.normal {
            stateLabel.text = "highlighted1"
            stateLabel.textColor = UIColor.white
            backGroundImageView.alpha = 0.8
        } else if controlState == UIControlState.selected {
            stateLabel.text = "highlighted2"
            stateLabel.textColor = UIColor.red
            backGroundImageView.alpha = 0.8
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        guard let text = stateLabel.text else { return }
        
        guard self.bounds.contains(touchLocation) else {
            switch text {
            case "highlighted1":
                controlState = UIControlState.normal
                stateLabel.text = "normal"
                stateLabel.textColor = UIColor.yellow
                backGroundImageView.alpha = 0.3
            case "highlighted2":
                controlState = UIControlState.selected
                stateLabel.text = "selected"
                stateLabel.textColor = UIColor.green
                backGroundImageView.alpha = 0.3
            default:
                break
            }
            return
        }
        
        print("touchInside")
        switch text {
        case "highlighted1":
            controlState = UIControlState.selected
            stateLabel.text = "selected"
            stateLabel.textColor = UIColor.green
            backGroundImageView.alpha = 0.3
        case "highlighted2":
            controlState = UIControlState.normal
            stateLabel.text = "normal"
            stateLabel.textColor = UIColor.yellow
            backGroundImageView.alpha = 0.3

        default:
            break
        }
    }
//        guard self.bounds.contains(touchLocation) == false else {
//            print("touchInside")
//            switch text {
//            case "highlighted1":
//                controlState = UIControlState.selected
//                stateLabel.text = "selected"
//                stateLabel.textColor = UIColor.green
//                backGroundImageView.alpha = 0.3
//            case "highlighted2":
//                controlState = UIControlState.normal
//                stateLabel.text = "normal"
//                stateLabel.textColor = UIColor.yellow
//                backGroundImageView.alpha = 0.3
//
//            default:
//                break
//            }
//            return
//        }
//        
//        switch text {
//        case "highlighted1":
//            controlState = UIControlState.normal
//            stateLabel.text = "normal"
//            stateLabel.textColor = UIColor.yellow
//            backGroundImageView.alpha = 0.3
//        case "highlighted2":
//            controlState = UIControlState.selected
//            stateLabel.text = "selected"
//            stateLabel.textColor = UIColor.green
//            backGroundImageView.alpha = 0.3
//        default:
//            break
//        }

//    }
    
}
