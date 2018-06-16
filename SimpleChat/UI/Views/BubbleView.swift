//
//  BubbleView.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 13.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

@IBDesignable
class BubbleView: UIView {

    fileprivate let leftInsets = UIEdgeInsets(top: 15 , left: 22, bottom: 15, right: 15)
    fileprivate let rightInsets = UIEdgeInsets(top: 15 , left: 15, bottom: 15, right: 22)

    // MARK: - Properties

    @IBInspectable var image: UIImage?

    var side: Side? {
        didSet {
            image = side == .received ? UIImage(named: "bubble_nine_white") : UIImage(named: "bubble_nine_orange")
        }
    }

    var insetsForImageSize: UIEdgeInsets {
        return side == .received ? leftInsets : rightInsets
    }

    override func layoutSubviews() {

        super.layoutSubviews()

        for view in subviews {
            view.removeFromSuperview()
        }

        if let image = image {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
            imageView.image = image.resizableImage(withCapInsets: insetsForImageSize, resizingMode: .stretch)
            addSubview(imageView)
        }
    }

}
