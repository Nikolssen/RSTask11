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
        case status(String)
        case empty
    }
    
    private let label: UILabel = UILabel()
    private let contentView: UIView = UIView()
    
    var style: ShadowedView.Style = .empty {
        willSet{
            switch newValue {
            case .empty:
                label.text = ""
            case .status(let status):
                label.text = status.capitalized
            case .number(let number):
                label.text = "#" + number
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        label.frame = bounds.insetBy(dx: Constants.horizontalOffset, dy: Constants.verticalOffset)
        contentView.frame = bounds
        layer.cornerRadius = frame.height / 2
        contentView.layer.cornerRadius = frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalOffset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalOffset),
            widthAnchor.constraint(equalTo: label.widthAnchor, multiplier: 1.0, constant: Constants.horizontalOffset * 2)

        ])
    }

    
    func commonInit(){
        contentView.addSubview(label)
        addSubview(contentView)

        label.textColor = .cyanProcess
        label.font = .robotoMedium17
        

        backgroundColor = .clear
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.needsDisplayOnBoundsChange = true
        layer.masksToBounds = false


        contentView.backgroundColor = .superWhite
        let layer1 = contentView.layer
        layer1.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.shadowOpacity = 1
        layer1.shadowRadius = 1.5
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
