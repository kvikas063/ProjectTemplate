//
//  View+Ext.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import UIKit

extension UIView {
    
    func pinToView(_ edges: [Direction] = [.left, .right, .top, .bottom ],
                   fromEdge : [Direction : CGFloat] = [.left: 0, .right: 0, .top: 0, .bottom: 0]) {
        guard let superView = superview else { return }
        edges.forEach {
            switch $0 {
                
            case .top:
                topAnchor.constraint(equalTo: superView.topAnchor, constant: fromEdge[.top] ?? 0).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: fromEdge[.bottom] ?? 0).isActive = true
            case .left:
                leftAnchor.constraint(equalTo: superView.leftAnchor, constant: fromEdge[.left] ?? 0).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superView.rightAnchor, constant: fromEdge[.right] ?? 0).isActive = true
                
            }
        }
    }

    func addSubView<T: UIView>(_ subview: T, constraintsToActivate: (_ subview: T, _ superview: UIView) -> [NSLayoutConstraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(constraintsToActivate(subview, self))
    }

    func addTopShadow(_ radius: CGFloat = 12) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -radius)
        self.layer.shadowOpacity = 0.07
    }
    
    func addTopNavBarShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.layer.shadowOpacity = 0.1
    }

    func shadowBorderForHAView() {
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
    }

    func customHABorderSetup(needBorder: Bool) {
        if needBorder {
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 0.5
        }
        layer.cornerRadius = 10
    }

    func setShadowWithColor(
        color: UIColor?,
        opacity: Float?,
        offset: CGSize?,
        radius: CGFloat,
        cornerRadius: CGFloat? = nil
    ) {
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
        layer.cornerRadius = cornerRadius ?? layer.cornerRadius
    }

    /// If you are calling this on a UITableViewCell,
    /// it is recommended that you call this method in the `layoutSubViews` override
    func makeCircular() {
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }

    func round(corners: UIRectCorner, cornerRadius: Double) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }

    func addDashedBorder(
        _ color: UIColor = UIColor.black,
        withWidth width: CGFloat = 2,
        cornerRadius: CGFloat = 5,
        dashPattern: [NSNumber] = [3,6]
    ) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    func applyRoundCorner(
        radius: Float,
        borderWidth: Float,
        borderColor: UIColor?
    ) {
        self.layer.masksToBounds = true
        if borderWidth > 0 {
            self.layer.borderWidth = CGFloat(borderWidth)
            self.layer.borderColor = borderColor?.cgColor
        }
        self.layer.cornerRadius = CGFloat(radius)
    }
}

enum Direction {
    case left
    case right
    case bottom
    case top
}

// Gradiant effect. This code works only in Swift codebase
enum GradientDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

extension CAGradientLayer {

    func setPoints(with direction: GradientDirection) {
        switch direction {
        case .leftToRight:
            startPoint = CGPoint(x: 0.0, y: 0.5)
            endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            startPoint = CGPoint(x: 1.0, y: 0.5)
            endPoint = CGPoint(x: 0.0, y: 0.5)
        case .bottomToTop:
            startPoint = CGPoint(x: 0.5, y: 1.0)
            endPoint = CGPoint(x: 0.5, y: 0.0)
        case .topToBottom:
            startPoint = CGPoint(x: 0.5, y: 0.0)
            endPoint = CGPoint(x: 0.5, y: 1.0)
        }
    }
}

@objc extension UIView {

    func loadNib(nibName: String, bundle: Bundle) -> UIView {
        let nib = UINib(nibName: nibName, bundle: bundle)
        if let xibView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return xibView
        }
        return UIView()
    }

    func largerDropShadow() {
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.1
        clipsToBounds = false
    }

    func roundedCorners(radius: Int) {
        layer.cornerRadius = CGFloat(radius)
        clipsToBounds = true
    }

    func setAsAvatarBackground(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius / 2
        clipsToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
    }

    func roundCorners(
        withRadius radius: CGFloat,
        borderColor: UIColor = .clear,
        andBorderWidth borderWidth: CGFloat = 0
    ) {
        layer.cornerRadius = radius
        clipsToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}

protocol InitWithFrame {
    init(frame: CGRect)
}

extension InitWithFrame {
    static var zero: Self { .init(frame: .zero) }
}

extension UIView: InitWithFrame {}

extension UIView {

    var constraintsReady: Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    var scaleAspectFit: Self {
        contentMode = .scaleAspectFit
        return self
    }
}
