//
//  MailboxViewController.swift
//  MailboxDemo
//
//  Created by Loren Heiman on 9/24/14.
//  Copyright (c) 2014 Loren Heiman. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
   
    @IBOutlet weak var messageImageView: UIImageView!
    
    var imageCenter: CGPoint!

  
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: 320, height: 1202+86+42+37+65)
        // Do any additional setup after loading the view.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   
    @IBAction func panOnMessage(panGestureRecognizer: UIPanGestureRecognizer) {
        var point = panGestureRecognizer.locationInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
       
      
    
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            
              imageCenter  = messageImageView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
             messageImageView.center.x = translation.x + imageCenter.x
            println("Gesture changed at: \(point)")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
        }
        
    }
  
          /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
