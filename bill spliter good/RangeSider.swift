//
//  RangeSider.swift
//  bill spliter good
//
//  Created by Ellie Sekine on 2019-06-15.
//  Copyright © 2019 Ellie Sekine. All rights reserved.
//

import UIKit
@IBDesignable
class RangeSlider: UISlider {

    @IBInspectable var thumbImage: UIImage?{
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = 50

        return newBounds
    }
    
   

}
