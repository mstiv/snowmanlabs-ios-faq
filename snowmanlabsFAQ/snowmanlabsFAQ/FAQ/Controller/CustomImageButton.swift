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
            imageView?.frame = CGRect(x: self.imageView!.frame.origin.x, y: self.imageView!.frame.origin.y, width: 20, height: 20)
            imageEdgeInsets = UIEdgeInsets(top: self.imageView!.frame.height/2, left: (bounds.width - 35), bottom: self.imageView!.frame.height/2, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }

}
