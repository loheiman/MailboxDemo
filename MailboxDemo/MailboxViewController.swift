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
    
    

    
    @IBOutlet weak var edgeOfMessageUIView: UIView!
    @IBOutlet weak var contentUIView: UIView!
    @IBOutlet weak var messageContainerImageView: UIView!
    @IBOutlet weak var rescheduleScreenImageView: UIImageView!
    @IBOutlet weak var listScreenImageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var archiveDeleteImageView: UIImageView!
    @IBOutlet weak var laterListImageView: UIImageView!
   
    @IBOutlet weak var messageImageView: UIImageView!
    
    var messageImageCenter: CGPoint!
    var archiveDeleteImageCenter: CGPoint!
    var contentViewCenter: CGPoint!
    var laterListImageCenter: CGPoint!
    var messageDisplacement = CGFloat()

    
    
    // COLOR DEFINITIONS
    let lightGray = UIColor (white: 0.7, alpha: 1.0)
    let yellow = UIColor (red: 0.95, green: 0.95, blue: 0.0, alpha: 1.0)
    let green = UIColor (red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0)
    let red = UIColor (red: 0.9, green: 0.0, blue: 0.0, alpha: 1.0)
    let brown = UIColor (red: 205/255, green: 163/255, blue: 63/255, alpha: 1.0)




  
    override func viewDidLoad() {
        super.viewDidLoad()

        laterListImageView.alpha = 0.0
        archiveDeleteImageView.alpha = 0.0
        
        messageBackgroundView.backgroundColor = lightGray
            
        scrollView.contentSize = CGSize(width: 320, height: 1202+86+42+37)
        
        
        
        // Do any additional setup after loading the view.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    
    // CLOSING THE GAP LEFT BY MESSAGE
    
    func closeMessageGap () -> Void {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.feedImageView.transform = CGAffineTransformTranslate(self.feedImageView.transform, 0, -86)
            }) { (finished: Bool) -> Void in
                self.messageContainerImageView.hidden = true
                self.scrollView.contentSize = CGSize(width: 320, height: 1202+86+42+37 - 86)
        }
    }
    

    
    
    
    // OPENING AND CLOSING  DRAWER, ADJUSTING ANIMATION TIME BASED ON DRAWER LOCATION
    
    
    func openDrawerWithLocation(location: CGFloat) -> Void {
        var animateTime = NSTimeInterval(0.3 * ((280 - location) / 280))
        println("animateTime \(animateTime)")
        println("location \(location)")
        UIView.animateWithDuration(animateTime, animations: { () -> Void in
            self.contentUIView.frame.origin.x = 280
        })

        
    }
    
    
    func closeDrawerWithLocation(location: CGFloat) -> Void {
        var animateTime = NSTimeInterval(0.3 * (location / 280))
        UIView.animateWithDuration(animateTime, animations: { () -> Void in
            self.contentUIView.frame.origin.x = 0
            println("animateTime \(animateTime)")
            println("location \(location)")

        })
    }
    
    
    /* BASIC OPENING AND CLOSING DRAWER, NOT IN USE
    
    func openDrawer() -> Void {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.contentUIView.frame.origin.x = 280
        })
    }
    
    func closeDrawer() -> Void {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.contentUIView.frame.origin.x = 0
        })
    }

*/
    
   // OPEN CLOSE VIA NAV ICON
    
    @IBAction func onNavTap(sender: AnyObject) {
        if self.contentUIView.frame.origin.x == 0 {
            openDrawerWithLocation(CGFloat(contentUIView.frame.origin.x))

        }
            
        else {
            closeDrawerWithLocation(CGFloat(contentUIView.frame.origin.x))

        }
    }
    
    // CLOSING DRAWER BY TAPPING ON CONTENT
    
    @IBAction func viewEdgeTap(sender: UITapGestureRecognizer) {
        if self.contentUIView.frame.origin.x == 280 {
            closeDrawerWithLocation(CGFloat(contentUIView.frame.origin.x))

        }
    }

    
   
    
  
    @IBAction func edgePanGesture(edgePanGestureRecognizer: UIPanGestureRecognizer) {
        
        
        
       
        var translation = edgePanGestureRecognizer.translationInView(view)
        var velocity = edgePanGestureRecognizer.velocityInView(view)
        
        if edgePanGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            contentViewCenter  = contentUIView.center
            
        } else if edgePanGestureRecognizer.state == UIGestureRecognizerState.Changed {
    
            contentUIView.center.x = translation.x + contentViewCenter.x
            
        } else if edgePanGestureRecognizer.state == UIGestureRecognizerState.Ended{
            
            if velocity.x > 0 {
                openDrawerWithLocation(CGFloat(contentUIView.frame.origin.x))
                
            } else if velocity.x < 0 {
                closeDrawerWithLocation(CGFloat(contentUIView.frame.origin.x))
                
            }
        }
        

    }
    
    

    
    // PAN GESTURE FOR MESSAGE
   
   
    @IBAction func panOnMessage(panGestureRecognizer: UIPanGestureRecognizer) {
        var point = panGestureRecognizer.locationInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        archiveDeleteImageView.alpha = CGFloat(convertValue(Float(messageDisplacement), r1Min: 0, r1Max: 100, r2Min: 0.0, r2Max: 1))
        laterListImageView.alpha = CGFloat(convertValue(Float(messageDisplacement), r1Min: 0, r1Max: -100, r2Min: 0.0, r2Max: 1))
        
       

      
    
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            println("Velocity is \(velocity)")
            messageImageCenter  = messageImageView.center
            laterListImageCenter = laterListImageView.center
            archiveDeleteImageCenter = archiveDeleteImageView.center
    
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            messageDisplacement = messageImageView.center.x - 160
            messageImageView.center.x = translation.x + messageImageCenter.x
            
        

              println("message displacement + \(messageDisplacement) ")
            
            
            if messageImageView.center.x > 220 {
                messageBackgroundView.backgroundColor = green
                archiveDeleteImageView.highlighted = false
                laterListImageView.hidden = true
                archiveDeleteImageView.center.x = messageDisplacement - 60 + 22.5
              
                if messageImageView.center.x > 400 {
                    messageBackgroundView.backgroundColor = red
                    archiveDeleteImageView.highlighted = true
                }
                
            }
                
            else if messageImageView.center.x < 100 {
                messageBackgroundView.backgroundColor = yellow
                laterListImageView.highlighted = false
                archiveDeleteImageView.hidden = true
                laterListImageView.center.x = messageDisplacement + 320 + 60 - 22.5
                
                if messageImageView.center.x < -100 {
                    messageBackgroundView.backgroundColor = brown
                    laterListImageView.highlighted = true
                }
            }
            
            else {
                
                messageBackgroundView.backgroundColor = lightGray
                archiveDeleteImageView.hidden = false
                laterListImageView.hidden = false

            }
            
            
            
        
        // GESTURE ENDING BEHAVIOR
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            println("message center \(messageImageView.center.x)")
            
            // ARCHIVE AND DELETE
            if messageImageView.center.x > 220 {
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImageView.transform = CGAffineTransformTranslate(self.messageImageView.transform, 500, 0)
                    self.archiveDeleteImageView.hidden = true
                    }, completion: { (finished: Bool) -> Void in
                        self.closeMessageGap()

                })

            }
            
            // RESCHEDULE AND LIST
            else if messageImageView.center.x < 100 {
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImageView.transform = CGAffineTransformTranslate(self.messageImageView.transform, -500, 0)
                    self.laterListImageView.hidden = true
                    }, completion: { (finished: Bool) -> Void in
                        
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            if self.messageImageView.center.x <  -100 {
                                self.listScreenImageView.alpha = 1
                            }
                            
                            else {
                                self.rescheduleScreenImageView.alpha = 1
                            }
                        })
                })
                
            } else {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.messageImageView.center.x = 160
                })
            }

            

        }
        
    }
    
    
    // CLOSING OTHER SCREENS
    
    @IBAction func onRescheduleTap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.rescheduleScreenImageView.alpha = 0
            }, completion: { (finished: Bool) -> Void in
                self.closeMessageGap()
            })
    }
 
    
    @IBAction func onListTap(sender: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.listScreenImageView.alpha = 0
            }, completion: { (finished: Bool) -> Void in
            self.closeMessageGap()
            })
        
      
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
