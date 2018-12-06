//
//  CanvasViewController.swift
//  EmojiKeyboard
//
//  Created by Trustin Harris on 4/27/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    @IBOutlet weak var trayView: UIView!
    var IV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDownOffset = 190
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
       
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
            
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            if velocity.y > 0.0 {
                self.trayView.center = self.trayDown
            } else {
                self.trayView.center = self.trayUp
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
 
        
        if sender.state == .began {
            IV = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: IV.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = IV.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            newlyCreatedFace.isUserInteractionEnabled = true
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(PanFaces(sender:)))
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }

    }
    
    @objc func PanFaces(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView // to get the face that we panned on.
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
            
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            
        }
    }
    
    
}
