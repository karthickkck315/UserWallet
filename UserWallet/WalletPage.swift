//
//  WalletPage.swift
//  WalletDesign
//
//  Created by Karthick on 20/09/21.
//


import UIKit

class WalletPage: UIViewController {
    
    @IBOutlet weak var headingImageView: UIImageView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var walletListView: UITableView!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var bgImgView: UIImageView!

    var walletTransferPage = WalletTransferPage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bgImgView.backgroundColor = UIColor(rgba: "#031628")
        headingImageView.backgroundColor = UIColor(rgba: "#072133")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setUpUI() {
        self.title = "Wallet"
        self.walletListView.separatorColor = UIColor.convertRGB(hexString: "#113743")
        self.walletListView.backgroundColor = .clear
        self.walletListView.delegate = self
        self.walletListView.dataSource = self
        self.walletListView.reloadData()
        self.historyButton.backgroundColor = UIColor(rgba: "#072133")
        self.historyButton.layer.cornerRadius = 5
        self.historyButton.layer.shadowColor = UIColor.whatsNewKitLightBlue.cgColor
        self.historyButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.historyButton.layer.shadowRadius = 3
        self.historyButton.layer.shadowOpacity = 2
        self.historyButton.layer.masksToBounds = false
        
        self.historyButton.addTarget(self, action: #selector(didTapMovetopHistoryPage), for: .touchUpInside)
        self.totalValueLabel.text = "200"
    }
    
    @objc func didTapMovetopHistoryPage() {
       
    }
    
}

extension WalletPage: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let walletCell = tableView.dequeueReusableCell(withIdentifier: "WalletCell") as! WalletCell
        walletCell.configureCell(index: indexPath)
        walletCell.contentView.backgroundColor = .clear
        walletCell.backgroundColor = .clear
        
        walletCell.buyMoreAction = {self.buyMoreOption()}
        walletCell.earnedPrimaryAction = {self.didTapEarnedPrimary()}
        walletCell.rewardedPrimaryAction = {self.didTapRewardedPrimary()}
        
        return walletCell
    }
    
    func buyMoreOption() {
       
        let purchasePage = self.storyboard?.instantiateViewController(withIdentifier: "PurchasePage") as! PurchasePage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(purchasePage, animated: true)
    }
    
    func didTapEarnedPrimary() {
        self.moveToTranferPage(from: "Earned", balance: "100")
    }
    func didTapRewardedPrimary() {
        self.moveToTranferPage(from: "Awarded", balance: "100")
    }
    
    func moveToTranferPage(from : String, balance : String) {
        walletTransferPage = self.storyboard?.instantiateViewController(withIdentifier: "WalletTransferPage") as! WalletTransferPage
        walletTransferPage.view.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5)
        walletTransferPage.from = from
        walletTransferPage.balance = balance
        self.view.addSubview(walletTransferPage.view)
    }
    
    
}




extension WalletPage: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension UIColor {
    static var whatsNewKitBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    return .whatsNewKitWhite
                case .dark:
                    return .whatsNewKitDark
                @unknown default:
                    return .whatsNewKitWhite
                }
            }
        } else {
            return .whatsNewKitWhite
        }
    }
    
    /// The WhatsNewKit background color
    static var whatsNewKitForeground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    return .whatsNewKitBlack
                case .dark:
                    return .whatsNewKitWhite
                @unknown default:
                    return .whatsNewKitBlack
                }
            }
        } else {
            return .whatsNewKitBlack
        }
    }
    
    /// The WhatsNewKit white color
    static let whatsNewKitWhite = UIColor(
        red: 1,
        green: 1,
        blue: 1,
        alpha: 1
    )
    
    /// The WhatsNewKit black color
    static let whatsNewKitBlack = UIColor(
        red: 0,
        green: 0,
        blue: 0,
        alpha: 1
    )
    
    /// The WhatsNewKit blue color
    static let whatsNewKitBlue = UIColor(
        red: 0,
        green: 122 / 255,
        blue: 1,
        alpha: 1
    )
    
    /// The WhatsNewKit light blue color
    static let whatsNewKitLightBlue = UIColor(
        red: 95 / 255,
        green: 200 / 255,
        blue: 248 / 255,
        alpha: 1
    )
    
    /// The WhatsNewKit dark color
    static let whatsNewKitDark = UIColor(
        red: 20 / 255,
        green: 29 / 255,
        blue: 38 / 255,
        alpha: 1
    )
    
    /// The WhatsNewKit purple color
    static let whatsNewKitPurple = UIColor(
        red: 183 / 255,
        green: 35 / 255,
        blue: 1,
        alpha: 1
    )
    
    /// The WhatsNewKit red color
    static let whatsNewKitRed = UIColor(
        red: 1,
        green: 45 / 255,
        blue: 85 / 255,
        alpha: 1
    )
    
    /// The WhatsNewKit green color
    static let whatsNewKitGreen = UIColor(
        red: 76 / 255,
        green: 217 / 255,
        blue: 100 / 255,
        alpha: 1
    )
    
    
    //MARK:-Hexadecimal to RGB
    public class func convertRGB(hexString: String) -> UIColor {
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                return UIColor(
                    red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                    blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                    alpha: CGFloat(1.0)
                )
            }
        }
        return UIColor.black
    }
    
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            //let index   = rgba.index(rgba.startIndex, offsetBy: 1)
            //            let hex     = rgba.substring(from: index)
            //            let scanner = Scanner(string: hex)
            
            let index   = rgba.index(rgba.startIndex, offsetBy: 1)
            let hex     = rgba[index...]
            let scanner = Scanner(string: String(hex))
            
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                if hex.count == 6 {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                } else if hex.count == 8 {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9", terminator: "")
                }
            } else {
                print("scan hex error")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
