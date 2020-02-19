//
//  ViewController.swift
//  Heatmap-POC
//
//  Created by Natasha Solanki on 2/18/20.
//  Copyright © 2020 Natasha Solanki. All rights reserved.
//

import UIKit
import EasyTipView

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


@IBDesignable public class RoundedView: UIView, EasyTipViewDelegate {
    var button = UIButton()
    var toolTip: EasyTipView?
    var preferences = EasyTipView.Preferences()
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          commonInit()
     }

     required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          commonInit()
     }
    
    private func commonInit() {
        button.frame = self.bounds
        self.addSubview(button)
        button.addTarget(self, action: #selector(onViewClick), for: .touchUpInside)
        
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 11)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = self.backgroundColor ?? UIColor.green
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.bottom
        preferences.drawing.shadowColor = UIColor.gray
        preferences.drawing.shadowOpacity = 1
        preferences.drawing.arrowHeight = 0
        preferences.drawing.arrowWidth = 0

        EasyTipView.globalPreferences = preferences
        
    }

    @objc func onViewClick(){
        if let tip = toolTip {
            tip.dismiss(withCompletion: {
                self.toolTip = nil
            })
        } else {
            let view = EasyTipView(text: "10AM\n$0.56", preferences: preferences)
            view.show(forView: self.button, withinSuperview: self.superview)
            toolTip = view
        }
       
    }
    
    public func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        print("did close view")
    }


}
