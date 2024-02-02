import UIKit

class ViewController: UIViewController {

    //MARK: variables
    
    var sideBarView: UIView!
    var profileView: UIView!
    var clView: UIView!
    var bottomView: UIView!
    var clLabel: UILabel!
    var codingLockLabel: UILabel!
    var appDevLabel: UILabel!
    var tableView:UITableView!
    var isEnableSideBarView:Bool = false
    var imgArray: [String] = ["dashboard", "revanue", "notification", "like", "wallet"]
    var imgeNameLbl = ["Dashboard", "Revanue", "Notification", "Like", "Wallet"]
    var imgView: UIImageView!
    var lbl: UILabel!
    
    var swipToRight = UISwipeGestureRecognizer()
    var swipeToLeft = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        sideBarView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        profileView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        tableView = UITableView(frame: CGRect(x: 0, y: 53, width: 0, height: self.view.bounds.height - 140))
        clView = UIView(frame: CGRect(x: 13, y: 50, width: 50, height: 50))
        clLabel = UILabel(frame: CGRect(x: 13, y: 50, width: 50, height: 50))
        codingLockLabel = UILabel(frame: CGRect(x: 80, y: 15, width: 100, height: 100))
        appDevLabel = UILabel(frame: CGRect(x: 80, y: 30, width: 100, height: 100))
        bottomView = UIView(frame: CGRect(x: 0, y: 600, width: 200, height: 100))
        
        clLabel.text = "CL"
        clLabel.font = UIFont.systemFont(ofSize: 20)
        clLabel.textColor = .white
        clLabel.textAlignment = .center
        clLabel.layer.cornerRadius = 10
        clLabel.layer.masksToBounds = true
        
        codingLockLabel.text = "Coding Lock"
        codingLockLabel.font = UIFont.systemFont(ofSize: 15)
        codingLockLabel.textColor = .black
        
        appDevLabel.text = "app Developer"
        appDevLabel.font = UIFont.systemFont(ofSize: 15)
        appDevLabel.textColor = .black
        
        //codingLockLabel.textAlignment = .center
        
        tableView.backgroundColor = .blue
        sideBarView.backgroundColor = .red
        profileView.backgroundColor = .green
        clView.backgroundColor = .blue
        bottomView.backgroundColor = .yellow
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

      
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(tableView)
        self.sideBarView.addSubview(profileView)
        self.sideBarView.addSubview(clView)
        self.sideBarView.addSubview(clLabel)
        self.profileView.addSubview(codingLockLabel)
        self.profileView.addSubview(appDevLabel)
        self.sideBarView.addSubview(bottomView)
        
        swipToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedToRight))
        swipToRight.direction = .right
        self.view.addGestureRecognizer(swipToRight)
        
        swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedToLeft))
        swipeToLeft.direction = .left
//        self.view.addGestureRecognizer(swipeToLeft)
        
    }

    
    @objc func swipedToLeft() {
        print("swipedToLeft")
        self.view.addGestureRecognizer(swipToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        
        UIView.animate(withDuration: 0.5) {
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            self.tableView.frame = CGRect(x: 0, y: 200, width: 270, height: 400) // Adjust the height here
            self.profileView.frame = CGRect(x: 0, y: 0, width: 77, height:  200)
            self.bottomView.frame = CGRect(x: 0, y: 600, width: 77, height:  200)
            self.codingLockLabel.isHidden = true
            self.appDevLabel.isHidden = true
            // Decrease the width of sideBarView
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
            self.tableView.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width/1.3, height: 400) // Adjust the height here
            self.profileView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.3, height:  200)
            self.bottomView.frame = CGRect(x: 0, y: 600, width: self.view.bounds.width/1.3, height:  200)
            self.appDevLabel.isHidden = false
            self.codingLockLabel.isHidden = false
        }
        isEnableSideBarView = true
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        imgView = UIImageView(frame: CGRect(x: 20, y: 8, width: cell.bounds.height-16, height: cell.bounds.height-16))
        imgView.contentMode = .scaleToFill
        
        if let image = UIImage(named: self.imgArray[indexPath.row]) {
            imgView.image = image
        } else {
            // Handle the case where the image is not found
            imgView.image = nil
        }
        
        cell.addSubview(imgView)
        
        lbl = UILabel(frame: CGRect(x: imgView.frame.maxX + 16, y: 8, width: cell.bounds.width - (imgView.frame.maxX + 24), height: cell.bounds.height-16))
        lbl.text = "\(imgeNameLbl[indexPath.row])"
        
        cell.addSubview(lbl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 60.0
        
        }
    
}
