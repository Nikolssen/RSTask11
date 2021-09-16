//
//  ShadowedImageView.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import UIKit

class ShadowedImageView: UIView {

    let imageView: UIImageView = UIImageView()
    private let contentView: UIView = UIView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    enum Constants {
        static let verticalOffset: CGFloat = 15.0
        static let horizontalOffset: CGFloat = 9.0
    }
    
    func commonInit(){
        contentView.addSubview(imageView)
        addSubview(contentView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .cyanProcess
        imageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalOffset),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalOffset),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        backgroundColor = .clear
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.needsDisplayOnBoundsChange = true
        layer.masksToBounds = false


        contentView.backgroundColor = .superWhite
        let layer1 = contentView.layer
        layer1.shadowColor = UIColor.white.cgColor
        layer1.shadowOpacity = 1
        layer1.shadowRadius = 2
        layer1.shadowOffset = CGSize(width: -1, height: -1)
        layer1.needsDisplayOnBoundsChange = true
        layer1.masksToBounds = false
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        contentView.layer.cornerRadius = 20
    }
}
