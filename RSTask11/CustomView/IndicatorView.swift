//
//  IndicatorView.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import UIKit

class IndicatorView: UIView {

    enum Style {
        case clock
        case checkmark
    }
    
    var style: Style = .clock {
        willSet {
            if newValue == .checkmark{
                imageView.image = .checkmark
            }
            else {
                imageView.image = .clock
            }
            
        }
    }
    
    private let imageView: UIImageView = UIImageView()
    private let contentView: UIView = UIView()

    init(frame: CGRect, _ forAnimation: Bool) {
        super.init(frame: frame)
        commonInit()
        if (forAnimation){
            imageView.frame = bounds.insetBy(dx: Constants.imageOffset, dy: Constants.imageOffset)
            layer.cornerRadius = frame.height / 2
            contentView.layer.cornerRadius = frame.height / 2
        }
        else {
            setupConstraints()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupConstraints()
    }
    
    enum Constants {
        static let imageOffset: CGFloat = 3.0
    }
    
    func commonInit(){
        contentView.addSubview(imageView)
        addSubview(contentView)

        imageView.tintColor = .cyanProcess
        imageView.image = .checkmark

        backgroundColor = .clear
        layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.needsDisplayOnBoundsChange = true
        layer.masksToBounds = false


        contentView.backgroundColor = .superWhite
        let layer1 = contentView.layer
        layer1.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.shadowOpacity = 1
        layer1.shadowRadius = 2
        layer1.shadowOffset = CGSize(width: -1, height: -1)
        layer1.needsDisplayOnBoundsChange = true
        layer1.masksToBounds = false
        
    }
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.imageOffset),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.imageOffset),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        contentView.layer.cornerRadius = frame.height / 2
    }
}
