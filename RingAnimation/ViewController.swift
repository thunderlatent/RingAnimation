//
//  ViewController.swift
//  RingAnimation
//
//  Created by Jimmy on 2021/2/25.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    var percent = 0
    {
        didSet
        {
            percentLabel.text = "\(percent)%"
            print(percent)
        }
    }
    var timer: Timer?
    let shaperLayer = CAShapeLayer()
    let trackShaperLayer = CAShapeLayer()
    var percentLabel: UILabel =
        {
            let label = UILabel()
            label.textColor = .darkGray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 30)
            return label
        }()
    var runAnimationButton: UIButton =
        {
            let button = UIButton()
            button.setTitle("Run Animation", for: .normal)
            button.backgroundColor = .green
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            button.addTarget(self, action: #selector(addPercentTimer), for: .touchUpInside)
            return button
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePercentLabel()
        configureRunAnimationButton()
        // Do any additional setup after loading the view.
        createRingCircle()
    }
    
    
    func createRingCircle()
    {
        let circlePath = UIBezierPath(arcCenter: view.center, radius: 150, startAngle: .pi * -0.5, endAngle: .pi * 1.5, clockwise: true)
        trackShaperLayer.path = circlePath.cgPath
        trackShaperLayer.lineWidth = 15
        trackShaperLayer.fillColor = UIColor.clear.cgColor
        trackShaperLayer.strokeColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(trackShaperLayer)
        
        shaperLayer.lineWidth = 15
        shaperLayer.path = circlePath.cgPath
        shaperLayer.strokeColor = UIColor.green.cgColor
        shaperLayer.fillColor = UIColor.clear.cgColor
        shaperLayer.strokeEnd = 0.0
        
        view.layer.addSublayer(shaperLayer)
    }
    private func configurePercentLabel()
    {
        view.addSubview(percentLabel)
        percentLabel.text = "\(percent)"
        percentLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    private func configureRunAnimationButton()
    {
        view.addSubview(runAnimationButton)
        runAnimationButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
    }
    
    @objc func runAnimation()
    {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = Double(percent) * 0.01
        animation.duration = 0.03
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shaperLayer.add(animation, forKey: "animation")
        if percent < 100
        {
            percent += 1
        }else
        {
            self.timer?.invalidate()
            
        }
    }
    @objc func addPercentTimer()
    {
        self.percent = 0
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runAnimation), userInfo: nil, repeats: true)
        
    }
    @objc func test()
    {
        print(Date().timeIntervalSince1970)
    }
}

