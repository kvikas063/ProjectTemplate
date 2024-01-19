//
//  CustomAlertView.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import UIKit

final public class CustomAlertView: UIView {

    static let sharedAlertView = CustomAlertView.init(frame: .zero)
    
    public func dismissAlert(alertView: UIView, completionBlock: (() -> Void)?) {
        alertView.transform = CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.backgroundColor = UIColor(white: 0, alpha: 0)
            alertView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            alertView.layer.opacity = 0
            
        }, completion: {(finished: Bool) -> Void in
            self.removeFromSuperview()
            if let cb = completionBlock {
                cb()
            }
        })
    }
    
    public func showCustomAlert(alertView : UIView) {
        if let activeWindow = UIApplication.shared.windows.last {
            self.frame = activeWindow.bounds
            alertView.center = self.center
            self.backgroundColor = UIColor(white: 0, alpha: 0)
            self.addSubview(alertView)
            activeWindow.addSubview(self)
            
            alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3);
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.backgroundColor = UIColor(white: 0, alpha: 0.5)
                alertView.layer.opacity = 1
                alertView.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }, completion: nil)
        }
    }
}
