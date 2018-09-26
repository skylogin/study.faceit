//
//  FaceView.swift
//  FaceIt
//
//  Created by Awesome S on 26/09/2018.
//  Copyright © 2018 Awesome S. All rights reserved.
//

import UIKit

class FaceView: UIView {

    
    var mouthCurvature: Double = 0.0 // -1 full frown, 1 full smile
    
    private var scale: CGFloat = 0.90
    private var skullRadius : CGFloat{
        get{
            return min(bounds.size.width, bounds.size.height) / 2 * scale
        }
    }
    private var skullCenter : CGPoint{
        get{
            return CGPoint(x: bounds.midX, y: bounds.midY)
        }
    }
    
    private struct Ratios{
        static let SkullRediusToEyeOffset: CGFloat = 3
        static let SkullRediusToEyeRadius: CGFloat = 10
        static let SkullRediusToMouthWidth: CGFloat = 1
        static let SkullRediusToMouthHeight: CGFloat = 3
        static let SkullRediusToMouthOffset: CGFloat = 3
    }

    private enum Eye{
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint:CGPoint, withRadius radius: CGFloat) -> UIBezierPath{
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false
        )
        path.lineWidth = 5.0
        return path
    }
    
    
    private func getEyeCenter(eye: Eye) -> CGPoint{
        let eyeOffset = skullRadius / Ratios.SkullRediusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye{
            case .Left: eyeCenter.x -= eyeOffset
            case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath{
        let eyeCenter = getEyeCenter(eye: eye)
        let eyeRadius = skullRadius / Ratios.SkullRediusToEyeRadius
        return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
    }
    
    private func pathForMount() -> UIBezierPath{
        let mouthWidth = skullRadius / Ratios.SkullRediusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRediusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRediusToMouthOffset
        
        // 입이 있어야 하는 곳에 사각형 만들기
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        
        // 컨트롤포인트 2개를 만들어서 커브로 만들기
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 5.0
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForCircleCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius).stroke()
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        pathForMount().stroke()
    }

}
