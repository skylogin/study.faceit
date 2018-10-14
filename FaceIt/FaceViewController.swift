//
//  ViewController.swift
//  FaceIt
//
//  Created by Awesome S on 26/09/2018.
//  Copyright © 2018 Awesome S. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Neutral){
        didSet{
            updateUI()
        }
    }
    
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))
            
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness))
            happierSwipeGestureRecognizer.direction = .up
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness))
            sadderSwipeGestureRecognizer.direction = .down
            
            
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            updateUI()
            
        }
        
    }
    
    // 스토리보드를 통해 액션추가
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended{
            switch expression.eyes{
                case .Open: expression.eyes = .Closed
                case .Closed: expression.eyes = .Open
                case .Squinting: break
            }
        }
        
    }
    
    @objc
    func increaseHappiness(){
        expression.mouth = expression.mouth.happerMouth()
    }
    
    @objc
    func decreaseHappiness(){
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    
    
    
    
    private var mouthCurvatures = [
        FacialExpression.Mouth.Frown: -1.0,
        .Grin: 0.5,
        .Smile: 1.0,
        .Smirk: -0.5,
        .Neutral: 0.0
    ]
    private var eyeBrowTilts = [
        FacialExpression.EyeBrows.Relaxed: 0.5,
        .Furrowed: -0.5,
        .Normal: 0.0
    ]
    private func updateUI(){
        if faceView != nil {
            switch expression.eyes{
                case .Open: faceView.eyesOpen = true
                case .Closed: faceView.eyesOpen = false
                case .Squinting: faceView.eyesOpen = false
            }
            
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
    
    
}

