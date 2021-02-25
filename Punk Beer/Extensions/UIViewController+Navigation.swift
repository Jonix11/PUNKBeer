//
//  UIViewController+Navigation.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 25/2/21.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
