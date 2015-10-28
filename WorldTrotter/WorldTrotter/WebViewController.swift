//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Kelly Yamamoto on 10/27/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView : WKWebView?
    
    override func loadView() {
        super.loadView()
        self.webView = WKWebView()
        webView?.backgroundColor = UIColor.whiteColor()
        webView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        webView?.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        let url = NSURL(string:"https://www.bignerdranch.com")
        let req = NSURLRequest(URL:url!)
        webView?.loadRequest(req)
        
        view.addSubview((webView)!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("WebView loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
