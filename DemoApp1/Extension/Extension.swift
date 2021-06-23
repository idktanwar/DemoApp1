//
//  UIAlertController + Extension.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 22/06/21.
//

import Foundation
import UIKit

//MARK:- UIViewController
extension UIViewController {
    
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    
}

//MARK:- Date

extension Date {
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        let date1String = dateFormatter.string(from: self as Date)
        return date1String
    }
    
    func isBetween(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self as Date).rawValue * self.compare(date2 as Date).rawValue >= 0
    }
}

//MARK:- UIColor

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1), green: .random(in: 0.4...1), blue: .random(in: 0.4...1), alpha: 1)
    }
    
    static var randomFade: UIColor {
        return UIColor(red: .random(in: 0.4...1), green: .random(in: 0.4...1), blue: .random(in: 0.4...1), alpha: 0.14)
    }
}
