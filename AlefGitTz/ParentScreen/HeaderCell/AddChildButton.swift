//
//  AddChildButton.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 18.12.2022.
//

import UIKit

class AddChildButton: UIButton{
    
    var color: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    let touchDownAlpha: CGFloat = 0.3
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                touchDown()
            }else{
                cancelTracking(with: nil)
                touchUp()
            }
        }
    }
    weak var timer: Timer?
    let timerStep: TimeInterval = 0.01
    let animateTime: TimeInterval = 0.4
    lazy var alphaStep: CGFloat = {
        return(1 - touchDownAlpha) / CGFloat(animateTime / timerStep)
    }()
    
    func setup(){
        backgroundColor = .clear
        layer.backgroundColor = color.cgColor
        layer.cornerRadius = 6
        clipsToBounds = true
    }
    convenience init(color: UIColor? = nil, title: String? = nil){
        self.init(type: .custom)
        if let color = color{
            self.color = color
        }
        if let title = title{
            setTitle(title, for: .normal)
        }
        setup()
    }
    func touchDown(){
        stopTimer()
        layer.backgroundColor = color.withAlphaComponent(touchDownAlpha).cgColor
    }
    func touchUp(){
        timer = Timer.scheduledTimer(timeInterval: timerStep, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
    }
    @objc func animation(){
        guard let backgroundAlpha = layer.backgroundColor?.alpha else {
            stopTimer()
            return
        }
        let newAlpha = backgroundAlpha + alphaStep
        if newAlpha < 1 {
            layer.backgroundColor = color.withAlphaComponent(newAlpha).cgColor
        }else{
            layer.backgroundColor = color.cgColor
            
            stopTimer()
        }
    }
//stop timer restart
    func stopTimer(){
        timer?.invalidate()
}
    deinit{
        stopTimer()
    }
}
