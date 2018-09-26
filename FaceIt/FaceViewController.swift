//
//  ViewController.swift
//  FaceIt
//
//  Created by Awesome S on 26/09/2018.
//  Copyright © 2018 Awesome S. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!
    
    @IBAction func emotionHandler(_ sender: UIButton) {
        let flag = sender.currentTitle!
        
        print(flag)
        
        if(flag == "+"){
            if(faceView.mouthCurvature < 0.9){
                faceView.mouthCurvature = faceView.mouthCurvature + 0.1
            }
        } else if(flag == "-"){
            if(faceView.mouthCurvature > -0.9){
                faceView.mouthCurvature = faceView.mouthCurvature - 0.1
            }
        }
        
        print(faceView.mouthCurvature)
        
        faceView.setNeedsDisplay()
        
    }
    
    
 
}

