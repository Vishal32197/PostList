//
//  LazyLabel.swift
//  UserListDemo
//
//  Created by Bishal Ram on 26/04/24.
//

import UIKit

class LazyLabel: UILabel {
    
    private let labelCache = NSCache<AnyObject, NSString>()
    
    func loadContent(_ text: String) {
        
        DispatchQueue.main.async {
            if let cachedText = self.labelCache.object(forKey: text as AnyObject) {
                self.text = cachedText as String
            } else {
                self.labelCache.setObject(text as NSString, forKey: text as AnyObject)
                self.text = text
            }
        }
    }
}
