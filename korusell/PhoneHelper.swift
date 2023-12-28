//
//  PhoneHelper.swift
//  korusell
//
//  Created by Sergey Li on 12/26/23.
//

import SwiftUI

final class PhoneHelper {
    static let shared = PhoneHelper()
    
    func call(_ phone: String) {
        let prefix = "tel://"
        let phoneNumberformatted = prefix + phone
        guard let url = URL(string: phoneNumberformatted) else { return }
        UIApplication.shared.open(url)
        //        }
    }
    
    func sendSMS(_ phone: String) {
        let sms: String = "sms:\(phone)"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
}
