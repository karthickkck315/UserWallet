//
//  PurchasePage.swift
//  WalletDesign
//
//  Created by Zenitus Technologies on 20/09/21.
//

import UIKit
import StoreKit

class PurchasePage: UIViewController, PurchaseCellDelegate {
    func didTapPurchaseTokens(cell: PurchaseCell) {
        
    }
        
    var productsArray: [SKProduct] = []
    var product_Price = ""
    var paymentStatus = ""
    
    var productIDs = [String]()
        
    let margin: CGFloat = 20
    
    @IBOutlet weak var tokensList: UICollectionView!
    @IBOutlet weak var bgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productIDs = ["SmallPack","MediumPack","LargePack"]
        setUpUI()
    }
    
    func setUpUI() {
        
        guard let collectionView = tokensList, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        bgView.backgroundColor = UIColor(rgba: "#031628")
        tokensList.backgroundColor = UIColor(rgba: "#031628")
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        tokensList.contentInsetAdjustmentBehavior = .always
        
        tokensList.register(UINib.init(nibName: "PurchaseCell", bundle: nil), forCellWithReuseIdentifier: "PurchaseCell")
        tokensList.backgroundColor = .clear
        self.view.backgroundColor = .white
        
        self.tokensList.delegate = self
        self.tokensList.dataSource = self
        self.tokensList.reloadData()
        self.title = "Token Store"
    }
}

extension PurchasePage : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productIDs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PurchaseCell", for: indexPath) as! PurchaseCell
        cell.cellDelegate = self
        cell.contentView.backgroundColor = UIColor(rgba: "#072133")
        cell.nameLabel.text = productIDs[indexPath.row]
        
        cell.image.image = UIImage(named: "coin")
        
        if indexPath.row < 3 {
            cell.coinsLabel.text = "100"
            cell.buyButton.setTitle("$ 2", for: .normal)
            
            cell.offerPercentageLabel.text = "10%"
            cell.offerImage.isHidden = false
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "100")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.offerLabel.attributedText = attributeString
            
            
        } else {
            cell.offerImage.isHidden = true
            cell.moreLabel.text = ""
            cell.offerPercentageLabel.text = ""
            cell.offerLabel.text = ""
            cell.coinsLabel.text = ""
        }
        
        return cell
    }
}

extension PurchasePage: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width/2 - 30, height: 250)
    }
}


func getCurrentDateTime()-> String {
    let date = Date()
    let formatter = DateFormatter()
    //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
    let dateInString  = formatter.string(from: date)
    return dateInString
}


func getCreateDateTime()-> String {
    let date = Date()
    let formatter = DateFormatter()
    //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
    let dateInString  = formatter.string(from: date)
    return dateInString
}
