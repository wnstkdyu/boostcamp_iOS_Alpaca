//
//  MyButton.swift
//  LoginScene
//
//  Created by Alpaca on 2017. 7. 16..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class MyButton: UIView, UIGestureRecognizerDelegate {
    
    var stateLabel: UILabel = UILabel()
    var backGroundImageView: UIImageView = UIImageView()
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    var longPressGestureRecognizer: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    var controlState: UIControlState = .normal
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 버튼의 배경색 설정
        self.backgroundColor = UIColor.darkGray
        print("MyButton Load")
        
        // button으로써 누를 수 있도록
        self.isUserInteractionEnabled = true
        
        /* stateLabel */
        // stateLabel 인스턴스 생성
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
        // backGroudnImageView 인스턴스 생성
        backGroundImageView = UIImageView(image: #imageLiteral(resourceName: "74CVLoJ2_bYGQV_3gAdRT_257508"))
        self.addSubview(backGroundImageView)
        
        // backGroundImageView 제약 설정
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        // backGroundImageView 설정
        backGroundImageView.alpha = 0.3
        backGroundImageView.sizeToFit()
        
        
        /* gestureRecognizer */
        // gestureRecognizer 인스턴스 생성
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionWhenTapping(sender:)))
//        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(actionWhenLongPressing(sender:)))
        
        // gestureRecognizer delegate를 myButton으로 설정
        tapGestureRecognizer.delegate = self
//        longPressGestureRecognizer.delegate = self.
        
//        longPressGestureRecognizer.minimumPressDuration = 0.01
        
        self.addGestureRecognizer(tapGestureRecognizer)
//        self.addGestureRecognizer(longPressGestureRecognizer)
        
        
        /* controlState */
        // controlState의 상태 초기화
        stateLabel.text = "normal"
        stateLabel.textColor = UIColor.yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 탭 시 변화하는 메서드 구현
    func actionWhenTapping(sender: UITapGestureRecognizer) {
        // 버튼의 상태에 따라 달라짐
        if controlState == UIControlState.normal {
            controlState = UIControlState.selected
            stateLabel.text = "selected"
            stateLabel.textColor = UIColor.green
            backGroundImageView.alpha = 0.3
        } else if controlState == UIControlState.selected {
            controlState = UIControlState.normal
            stateLabel.text = "normal"
            stateLabel.textColor = UIColor.yellow
            backGroundImageView.alpha = 0.3
        }
    }
    
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
        
        guard self.bounds.contains(touchLocation) == false else {
            print("touchInside")
            return
        }
        guard let text = stateLabel.text else { return }
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

    }
    
    // 롱프레스 시 변화하는 메서드 구현
//    func actionWhenLongPressing(sender: UILongPressGestureRecognizer) {
//        // normal에서 누르고 있을 경우
//        if sender.state == .began {
//            switch controlState {
//                // normal -> highlight1
//            case UIControlState.normal:
//                controlState = UIControlState.highlighted
//                stateLabel.text = "highlighted1"
//                stateLabel.textColor = UIColor.white
//                
//                print("longpress")
//                
//                backGroundImageView.alpha = 0.8
//                // selected -> highlight2
//            case UIControlState.selected:
//                controlState = UIControlState.highlighted
//                stateLabel.text = "highlighted2"
//                stateLabel.textColor = UIColor.red
//                
//                print("longpress2")
//                backGroundImageView.alpha = 0.8
//            default:
//                break
//            }
//        } else if sender.state == .ended {
//            guard let labelText = stateLabel.text else {
//                fatalError()
//            }
//            switch labelText {
//                // highlighted1 -> selected
//            case "highlighted1":
//                controlState = UIControlState.selected
//                stateLabel.text = "selected"
//                stateLabel.textColor = UIColor.green
//                
//                print("longpress3")
//                backGroundImageView.alpha = 0.3
//                // highlighted2 -> normal
//            case "highlighted2":
//                controlState = UIControlState.normal
//                stateLabel.text = "normal"
//                stateLabel.textColor = UIColor.black
//                
//                print("longpress4")
//                backGroundImageView.alpha = 0.3
//            default:
//                break
//            }
//        }
//    }
    
}
