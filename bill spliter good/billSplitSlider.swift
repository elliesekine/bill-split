//
//  billSplitSlider.swift
//  bill spliter good
//
//  Created by Ellie Sekine on 2019-06-15.
//  Copyright © 2019 Ellie Sekine. All rights reserved.
//

import UIKit

class billSplitSlider: UIControl {
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    var minimumValue: CGFloat = 0
    var maximumValue: CGFloat = 1
    
    var firstValue: CGFloat = 0.25
    var secondValue: CGFloat = 0.5
    var thirdValue: CGFloat = 0.75

    
    
    private let trackLayer = CALayer()
    private let thumbImageOne = UIImageView()
    private let thumbImageTwo = UIImageView()
    private let thumbImageThree = UIImageView()
    private var previousLocation = CGPoint()
    
    var thumbImage: UIImage? = #imageLiteral(resourceName: "Screen Shot 2019-06-15 at 6.23.51 PM")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        thumbImageOne.image = thumbImage
        addSubview(thumbImageOne)
        
        thumbImageTwo.image = thumbImage
        addSubview(thumbImageTwo)
        
        thumbImageThree.image = thumbImage
        addSubview(thumbImageThree)
        
        updateLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 1
    private func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        thumbImageOne.frame = CGRect(origin: thumbOriginForValue(firstValue),
                                     size: thumbImage!.size)
        
        thumbImageTwo.frame = CGRect(origin: thumbOriginForValue(secondValue),
                                     size: thumbImage!.size)
        
        thumbImageThree.frame = CGRect(origin: thumbOriginForValue(thirdValue),
                                       size: thumbImage!.size)
    }
    // 2
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    // 3
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - (thumbImage?.size.width)! / 2.0
        return CGPoint(x: x, y: (bounds.height - (thumbImage?.size.height)!) / 2.0)
    }
    

}



extension billSplitSlider {
    
    private func boundValue(_ value: CGFloat, toLowerValue firstValue: CGFloat,
                            secondValue: CGFloat, thirdValue: CGFloat) -> CGFloat {
        return min(max(value, firstValue), secondValue, thirdValue)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // 1
        previousLocation = touch.location(in: self)
        
        // 2
        if thumbImageOne.frame.contains(previousLocation) {
            thumbImageOne.isHighlighted = true
        } else if thumbImageTwo.frame.contains(previousLocation) {
            thumbImageTwo.isHighlighted = true
        } else if thumbImageThree.frame.contains(previousLocation) {
            thumbImageThree.isHighlighted = true
        }
        
        // 3
        return thumbImageOne.isHighlighted || thumbImageTwo.isHighlighted || thumbImageThree.isHighlighted
    }
    
    
    /*
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        // 1
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        
        previousLocation = location
        
        // 2
        if thumbImageOne.isHighlighted {
            firstValue += deltaValue
            firstValue = boundValue(firstValue, toLowerValue: minimumValue,
                                    upperValue: secondValue)
        } else if thumbImageTwo.isHighlighted {
            secondValue += deltaValue
            secondValue = boundValue(secondValue, toLowerValue: firstValue,
                                    upperValue: maximumValue)
        } else if thumbImageThree.isHighlighted {
            thirdValue += deltaValue
            thirdValue = boundValue(thirdValue, toLowerValue: secondValue,
                                     upperValue: maximumValue)
        
        // 3
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        
        return true
    }
    
    */

}
