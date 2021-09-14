//
//  ShadowedView.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/9/21.
//

import UIKit

class ShadowedView: UIView {
    
    enum Constants {
        static let horizontalOffset: CGFloat = 10.0
        static let verticalOffset: CGFloat = 5.0
    }
    
    enum Style {
        case number(String)
        case retired
        case active
    }
    
    private let label: UILabel = UILabel()
    private let contentView: UIView = UIView()
    
    var style: ShadowedView.Style = .active {
        willSet{
            switch newValue {
            case .active:
                label.text = "Active"
            case .retired:
                label.text = "Retired"
            case .number(let number):
                label.text = "#" + number
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    

    
    func commonInit(){
        contentView.addSubview(label)
        addSubview(contentView)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cyanProcess
        label.font = .robotoMedium17
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalOffset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalOffset),
            widthAnchor.constraint(equalTo: label.widthAnchor, multiplier: 1.0, constant: Constants.horizontalOffset * 2)
        ])
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        contentView.layer.cornerRadius = frame.height / 2
    }
}
