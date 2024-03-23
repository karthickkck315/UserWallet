//
//  MemeCell.swift
//  MemeIQ
//
//  Created by Michael Rojas on 7/8/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import UIKit
import StoreKit

protocol PurchaseCellDelegate : AnyObject {
    
     func didTapPurchaseTokens(cell: PurchaseCell)
 }

class PurchaseCell: UICollectionViewCell {

    var cellDelegate: PurchaseCellDelegate?
    
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var offerPercentageLabel: UILabel!
    @IBOutlet var offerImage: UIImageView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.contentMode = .scaleAspectFit
        buyButton.layer.cornerRadius = 5.0
        buyButton.backgroundColor = UIColor(rgba: "#031628")
        buyButton.setTitleColor(.white, for: .normal)
        
        coinsLabel.textColor = .white
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.textAlignment = .center
        
        self.backgroundColor = .init(white: 1.0, alpha: 0.5)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    
    override func layoutSubviews() {
        buyButton.dropShadows(color: .whatsNewKitLightBlue, opacity: 1, offSet: CGSize(width: -0.5, height: 1), radius: 3, scale: true)

    }
   
    @IBAction func didTapBuyAction(_ sender: Any) {
        cellDelegate?.didTapPurchaseTokens(cell: self)
    }
}
