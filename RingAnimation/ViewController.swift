//
//  ViewController.swift
//  RingAnimation
//
//  Created by Jimmy on 2021/2/25.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    var circleProgressLayer: CircleProgressBar!
    var percentValue = 0
    {
        didSet
        {
            circleProgressLayer.progressValue = percentValue
            percentLabel.text = "\(percentValue)%"
        }
    }
    var timer: Timer?
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
    private func configurePercentLabel()
    {
        view.addSubview(percentLabel)
        percentLabel.text = "\(percentValue)"
        percentLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        view.layoutIfNeeded()
    }
    
    private func configureRunAnimationButton()
    {
        view.addSubview(runAnimationButton)
        runAnimationButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .black
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRunAnimationButton()
        circleProgressLayer = CircleProgressBar(radius: 80)
        view.layer.addSublayer(circleProgressLayer)
        circleProgressLayer.position = view.center
        configurePercentLabel()

        
        
    }
    @objc func addPercentTimer()
    {
        self.timer?.invalidate()
        self.percentValue = 0
        self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(changeProgressValue), userInfo: nil, repeats: true)
        
    }
    @objc func changeProgressValue()
    {
        if self.percentValue < 100
        {
            percentValue += 1
        }else
        {
            timer?.invalidate()
        }
    }
}

