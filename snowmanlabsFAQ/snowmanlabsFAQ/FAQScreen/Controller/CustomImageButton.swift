//
//  CustomImageButton.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 22/03/21.
//

import UIKit

@IBDesignable
class CustomImageButton: UIButton {
    // MARK: - Properties
     @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
     }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //Position image and text correctly
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            let isUserOnPhone = (UIDevice.current.userInterfaceIdiom == .phone)
            let buttonInsideMargin: CGFloat = isUserOnPhone ? 16 : 32
            let imageViewHeight: CGFloat = isUserOnPhone ? 20 : 32
            let imageViewWidth: CGFloat = isUserOnPhone ? 20 : 32
            let imageCenterX = (self.frame.height/2) - (imageViewHeight/2)
            
            //Size image
            imageView?.frame = CGRect(x: self.imageView!.frame.origin.x, y: self.imageView!.frame.origin.y, width: imageViewWidth, height: imageViewHeight)
            
            //Position on right side
            imageEdgeInsets = UIEdgeInsets(top: imageCenterX, left: (bounds.width - buttonInsideMargin - imageViewWidth), bottom: imageCenterX, right: 5)
            
            //Move text to fit with image
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: imageViewWidth)
        }
    }

}
