//
//  SpinnerLoader.swift
//
//
//  Created by Scizor on 5/2/24.
//

import UIKit

public final class SpinnerLoader: UIView {
    private let circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = nil
        circleLayer.lineWidth = 3
        circleLayer.strokeColor = UIColor.TextColors.background.cgColor
        circleLayer.strokeStart = 0
        circleLayer.strokeEnd = 0
        circleLayer.lineCap = CAShapeLayerLineCap.round
        return circleLayer
    }()

    public var color: UIColor = UIColor.TextColors.background {
        didSet {
            self.circleLayer.strokeColor = self.color.cgColor
        }
    }
    public private(set) var isAnimating = false

    public init() {
        super.init(frame: .zero)
        self.layer.addSublayer(circleLayer)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        if self.circleLayer.frame != self.bounds {
            updateCircleLayer()
        }
    }

    public func updateCircleLayer() {
        let center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        let radius = (self.bounds.height - self.circleLayer.lineWidth) / 2.0

        let startAngle : CGFloat = 0.0
        let endAngle : CGFloat = 2.0 * CGFloat.pi

        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)

        self.circleLayer.path = path.cgPath
        self.circleLayer.frame = self.bounds
    }

    public func startAnimation() {

        guard !isAnimating else { return }
        self.isAnimating = true

        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        rotateAnimation.values = [
            0.0,
            Float.pi,
            (2.0 * Float.pi)
        ]


        let headAnimation = CABasicAnimation(keyPath: "strokeStart")
        headAnimation.duration = 1
        headAnimation.fromValue = 0
        headAnimation.toValue = 0.25

        let tailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        tailAnimation.duration = 1
        tailAnimation.fromValue = 0
        tailAnimation.toValue = 1

        let endHeadAnimation = CABasicAnimation(keyPath: "strokeStart")
        endHeadAnimation.beginTime = 1
        endHeadAnimation.duration = 1
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1


        let endTailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endTailAnimation.beginTime = 1
        endTailAnimation.duration = 1
        endTailAnimation.fromValue = 1
        endTailAnimation.toValue = 1

        let animations = CAAnimationGroup()
        animations.duration = 2
        animations.animations = [
            rotateAnimation,
            headAnimation,
            tailAnimation,
            endHeadAnimation,
            endTailAnimation
        ]
        animations.repeatCount = Float.infinity
        animations.isRemovedOnCompletion = false

        self.circleLayer.add(animations, forKey: "animations")
    }

    public func stopAnimating () {
        self.isAnimating = false
        self.circleLayer.removeAnimation(forKey: "animations")
    }

}
