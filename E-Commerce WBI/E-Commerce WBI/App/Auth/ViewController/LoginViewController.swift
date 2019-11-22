//
//  LoginViewController.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/11/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var loginVM = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.clearBrackgorund()
    }
    
    // MARK: - Config UI
    
    func configUI() {
        
        if let _ = defaults.string(forKey: KeysEnum.user_email.rawValue) {
            
            let storyboard = UIStoryboard(name: "Product", bundle: nil)
            if  let vc = storyboard.instantiateInitialViewController(){
                
               self.navigationController?.pushViewController(vc, animated: false)
            }
            
        }else{
            self.emailTextField.delegate = self
            self.passwordTextField.delegate = self
            
            self.loginVM.erroMessage.bind { [weak self] message in
                self?.errorLabel.text = message
                self?.errorLabel.adjustsFontSizeToFitWidth = true
                self?.removeLoading()
            }.disposed(by: disposbag)
        }
    }
    
    func getUnderline(from field : UITextField) -> UILabel? {
        
        if let line = self.view.viewWithTag(field.tag+10) as? UILabel {
            return line
        }
        return nil
    }
    
    // MARK: - Buttons
    
    @IBAction func onSigin(_ sender: Any) {
        
        
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if self.loginVM.validateForm(email : email, password : password ) {
            
            self.setLoading()
            self.loginVM.perfomLogin(email: password, password: password) {
                
                self.removeLoading()
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.performSegue(withIdentifier: "showProducts", sender: self)
            }
        }
        
    }
    
    // MARK: - UITextFieldDelegate
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.onSigin(textField)
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.getUnderline(from: textField)?.select()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let underline = self.getUnderline(from: textField)
        
        if textField.text != nil && !textField.text!.isEmpty {
            
            if self.emailTextField == textField && !textField.text!.isValidEmail() {
                underline?.showError()
                self.loginVM.erroMessage.accept("Please enter a valid email")
            } else if self.passwordTextField == textField && textField.text!.count < 4 {
                underline?.showError()
                self.loginVM.erroMessage.accept("Password must have at least 4 characters")
            } else{
                underline?.unselect()
                self.loginVM.erroMessage.accept(nil)
            }
            
            return
        }
        
        underline?.showError()
        self.loginVM.erroMessage.accept("Fill the field")

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = textField == self.emailTextField ? 20 : 15
        
        if let currentString = textField.text{
            
            let currentString: NSString = currentString as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
           
            return newString.length <= maxLength
        }
        
        return true
    }
    
    
}
