# SwiftLimitDemo
### 11月22日练习
* 模仿发微博界面，实现发微博时字数限制为140字的功能，超出后右下角字数统计label会变为橘色。
* 使用通知来实现字数限制功能。在viewDidLoad中添加通知：
```
NotificationCenter.default.addObserver(self, selector: #selector(textViewNotificationAction(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
```
该通知调用方法 textViewNotificationAction ：
```
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
```
* 同时复习使用通知监听键盘的弹出和隐藏，相关方法参考自简书文章[swift实现ios类似微信输入框跟随键盘弹出的效果](http://www.jianshu.com/p/4e755fe09df7)
