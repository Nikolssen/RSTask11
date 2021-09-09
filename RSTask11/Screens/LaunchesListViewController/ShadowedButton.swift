//
//  ShadowedButton.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import UIKit

class ShadowedButton: UIButton {
    let layer1: CALayer = CALayer()
    
    override var buttonType: UIButton.ButtonType { return .custom }
    
    override var isHighlighted: Bool{
        willSet{
            if newValue {
                layer1.shadowOpacity = 0.0
                layer.shadowOpacity = 0.0
            }
            else {
                layer1.shadowOpacity = 1.0
                layer.shadowOpacity = 1.0
            }
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit(){
        backgroundColor = .superWhite
        setTitleColor(.coral, for: .normal)
        setTitleColor(.champagne, for: .highlighted)
        titleLabel?.font = .robotoMedium17
        backgroundColor = .superWhite
        
        layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.needsDisplayOnBoundsChange = true
        layer.masksToBounds = false
        
        layer1.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.shadowOpacity = 1
        layer1.shadowRadius = 2
        layer1.shadowOffset = CGSize(width: -1, height: -1)
        layer1.needsDisplayOnBoundsChange = true
        layer1.masksToBounds = false
        
        layer1.insertSublayer(layer, at: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer1.cornerRadius = frame.height / 2
        layer.cornerRadius = frame.height / 2
        layer1.frame = layer.bounds
    }
}
