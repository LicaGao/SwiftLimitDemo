//
//  ViewController.swift
//  SwiftLimitDemo
//
//  Created by 高鑫 on 2017/11/22.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var limitLabel: UILabel!
    @IBAction func sendItemAction(_ sender: UIBarButtonItem) {
        sendAction()
    }
    
    var weiboDetail : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(textViewNotificationAction(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func textViewNotificationAction(notification: Notification) {
        let limit: Int = 140
        let text = self.textView.text as NSString
        if text.length >= limit {
            let str = text.substring(to: limit)
            self.textView.text = str
            self.limitLabel.text = "\(limit)"
            self.limitLabel.textColor = UIColor.orange
        } else {
            self.limitLabel.textColor = UIColor.darkGray
            self.limitLabel.text = "\(text.length)"
        }
        self.weiboDetail = String(text)
    }
    
    @objc func keybordShow(notification: Notification)  {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyBoardBoundsRect = self.view.convert(keyBoardBounds, to: nil)
        let deltaY = keyBoardBoundsRect.size.height
        
        let animations: (() -> Void) = {
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: -deltaY)
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: animations, completion: nil)
        } else {
            animations()
        }
    }

    @objc func keybordHide(notification: Notification)  {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations: (() -> Void) = {
            self.bottomView.transform = CGAffineTransform.identity
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: animations, completion: nil)
        } else {
            animations()
        }
    }
    
    func sendAction() {
        let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        okAction.setValue(UIColor.orange, forKey: "titleTextColor")
        ac.addAction(okAction)
        if weiboDetail == nil {
            ac.title = "微博内容不可为空"
            ac.message = nil
        } else {
            ac.title = nil
            ac.message = self.weiboDetail
        }
        present(ac, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

