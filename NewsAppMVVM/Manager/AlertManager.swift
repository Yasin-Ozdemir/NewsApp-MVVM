//
//  AlertManager.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 9.02.2024.
//

import Foundation
import UIKit

class AlertManager{
    private init(){
        
    }
    
    static let manager = AlertManager()
    
    func showAlert(title :String , message : String) -> UIAlertController{
        var alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        
        alertController.addAction(alertAction)
        
        return alertController
        
    }
}
