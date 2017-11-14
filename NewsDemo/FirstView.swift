import Foundation
import UIKit
import Alamofire
import SDWebImage
import MJRefresh

class FirstPageView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var count = 0
    var tableView: UITableView!
    var news: NSArray!
    var imgView: UIImageView!
    var cell: UITableViewCell!
    let willPostNews = "https://open.twtstudio.com/api/v1/news/3/page/1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 20, width:self.view.frame.size.width, height:self.view.frame.size.height - 20), style: .plain)
        self.tableView.backgroundColor = .white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "swiftCell")
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60
        self.tableView.mj_footer = MJRefreshAutoNormalFooter()
        self.tableView.mj_header = MJRefreshNormalHeader()
        
        Alamofire.request(willPostNews).responseJSON { response in
            if let json = response.result.value{
                let dict = json as! Dictionary<String, Any>
                self.news = dict["data"] as! NSArray
                self.count = self.news.count
                print("succeed")
            }
            self.tableView.reloadData()
        }

        //设置navigation的title及背景颜色
        let title: String?
        title = "今日热闻"
        self.navigationItem.title = title
        self.view.backgroundColor = .white
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "swiftCell", for: indexPath)
        let temp = news[indexPath.row] as! Dictionary<String, Any>
        let url = temp["pic"] as? String
        imgView = UIImageView(frame: CGRect(x: self.tableView.frame.width - 70, y: 5, width: 60, height: self.tableView.rowHeight - 10))
        self.imgView.sd_setImage(with: URL(string: url!)) { (_, _, _, _) in
        }
     
        let title = UILabel(frame: CGRect(x: 10, y: self.tableView.rowHeight / 6, width: self.tableView.frame.width  - 80, height: self.tableView.rowHeight * (3/4)))
        title.text = temp["subject"] as? String
        title.font = UIFont.boldSystemFont(ofSize: 12)
        title.textAlignment = NSTextAlignment.left
        title.numberOfLines = 0
        
        cell.addSubview(title)
        cell.addSubview(imgView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailView()
        let temp = news[indexPath.row] as! Dictionary<String, Any>
        let url = (temp["index"] as? String)!
        detailVC.myUrl = "https://open.twtstudio.com/api/v1/news/" + url
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
