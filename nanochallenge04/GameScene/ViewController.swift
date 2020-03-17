//
//  ViewController.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 14/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import SwiftUI
class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let childView = GameViewController()
        let childView = UIHostingController(rootView: MenuView())
        addChild(childView)
        childView.view.frame = view.bounds
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
        
    }
}
