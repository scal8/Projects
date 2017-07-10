//
//  CueingSetupScreen2.swift
//  TMR App
//
//  Created by Robert Zhang on 7/6/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

//to choose 25%, 50%, 75%, 100% to be targeted

import Foundation
import SpriteKit

class TMRModelCueingSetupAuto:TMRModel{
    
    var field = UITextField()
    var next = SKSpriteNode()
    var prev = SKSpriteNode()
    
    override func begin(screen : TMRScreen, context : TMRContext,view:SKView) {
        super.begin(screen: screen, context: context)
        screen.clearScreen()
        
        let title = SKLabelNode(position: CGPoint(x:screen.frame.width/2,y:screen.frame.height-30), zPosition: 2, text: "Choose % Sample Size to be Randomly Cued", fontColor: UIColor(red:97/255,green:175/255,blue:175/255,alpha:1), fontName: "Arial Bold", fontSize: 30, verticalAlignmentMode: .top, horizontalAlignmentMode: .center)
        screen.addChild(title)
        
        field = UITextField(text: "", placeholder: "% Sounds to be Cued 0-100 (default: 50)", font: "Arial Bold", fontSize: 300, textColor: .black, textAlignment: .center, border: .roundedRect, adjustToFit: false, rect: CGRect(x: view.frame.width/2, y: view.frame.height*0.3, width: screen.frame.width/2, height: screen.frame.width/20))
        field.center = CGPoint(x:view.frame.width/2, y: view.frame.height*0.3)
        view.addSubview(field)
        
        next = SKSpriteNode(imageName: "done", ySize: screen.frame.height/7, anchorPoint: CGPoint(x:0.5,y:0.5), position: CGPoint(x:screen.frame.width/2+screen.frame.height/14+10,y:screen.frame.height*0.3), zPosition: 2, alpha: 1)
        screen.addChild(next)
        
        prev = SKSpriteNode(imageName: "PrevIcon", ySize: screen.frame.height/7, anchorPoint: CGPoint(x:0.5,y:0.5), position: CGPoint(x:screen.frame.width/2-screen.frame.height/14-10,y:screen.frame.height*0.3), zPosition: 2, alpha: 1)
        screen.addChild(prev)
    }
    
    override func timerTick(screen : TMRScreen, context : TMRContext) {
        
    }
    
    
    override func touch(screen : TMRScreen, context:TMRContext, position: CGPoint) {
        if prev.contains(position){
            field.removeFromSuperview()
            context.nextModel = .CueingSetup
        }
        if next.contains(position){
            context.setupPassed[5] = true
            if let text = field.text{
                if let num = Int(text){
                    if num >= 0 && num <= 100{
                        let setting = context.project.getGuiSetting()
                        setting.setCuedPercent(num:num)
                        context.project.setGuiSetting(guiSetting: setting)
                    }else{
                        let setting = context.project.getGuiSetting()
                        setting.setCuedPercent(num:50)
                        context.project.setGuiSetting(guiSetting: setting)
                    }
                }else{
                    let setting = context.project.getGuiSetting()
                    setting.setCuedPercent(num:50)
                    context.project.setGuiSetting(guiSetting: setting)
                }
            }else{
                let setting = context.project.getGuiSetting()
                setting.setCuedPercent(num:50)
                context.project.setGuiSetting(guiSetting: setting)
            }
            field.removeFromSuperview()
            context.nextModel = .Settings
            print(context.project.getGuiSetting().getCuedPercent())
        }
    }
    
    override func end(screen : TMRScreen, context : TMRContext){
        
    }
}
