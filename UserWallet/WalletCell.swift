//
//  WalletCell.swift
//  WalletDesign
//
//  Created by Zenitus Technologies on 20/09/21.
//

import UIKit

class WalletCell: UITableViewCell {
    
    var buyMoreAction: (() -> Void)? = nil
    var earnedPrimaryAction: (() -> Void)? = nil
    var rewardedPrimaryAction: (() -> Void)? = nil
    
    
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var borkageLabel: UILabel!
    
    //    var walletType : WalletModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        icon.isHidden = true
        //        moveButton.layer.cornerRadius = 5
        //        moveButton.clipsToBounds = true
        
        bgView.backgroundColor = .clear
        bgView.layer.cornerRadius = 10
        bgView.clipsToBounds = true
        
        self.backgroundColor = .clear
        
        headingLabel.textColor = .white
        balanceLabel.textColor = .white
        borkageLabel.textColor = .white
            
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        moveButton.layer.cornerRadius = 5
        //moveButton.clipsToBounds = true
        //moveButton.dropShadows(color: .appShadowColor, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        //        moveButton.dropShadowsButton(color: .appShadowColor, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true, button: moveButton)
        
    }
    
    func configureCell(index: IndexPath) {
        
        switch index.row {
            
        case 0:
            loadData(title: "Primary", imageName: "primary", balance: "100", brokerage:10)
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
            dateFormatter.dateFormat = "dd"
            let stringDay = dateFormatter.string(from: date)
            let day = Int(stringDay)!
            if (day <= 15) {
                moveButton.backgroundColor = hexStringToUIColor(hex: "13914C")
            } else {
                moveButton.backgroundColor = hexStringToUIColor(hex: "F02834")
            }
            moveButton.clipsToBounds = true
            moveButton.setTitleColor(.white, for: .normal)
        case 1:
            loadData(title: "Earned", imageName: "earned", balance: "20", brokerage: 40)
            moveButton.backgroundColor = UIColor.convertRGB(hexString: "#072133")
            moveButton.layer.cornerRadius = 5
            moveButton.dropShadowsButton(color: .whatsNewKitLightBlue, opacity: 1, offSet: CGSize(width: -0.5, height: 1), radius: 3, scale: true, button: moveButton)
            moveButton.setTitleColor(UIColor.white, for: .normal)
            
            
        case 2:
            loadData(title: "Rewarded", imageName: "reward", balance:  "150", brokerage: 20)
            moveButton.backgroundColor = UIColor.convertRGB(hexString: "#072133")
            moveButton.layer.cornerRadius = 5
            moveButton.dropShadowsButton(color: .whatsNewKitLightBlue, opacity: 1, offSet: CGSize(width: -0.5, height: 1), radius: 3, scale: true, button: moveButton)
            moveButton.setTitleColor(UIColor.white, for: .normal)
            
        default:
            break;
            
        }
    }
    
    func loadData(title: String, imageName: String, balance: String, brokerage: Int) {
        headingLabel.text = title
        icon.image = UIImage(named: imageName)
        balanceLabel.text = balance
        if title == "Rewarded" {
            borkageLabel.text = "Earned tokens"
            moveButton.setTitle("Transfer", for: .normal)
            moveButton.tag = 3
            
            
        } else if title == "Primary" {
            borkageLabel.text = "(Purchased/Spendable)"
            moveButton.setTitle("Buy More", for: .normal)
            
            moveButton.tag = 1
            
        } else {
            
            let new = balance.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range:nil)
            
            var brokageValue = Int()
            if brokerage == 0 {
                brokageValue = 40
            } else {
                brokageValue = brokerage
            }
            let value = calculatePercentage(value: Double(new)!,percentageVal: Double(brokageValue))
            borkageLabel.text = "Brokerage (10%) = 100"
            moveButton.setTitle("Transfer", for: .normal)
            moveButton.tag = 2
            
        }
        moveButton.addTarget(self, action: #selector(didTapBuyMoreAction), for: .touchUpInside)
        
    }
    
    
    func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value * percentageVal
        return val / 100.0
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func didTapEarnedBlowAction(_ sender: UIButton) {
        
    }
    
    @objc func didTapRewardedBlowAction(_ sender: UIButton) {
        
    }
    
    @objc func didTapBuyMoreAction(_ sender: UIButton) {
        if sender.tag == 1 {
            buyMoreAction?()
        }
        if sender.tag == 2 {
            earnedPrimaryAction?()
        }
        if sender.tag == 3 {
            rewardedPrimaryAction?()
        }
    }
    
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadows(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func dropShadowsButton(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true,button:UIButton) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        //      layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowPath = UIBezierPath(rect:CGRect(x: 0, y: 0, width: button.frame.width, height: 35)).cgPath
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
