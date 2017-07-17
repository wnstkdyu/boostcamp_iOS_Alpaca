//
//  MyButton.swift
//  LoginScene
//
//  Created by Alpaca on 2017. 7. 16..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class MyButton: UIView {
    
    var stateLabel: UILabel!
    var backGroundImageView: UIImageView!
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 버튼의 배경색 설정
        self.backgroundColor = UIColor.darkGray
        print("MyButton Load")
        
        
        /* stateLabel */
        // stateLabel 인스턴스 생성
        stateLabel = UILabel()
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
        stateLabel.trailingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        
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
        
        
        /* tapGestureRecognizer */
        // tapGestureRecognizer 인스턴스 생성
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionWhenTapping(sender:)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 탭시 변화하는 메서드 구현
    func actionWhenTapping(sender: UITapGestureRecognizer) {
        // 버튼의 상태에 따라 달라짐
    }
    
}
