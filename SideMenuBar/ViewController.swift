import UIKit

class ViewController: UIViewController {

    //MARK: variables
    
    var sideBarView: UIView!
    var backView: UIView!
    var profileView: UIView!
    var clView: UIView!
    var bottomView: UIView!
    var clLabel: UILabel!
    var codingLockLabel: UILabel!
    var appDevLabel: UILabel!
    var tableView:UITableView!
    var isEnableSideBarView:Bool = false
    var imgArray: [String] = ["dashboard", "revanue", "notification", "like", "wallet", "analytics"]
    var imgeNameLbl = ["Dashboard", "Revanue", "Notification", "Like", "Wallet", "Analytics"]
    var imgView: UIImageView!
    var lbl: UILabel!
    var logOutlabel: UILabel!
    var logOutImg: UIImageView!
    var themeImg: UIImageView!
    var swipToRight = UISwipeGestureRecognizer()
    var swipeToLeft = UISwipeGestureRecognizer()
    var separatorLine:UIView!
    var themeLabel: UILabel!
    
    
    //MARK: life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        logOutImg = UIImageView()
        themeImg = UIImageView()
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = customView.bounds
        menuBtn.setTitle("", for: .normal)
        menuBtn.addTarget(self, action: #selector(menuBtnClick), for: .touchUpInside)
        customView.addSubview(menuBtn)

        let customBarItem = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = customBarItem
        customView.frame.origin.y = 20
        
        logOutImg.frame = CGRect(x: 25, y: 50, width: 35, height: 35)
        logOutlabel = UILabel(frame: CGRect(x: 50, y: 50, width: 150, height: 50))
        themeImg.frame = CGRect(x: 25, y: 120, width: 35, height: 35)
        themeLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 150, height: 50))
        sideBarView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: self.view.bounds.height))
        backView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: self.view.bounds.height))
        profileView = UIView(frame: CGRect(x: 0, y: 30, width: 200, height: 100))
        tableView = UITableView(frame: CGRect(x: 0, y: 40, width: 0, height: self.view.bounds.height - 140))
        clView = UIView(frame: CGRect(x: 13, y: 77, width: 50, height: 50))
        clLabel = UILabel(frame: CGRect(x: 13, y: 77, width: 50, height: 50))
        codingLockLabel = UILabel(frame: CGRect(x: 80, y: 5, width: 100, height: 100))
        appDevLabel = UILabel(frame: CGRect(x: 80, y: 20, width: 100, height: 100))
        bottomView = UIView(frame: CGRect(x: 0, y: 600, width: 200, height: 100))

        tableView.separatorStyle = .none


        clLabel.text = "CL"
        clLabel.font = UIFont.systemFont(ofSize: 20)
        clLabel.textColor = .white
        clLabel.textAlignment = .center
        clView.layer.cornerRadius = 10
        clView.layer.masksToBounds = true
        
        
        logOutlabel.text = "logout"
        logOutlabel.font = UIFont.systemFont(ofSize: 20)
        logOutlabel.textAlignment = .center
        
        themeLabel.text = "theme"
        themeLabel.font = UIFont.systemFont(ofSize: 20)
        themeLabel.textAlignment = .center
        
        codingLockLabel.text = "Coding Lock"
        codingLockLabel.font = UIFont.systemFont(ofSize: 15)
        codingLockLabel.textColor = .black
        
        appDevLabel.text = "app Developer"
        appDevLabel.font = UIFont.systemFont(ofSize: 15)
        appDevLabel.textColor = .black
        
        view.backgroundColor = .black
        sideBarView.backgroundColor = .white
        profileView.backgroundColor = .white
        clView.backgroundColor = .blue
        bottomView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        logOutImg.contentMode = .scaleAspectFit
        logOutImg.image = UIImage(named: "exit")
        themeImg.contentMode = .scaleAspectFit
        themeImg.image = UIImage(named: "theme")
        
        separatorLine = UIView(frame: CGRect(x: 0, y: tableView.frame.maxY - 150, width: self.view.bounds.width, height: 0.5))
        separatorLine.backgroundColor = .black
        self.sideBarView.addSubview(separatorLine)
     
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(backView)
        self.backView.addSubview(tableView)
        self.backView.addSubview(profileView)
        self.backView.addSubview(clView)
        self.backView.addSubview(clLabel)
        self.profileView.addSubview(codingLockLabel)
        self.profileView.addSubview(appDevLabel)
        self.sideBarView.addSubview(bottomView)
        self.bottomView.addSubview(logOutImg)
        self.bottomView.addSubview(logOutlabel)
        self.bottomView.addSubview(themeImg)
        self.bottomView.addSubview(themeLabel)
       
        
        swipToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedToRight))
        swipToRight.direction = .right
        self.view.addGestureRecognizer(swipToRight)
        
        swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedToLeft))
        swipeToLeft.direction = .left
//        self.view.addGestureRecognizer(swipeToLeft)
        
    }
    
    @objc func menuBtnClick() {
        print("btn click")

        if isEnableSideBarView {
            self.view.addGestureRecognizer(swipToRight)
            self.view.removeGestureRecognizer(swipeToLeft)
            UIView.animate(withDuration: 0.5) {
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                self.tableView.frame = CGRect(x: 0, y: 195, width: 270, height: 400) // Adjust the height here
                self.profileView.frame = CGRect(x: 0, y: 40, width: 77, height:  150)
                self.bottomView.frame = CGRect(x: 0, y: 600, width: 77, height:  200)
                self.logOutlabel.frame = CGRect(x: 65, y: 50, width: 20, height:  50)
                self.separatorLine.frame = CGRect(x: 0, y: 600, width: 77, height: 0.5)
                self.themeLabel.frame = CGRect(x: 0, y: 120, width: 20, height:  50)
                self.logOutlabel.text = ""
                self.themeLabel.text = ""
                self.sideBarView.frame.size.width /= 3.0
                self.tableView.frame.size.width /= 3.5
            }
            isEnableSideBarView = false
        } else {
            self.view.addGestureRecognizer(swipeToLeft)
            self.view.removeGestureRecognizer(swipToRight)
            UIView.animate(withDuration: 0.5) {
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.3, height: self.view.bounds.height)
                self.tableView.frame = CGRect(x: 0, y: 195, width: self.view.bounds.width/1.3, height: 400) // Adjust the height here
                self.profileView.frame = CGRect(x: 0, y: 40, width: self.view.bounds.width/1.3, height:  150)
                self.bottomView.frame = CGRect(x: 0, y: 600, width: self.view.bounds.width/1.3, height:  200)
                self.logOutlabel.frame = CGRect(x: -50, y: 40, width: self.view.bounds.width/1.3, height: 50)
                self.separatorLine.frame = CGRect(x: 0, y: 600, width: self.view.bounds.width, height: 0.5)
                self.themeLabel.frame = CGRect(x: -50, y: 110, width: self.view.bounds.width/1.3, height: 50)
                self.logOutlabel.text = "logout"
                self.themeLabel.text = "theme"
                self.appDevLabel.isHidden = false
                self.codingLockLabel.isHidden = false
            }
            isEnableSideBarView = true
        }
    }
    
    
    @objc func swipedToLeft() {
        print("swipedToLeft")
        self.view.addGestureRecognizer(swipToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        
        UIView.animate(withDuration: 0.5) {
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            self.tableView.frame = CGRect(x: 0, y: 195, width: 270, height: 400) // Adjust the height here
            self.profileView.frame = CGRect(x: 0, y: 40, width: 77, height:  150)
            self.bottomView.frame = CGRect(x: 0, y: 600, width: 77, height:  200)
            self.logOutlabel.frame = CGRect(x: 65, y: 50, width: 20, height:  50)
            self.separatorLine.frame = CGRect(x: 0, y: 600, width: 77, height: 0.5)
            self.themeLabel.frame = CGRect(x: 0, y: 120, width: 20, height:  50)
            self.logOutlabel.text = ""
            self.themeLabel.text = ""
            self.sideBarView.frame.size.width /= 3.0
            self.tableView.frame.size.width /= 3.5
        }
        isEnableSideBarView = false
    }

    @objc func swipedToRight() {
        print("swipedToRight")
        self.view.addGestureRecognizer(swipeToLeft)
        self.view.removeGestureRecognizer(swipToRight)
        
        UIView.animate(withDuration: 0.5) {
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.3, height: self.view.bounds.height)
            self.tableView.frame = CGRect(x: 0, y: 195, width: self.view.bounds.width/1.3, height: 400) // Adjust the height here
            self.profileView.frame = CGRect(x: 0, y: 40, width: self.view.bounds.width/1.3, height:  150)
            self.bottomView.frame = CGRect(x: 0, y: 600, width: self.view.bounds.width/1.3, height:  200)
            self.logOutlabel.frame = CGRect(x: -50, y: 40, width: self.view.bounds.width/1.3, height: 50)
            self.separatorLine.frame = CGRect(x: 0, y: 600, width: self.view.bounds.width, height: 0.5)
            self.themeLabel.frame = CGRect(x: -50, y: 110, width: self.view.bounds.width/1.3, height: 50)
            self.logOutlabel.text = "logout"
            self.themeLabel.text = "theme"
            self.appDevLabel.isHidden = false
            self.codingLockLabel.isHidden = false
        }
        isEnableSideBarView = true
    }

}

// MARK: extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        imgView = UIImageView(frame: CGRect(x: 20, y: 8, width: cell.bounds.height-27, height: cell.bounds.height-27))
        imgView.contentMode = .scaleToFill
        
        if let image = UIImage(named: self.imgArray[indexPath.row]) {
            imgView.image = image
        } else {
            imgView.image = nil
        }
        
        cell.addSubview(imgView)
        
        lbl = UILabel(frame: CGRect(x: imgView.frame.maxX + 23, y: 2, width: cell.bounds.width - (imgView.frame.maxX + 24), height: cell.bounds.height-16))
        lbl.text = "\(imgeNameLbl[indexPath.row])"
        
        cell.addSubview(lbl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 60.0
        
        }
    
}
