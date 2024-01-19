//
//  SharedUitility.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import UIKit

final class SharedUtility {
    static let utility = SharedUtility()
    private init() {}
    
    func showAlert(message : String,
                   actionTitle: String,
                   onVC: UIViewController) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: AppName, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
            onVC.present(alertController, animated: true, completion: nil)
        }
    }

    func showCustomAlert(title: String?,
                         message: String,
                         cancelTitle: String?,
                         okTitle: String,
                         onVC: UIViewController,
                         completion: @escaping (Bool) -> Void) {

        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title ?? AppName, message: message, preferredStyle: .alert)
            if let cancel = cancelTitle {
                alertController.addAction(UIAlertAction(title: cancel, style: .default, handler: { (action) in
                    completion(false)
                }))
            }
            alertController.addAction(UIAlertAction(title: okTitle, style: okTitle == "Logout" ? .destructive : .default, handler: { (action) in
                completion(true)
            }))
            onVC.present(alertController, animated: true, completion: nil)
        }
    }
    
    func isValidEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
}
