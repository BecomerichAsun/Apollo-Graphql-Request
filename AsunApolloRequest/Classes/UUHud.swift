//
//  UUHud.swift
//  UUTeacher
//
//  Created by Derrick on 2018/11/13.
//  Copyright © 2018年 bike. All rights reserved.
//

import UIKit
import YYImage

public class UUHud: UIView {
    
    private var animatImageV:YYAnimatedImageView?

    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubview()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubview() {
        let image = YYImage(named: "loading")
        animatImageV = YYAnimatedImageView(image: image)
        animatImageV?.alpha = 0
        addSubview(animatImageV!)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        animatImageV?.frame = CGRect(x: screenWidth/2-75, y: screenHeight/2-75, width: 150, height: 150)
    }
    @objc public class func showHud() {
        self.showHud(inView: UIApplication.shared.keyWindow!)
    }
    
    @objc public class func showHud(inView:UIView) {
        for view in inView.subviews {
            if view.isKind(of: UUHud.self) {
                return
            }
        }
        let hud = UUHud()
        hud.frame = inView.bounds
        inView.addSubview(hud)
        hud.animatImageV?.transform = CGAffineTransform(scaleX: CGFloat(0.8), y: CGFloat(0.8))
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: UIView.AnimationOptions.curveEaseOut, animations: {
            hud.animatImageV?.alpha = 1
            hud.animatImageV?.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
    }
    
    @objc public class func hideHud(){
        self.hideHud(inView: UIApplication.shared.keyWindow!)
    }
    
    @objc public class func hideHud(inView:UIView){
        for view in inView.subviews {
            if view.isKind(of: UUHud.self) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    for view in inView.subviews {
                        if view.isKind(of: UUHud.self) {
                            view.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
}

