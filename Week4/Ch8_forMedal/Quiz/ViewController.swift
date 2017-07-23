//
//  ViewController.swift
//  Quiz
//
//  Created by Alpaca on 2017. 6. 30..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["From what is cognac made?", "What is 7+7?", "What is the capital of Vermont?"]
    let answers: [String] = ["Grapes", "14", "Montpelier"]
    var currentQuestionIndex: Int = 0
    
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex = (currentQuestionIndex == questions.count - 1) ? 0 : currentQuestionIndex + 1
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 라벨의 초기 알파 값을 설정한다.
        nextQuestionLabel.alpha = 0
    }
    
    
    func animateLabelTransitions() {
        // 아직 처리하지 않은 레이아웃 변경을 요구한다.
        view.layoutIfNeeded()
        
        // 알파 값을 변경한다.
        // 그리고 center X 제약 조건을 추가한다.
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
//        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],
//                       animations: {
//                        self.currentQuestionLabel.alpha = 0
//                        self.nextQuestionLabel.alpha = 1
//                        
//                        self.view.layoutIfNeeded()
//                       },
//                       completion: { _ in
//                        swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
//                        swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
//                        
//                        self.updateOffScreenLabel()
//                       })
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: [.curveLinear],
                       animations: { self.currentQuestionLabel.alpha = 0
                                    self.nextQuestionLabel.alpha = 1
            
                                    self.view.layoutIfNeeded() },
                       completion: { _ in
                                    swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                                    swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
        
                                    self.updateOffScreenLabel() }
        )
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
}

