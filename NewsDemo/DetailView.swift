//
//  ViewController.swift
//  test
//
//  Created by ZHONG LI on 2017/11/13.
//  Copyright © 2017年 ZHONG LI. All rights reserved.
//

import UIKit
import Alamofire

class DetailView: UIViewController {
    var newsDetailView: UIWebView!
    var news: Dictionary<String, Any>!
    var content: String = ""
    var myUrl: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        newsDetailView = UIWebView(frame: CGRect(x: 0, y: 20, width:self.view.frame.size.width, height:self.view.frame.size.height))
        self.view.addSubview(newsDetailView)
        Alamofire.request(myUrl).responseJSON { response in
            if let json = response.result.value{
                let dict = json as! Dictionary<String, Any>
                self.news = dict["data"] as! Dictionary<String, Any>
                self.content = self.news["content"] as! String
            }
            self.content += ("<br><br><p>来源&nbsp&nbsp&nbsp&nbsp" + (self.news["newscome"] as! String) + "</p>")
            self.content += ("<p>供稿&nbsp&nbsp&nbsp&nbsp" + (self.news["gonggao"] as! String) + "</p>")
            self.content += ("<p>审稿&nbsp&nbsp&nbsp&nbsp" + (self.news["shengao"] as! String) + "</p>")
            if (self.news["sheying"] as! String) != ""{
                self.content += ("<p>摄影&nbsp&nbsp&nbsp&nbsp" + (self.news["sheying"] as! String) + "</p>")
            }
            self.newsDetailView.loadHTMLString(self.content, baseURL: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


