//
//  ShadowedMapView.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/14/21.
//

import UIKit
import MapKit

class ShadowedMapView: UIView {
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isUserInteractionEnabled = false
        return mapView
    }()
    
    private lazy var whiteShadow: CALayer = {
        let shadow1 = CALayer()
        shadow1.shadowColor = UIColor.white.cgColor
        shadow1.shadowOffset = CGSize(width: -2, height: -2)
        shadow1.shadowOpacity = 1
        shadow1.shadowRadius = 1.5
        shadow1.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
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
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
        
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        layer.cornerRadius = 15
        mapView.layer.cornerRadius = 15
        layer.addSublayer(whiteShadow)
        
        layer.insertSublayer(whiteShadow, at: 0)
        
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        whiteShadow.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    }
    
}
