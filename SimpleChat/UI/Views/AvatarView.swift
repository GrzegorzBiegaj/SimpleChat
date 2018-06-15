//
//  AvatarView.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 13.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

struct Avatar {

    let character: Character
    let backgroundColor: UIColor
    let fontColor: UIColor
}

@IBDesignable
class AvatarView: UIView {

    @IBInspectable var letterString: String?
    @IBInspectable var letterBackgroundColor: UIColor?
    @IBInspectable var letterColor: UIColor?

    private var font = UIFont.systemFont(ofSize: 20)
    private var imageFrameSize: CGFloat = 2.0

    var avatar: Avatar? {

        didSet {
            if let avatar = avatar {
                letterString = String(avatar.character)
                letterBackgroundColor = avatar.backgroundColor
                letterColor = avatar.fontColor
            }
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {

        backgroundLayer()
        stringLayer()
    }

    func backgroundLayer() {

        layer.sublayers?.removeAll()
        var backgroundLayer: CAShapeLayer
        backgroundLayer = CAShapeLayer()
        layer.addSublayer(backgroundLayer)
        let rect = bounds.insetBy(dx: 0, dy: 0)
        let path = UIBezierPath(ovalIn: rect)
        backgroundLayer.path = path.cgPath
        if let letterBackgroundColor = letterBackgroundColor {
            backgroundLayer.fillColor = letterBackgroundColor.cgColor
        }
        backgroundLayer.frame = layer.bounds
    }

    func stringLayer() {

        let textLayer = CATextLayer()
        textLayer.string = letterString
        textLayer.fontSize = font.pointSize
        let fontName: CFString = font.fontName as CFString
        textLayer.font = CTFontCreateWithName(fontName, 0, nil)
        if let color = letterColor?.cgColor {
            textLayer.foregroundColor = color
        }
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        textLayer.frame = CGRect(x: layer.bounds.origin.x, y: (layer.bounds.height - font.lineHeight) / 2, width: layer.bounds.width, height: font.lineHeight)
        layer.addSublayer(textLayer)
    }

}
