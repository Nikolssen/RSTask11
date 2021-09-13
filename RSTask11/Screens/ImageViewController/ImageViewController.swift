//
//  ImageViewController.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/13/21.
//
import UIKit
class ImageViewController: UIViewController {
    
    let crossButton = ShadowedButton()
    let imageScrollView = UIScrollView()
    let imageView = UIImageView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        crossButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.delegate = self
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageScrollView)
        view.addSubview(crossButton)
        imageScrollView.addSubview(imageView)
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(showCloseButton)))
        
        crossButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            imageScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            crossButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            crossButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            crossButton.heightAnchor.constraint(equalToConstant: 40),
            crossButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        crossButton.setImage(.cross, for: .normal)
        crossButton.setImage(.cross, for: .highlighted)
        crossButton.setTitle("", for: .normal)
        crossButton.setTitle("", for: .highlighted)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let scale = zoomScale()
        imageScrollView.zoomScale = scale
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageScrollView.contentSize = imageView.bounds.size
        let scale = zoomScale()
        let boundsSize = UIScreen.main.bounds.size
        if boundsSize.width < boundsSize.height {
            let actualImageHeight = (imageView.image?.size.height)! * scale
            imageScrollView.contentInset = UIEdgeInsets(top: (view.safeAreaLayoutGuide.layoutFrame.height - actualImageHeight) * 0.5, left: 0, bottom: 0, right: 0)
        }
        else {
            let actualImageWidth = (imageView.image?.size.width)! * scale
            imageScrollView.contentInset = UIEdgeInsets(top: 0, left: (view.safeAreaLayoutGuide.layoutFrame.width  - actualImageWidth ) * 0.5, bottom: 0, right: 0)
        }
        
    }
    
    func zoomScale() -> CGFloat {
        let widthScale = view.safeAreaLayoutGuide.layoutFrame.width / imageView.image!.size.width
        let heightScale = view.safeAreaLayoutGuide.layoutFrame.height / imageView.image!.size.height
        let scale = min(widthScale, heightScale)
        
        imageScrollView.minimumZoomScale = scale
        imageScrollView.maximumZoomScale = 3 * scale
        imageScrollView.zoomScale = imageScrollView.minimumZoomScale
        return scale
    }
    
    @objc func showCloseButton(){
        crossButton.isHidden.toggle()
    }
    
    @objc func dismissModal(){
        dismiss(animated: true, completion: nil)
    }
    
}

extension ImageViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}
