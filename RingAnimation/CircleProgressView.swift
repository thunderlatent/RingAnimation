//
//  CircleProgressBar.swift
//  RingAnimation
//
//  Created by Jimmy on 2021/3/1.
//

import UIKit

class CircleProgressView: UIView {
    //MARK: - ----------------Object----------------
    
    //MARK: - 正在跑的進度
    private let progressLayer = CAShapeLayer()
    
    //MARK: - 進度的底色
    private let trackLayer = CAShapeLayer()
    
    //MARK: - 旁邊的光圈
    private let pulsingLayer = CAShapeLayer()
    
    //MARK: - ----------------Properties----------------
    
    //MARK: - 圈圈的大小
    var radius: CGFloat = 50.0
    {
        didSet
        {
            layoutSubviews()
        }
    }

    
    //MARK: - 這個值決定目前的進度
    var progressValue = 0
    {
        didSet
        {
            progressLayer.strokeEnd = CGFloat(progressValue) * CGFloat(0.01)
            print(progressLayer.strokeEnd)
        }
    }
    
    //MARK: - 讀取圈內的背景顏色
    var fillColor = UIColor(red: 21/255, green: 22/255, blue: 33/255, alpha: 1).cgColor    {
        didSet
        {
            trackLayer.fillColor = fillColor
        }
    }
    
    //MARK: - 正在跑的進度的顏色
    var progressColor :CGColor = UIColor(red: 234/255, green: 46/255, blue: 111/255, alpha: 1).cgColor
    {
        didSet
        {
            progressLayer.strokeColor = progressColor
        }
    }
    
    //MARK: - 進度背景的顏色
    var trackColor :CGColor = UIColor(red: 56/255, green: 25/255, blue: 49/255, alpha: 1).cgColor
    {
        didSet
        {
            trackLayer.strokeColor = trackColor
        }
    }
    
    //MARK: - 光圈的顏色
    var pulsingColor :CGColor = UIColor(red: 86/255, green: 30/255, blue: 63/255, alpha: 1).cgColor
    {
        didSet
        {
            pulsingLayer.strokeColor = pulsingColor
        }
    }
    
   
//MARK: - -------------------------------初始化-------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        //MARK: - 加入這個廣播接收是因為當使用者把APP滑到背景再滑回來時會讓光圈停止，所以加入這個通知，等使用者滑回APP時，動畫繼續
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeGround), name: UIWindowScene.willEnterForegroundNotification, object: nil)
    }
    override func layoutSubviews() {
        createRingCircle()
    }
  
    @objc private func handleEnterForeGround()
    {
        animationPulsingLayer()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 創建讀取圈
    private func createRingCircle()
    {
        
        let baseView = UIView(frame: CGRect(x: bounds.midX, y: bounds.midY, width: 0 , height: 0))
        self.addSubview(baseView)
        let basePath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: .pi * -0.5, endAngle: .pi * 1.5, clockwise: true)
        baseView.layer.addSublayer(pulsingLayer)
        

        pulsingLayer.lineWidth = 15
        pulsingLayer.path = basePath.cgPath
        pulsingLayer.strokeColor = UIColor.clear.cgColor
        pulsingLayer.fillColor = pulsingColor
        pulsingLayer.lineCap = .round
        

        
        
        trackLayer.path = basePath.cgPath
        trackLayer.lineWidth = 10
        trackLayer.fillColor = fillColor
        trackLayer.strokeColor = trackColor
        baseView.layer.addSublayer(trackLayer)
        
        progressLayer.lineWidth = 10
        progressLayer.path = basePath.cgPath
        progressLayer.strokeColor = progressColor
        progressLayer.fillColor = fillColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        baseView.layer.addSublayer(progressLayer)
        
        animationPulsingLayer()

    }
    
    //MARK: - 創建脈衝光圈
    private func animationPulsingLayer()
    {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.5
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        animation.timingFunction = .init(name: .easeOut)
        
        pulsingLayer.add(animation, forKey: "animation")
    }
}
