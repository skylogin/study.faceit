//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Awesome S on 30/09/2018.
//  Copyright © 2018 Awesome S. All rights reserved.
//

import Foundation

struct FacialExpression{
    enum Eyes: Int{
        case Open       // 뜬
        case Closed     // 안뜬
        case Squinting  // 가늘게뜬
    }
    
    enum EyeBrows: Int{
        case Relaxed    // 편안한
        case Normal     // 일반
        case Furrowed   // 주름진
        
        func moreRelaxedBrow() -> EyeBrows{
            return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
        }
        func moreFurrowedBorw() -> EyeBrows{
            return EyeBrows(rawValue: rawValue + 1) ?? .Furrowed
        }
    }
    
    enum Mouth: Int{
        case Frown      // 찌푸린
        case Smirk      // 실실우는
        case Neutral    // 일반
        case Grin       // 활짝웃는
        case Smile      // 미소
        
        func sadderMouth() -> Mouth{
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        func happerMouth() -> Mouth{
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
    var eyes: Eyes
    var eyeBrows: EyeBrows
    var mouth: Mouth
    
}
