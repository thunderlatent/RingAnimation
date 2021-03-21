//
//  ViewController.swift
//  RingAnimation
//
//  Created by Jimmy on 2021/2/25.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    //MARK: - ----------------Object----------------
    
    //MARK: - 創建讀取動畫物件，稍後再實例化
    private var circleProgressView = CircleProgressView()

    
    //MARK: - 顯示進度的Label
    private var percentLabel: UILabel =
        {
            let label = UILabel()
            label.textColor = .darkGray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 30)
            return label
        }()
    
    //MARK: - 點擊開始執行動畫
    private var runAnimationButton: UIButton =
        {
            let button = UIButton()
            button.setTitle("Run Animation", for: .normal)
            button.backgroundColor = .green
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            button.addTarget(self, action: #selector(addPercentTimer), for: .touchUpInside)
            return button
        }()
    
    //MARK: - ----------------Properties----------------
    
    //MARK: - 這個變數指定讀取進度，例如60，則讀取進度就讀到60%
    private var percentValue = 0
    {
        didSet
        {
            circleProgressView.progressValue = percentValue
            percentLabel.text = "\(percentValue)%"
        }
    }
    
    //MARK: - 通常是應用在去網路下載東西，需要顯示進度，但是我懶得寫網路的部分，所以直接用Timer來改變進度
    private var timer: Timer?
    
    
    //MARK: - ----------------Life Cycle---------------
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoadingAnimation()
    }

    
    
    //MARK: - 設置進度Label
    private func configurePercentLabel()
    {
        view.addSubview(percentLabel)
        percentLabel.text = "\(percentValue)"
        percentLabel.snp.makeConstraints { (make) in
            make.center.equalTo(circleProgressView.snp.center)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    //MARK: - 配置開始動畫按鈕
    private func configureRunAnimationButton()
    {
        view.addSubview(runAnimationButton)
        runAnimationButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
    }
    
    //MARK: - 配置所有UI
    private func configureLoadingAnimation()
    {
        //MARK: - 這邊要注意的是label要在circleProgressLayer被addSublayer之後才能addSubview，否則會被layer蓋住
        configureRunAnimationButton()
        configureCircleProgressView()
        configurePercentLabel()
    }
    private func configureCircleProgressView()
    {
        view.addSubview(circleProgressView)
        circleProgressView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
    }
    
    //MARK: - 點擊按鈕後開始執行計時器去改變進度
    @objc func addPercentTimer()
    {
        self.timer?.invalidate()
        self.percentValue = 0
        self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(changeProgressValue), userInfo: nil, repeats: true)
    }
    
    //MARK: - 改變進度值
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

