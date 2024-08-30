//
//  Extesnion + CornerRadius.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation
import UIKit


extension UIView {
    
    func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
 
}
