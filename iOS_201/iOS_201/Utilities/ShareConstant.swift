//
//  ShareConstant.swift
//  iOS_201
//
//  Created by 유준용 on 11/22/23.
//

import Foundation
import UIKit

struct ShareConstant {
    private init(){}
    static var shared = ShareConstant()
    
    /// 임시방편
    let naviBarAndTopSafeAreaHeight = 44 + (UIApplication.shared.windows.first?.safeAreaInsets.top)!
}
