//
//  ShadowedButton.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import UIKit

class  ShadowedButton: UIButton {
    
    private var imageWidth: CGFloat {
        self.imageView!.frame.width
    }
    
    private var textWidth: CGFloat {
        let attributes = [NSAttributedString.Key.font: UIFont.robotoMedium17]
        return (titleLabel?.text as NSString?)!.size(withAttributes: attributes).width
    }
    
    private var leftRightMargin: CGFloat = 10
    private var imageInset: CGFloat = 5
    
    private lazy var whiteShadow: CALayer = {
        let shadow1 = CALayer()
        shadow1.shadowColor = UIColor.white.cgColor
        shadow1.shadowOffset = CGSize(width: -2, height: -2)
        shadow1.shadowOpacity = 1
        shadow1.shadowRadius = 1.5
        shadow1.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        return shadow1
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit(){
        setTitleColor(.coral, for: .normal)
        setTitleColor(.champagne, for: .highlighted)
        titleLabel?.font = .robotoMedium17
        tintColor = .coral
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius =  16
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        imageView?.layer.masksToBounds = true
        let tintedImage = UIImage.hyperlink.withRenderingMode(.alwaysTemplate)
        setImage(tintedImage, for: .normal)
        semanticContentAttribute = .forceRightToLeft
        sizeToFit()
        
        layer.insertSublayer(whiteShadow, at: 0)
        
        layer.shadowColor = UIColor.smockyBlack.cgColor
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 3
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageEdgeInsets = UIEdgeInsets(top: 0, left: imageInset, bottom: 0, right: 0)
        contentEdgeInsets = UIEdgeInsets(top: 5, left: leftRightMargin, bottom: 5, right: leftRightMargin)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        whiteShadow.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    }

    override var isHighlighted: Bool {
        willSet {
            if newValue {
                tintColor = .champagne
                imageView?.tintColor = .champagne
                layer.shadowColor = UIColor.clear.cgColor
            } else {
                tintColor = .coral
                imageView?.tintColor = .coral
                layer.shadowColor = UIColor.smockyBlack.cgColor
            }
        }
    }
}
