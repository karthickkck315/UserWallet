//
//  WalletTransferPage.swift
//  Voj-Voj
//
//  Created by Zenitus Technologies on 06/12/21.
//

import UIKit

class WalletTransferPage: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tokenTextfield: UITextField!
    @IBOutlet weak var transferButton: UIButton!

    var from = ""
    var balance = ""
    var curentBalance = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bgView.layer.cornerRadius = 10
        bgView.clipsToBounds = true
        bgView.backgroundColor = UIColor(rgba: "#031628")
        
        tokenTextfield.layer.cornerRadius = 8
        tokenTextfield.clipsToBounds = true
        tokenTextfield.placeholder = "Enter your Token(s)"
        tokenTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tokenTextfield.frame.height))
        tokenTextfield.leftViewMode = .always
        tokenTextfield.backgroundColor = UIColor.convertRGB(hexString: "#072133")
        tokenTextfield.layer.borderWidth = 1
        tokenTextfield.layer.borderColor = UIColor.convertRGB(hexString: "#113743").cgColor
        tokenTextfield.keyboardType = .decimalPad
        tokenTextfield.delegate = self
        tokenTextfield.textColor = UIColor(rgba: "#FFFFFF")
        
        transferButton.layer.cornerRadius = 8
        //transferButton.clipsToBounds = true
        
        transferButton.setTitle("Move Now", for: .normal)
        transferButton.backgroundColor = UIColor.convertRGB(hexString: "#072133")
        
        transferButton.setTitleColor(.white, for: .normal)
        transferButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        closeButton.setImage(UIImage(named: ""), for: .normal)
        closeButton.setTitle("X", for: .normal)
        closeButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        closeButton.setTitleColor(.white, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        transferButton.dropShadows(color: .whatsNewKitLightBlue, opacity: 1, offSet: CGSize(width: -0.5, height: 1), radius: 3, scale: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(balance)
        curentBalance = Double(balance) ?? 0
        tokenTextfield.text = "\(curentBalance)"
        

    }
    
    @IBAction func didTapCloseAction(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    @IBAction func didTapTranferAction(_ sender: Any) {
        self.showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Your Token(s) Moved to Primary Wallet", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.view.removeFromSuperview()
                self.perform(#selector(self.moveToWalletPage), with: nil, afterDelay: 1)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func moveToWalletPage() {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tokenTextfield {
             if string == "," {
                 textField.text = textField.text! + "."
                 return false
             }
       }
        return true
    }
}
