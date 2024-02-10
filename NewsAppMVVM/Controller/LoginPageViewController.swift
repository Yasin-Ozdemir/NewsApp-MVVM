//
//  LoginPageViewController.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 8.02.2024.
//

import UIKit

class LoginPageViewController: UIViewController {
   
    
    private let logInImageView :UIImageView = {
       var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.backgroundColor = .black
        imageView.tintColor = .systemOrange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let mailTextField : UITextField = {
        var txtfield = UITextField()
        
        var attr = NSAttributedString(string: "E-Mail", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        txtfield.attributedPlaceholder = attr
        txtfield.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.bold)
        txtfield.leftView = UIImageView(image: UIImage(systemName: "envelope"))
       txtfield.leftViewMode = .always
        txtfield.tintColor = .white
        txtfield.textColor = .white
        txtfield.borderStyle = .roundedRect
        txtfield.layer.borderColor = UIColor.systemOrange.cgColor
        txtfield.keyboardType = .emailAddress
        txtfield.backgroundColor = .black
        txtfield.layer.borderWidth = 2
        txtfield.layer.cornerRadius = 10
        txtfield.translatesAutoresizingMaskIntoConstraints = false
        return txtfield
    }()
    
    private let passwordTextField : UITextField = {
        var txtfield = UITextField()
        var attr = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        txtfield.attributedPlaceholder = attr
        txtfield.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.bold)
        txtfield.textColor = .white
        txtfield.leftView = UIImageView(image: UIImage(systemName: "lock"))
        txtfield.leftViewMode = .always
        txtfield.tintColor = .white
        txtfield.borderStyle = .roundedRect
        txtfield.layer.borderColor = UIColor.systemOrange.cgColor
        txtfield.layer.borderWidth = 2
        txtfield.layer.cornerRadius = 10
        txtfield.backgroundColor = .black
        txtfield.translatesAutoresizingMaskIntoConstraints = false
        txtfield.isSecureTextEntry = true
        return txtfield
    }()
    
    private let logInButton :UIButton = {
       var button = UIButton()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 10
        button.setTitle("SIGN IN", for: UIControl.State.normal)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        button.addTarget(self, action: #selector(logIn), for: UIControl.Event.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let createAccountButton : UIButton = {
        var button = UIButton()
         button.backgroundColor = .black
        button.setTitle("New User? Create Account", for: UIControl.State.normal)
         button.setTitleColor(.systemOrange, for: UIControl.State.normal)
         button.titleLabel?.font = .systemFont(ofSize: 13, weight: UIFont.Weight.bold)
         button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushCreateVC), for: UIControl.Event.touchUpInside)
         return button
     }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setupConstraints()
        setupNavigationController()
    }
    @objc func pushCreateVC(){
        print("create user")
        let createVC = CreateUserPageViewController()
        self.navigationController!.pushViewController(createVC, animated: true)
    }
    
    @objc func logIn(){
        print("log in")
        let mail = mailTextField.text!
        let password = passwordTextField.text!
        if mail.isEmpty == false && password.isEmpty == false{
            SignPagesViewModel.signPagesVM.signIn(mail: mail, password: password) { err in
                if err != nil{
                    self.present(AlertManager.manager.showAlert(title: "ERROR", message: err!.localizedDescription), animated: true)
                }else{
                    self.pushHomeVC()
                }
            }
           
        }else{
            self.present(AlertManager.manager.showAlert(title: "ERROR", message: "Please Enter Your Mail/Password"), animated: true)
        }
    }
  
    
    func pushHomeVC(){
        let homePageVC = UINavigationController(rootViewController: HomePageViewController())
        homePageVC.modalPresentationStyle = .fullScreen
        self.present(homePageVC, animated: true)
    }
    

}


extension LoginPageViewController{
    
    func setupNavigationController(){
        self.navigationItem.title = "Welcome To NewsApp!"
        self.navigationController?.setupNavBar(backgroundColor: .black, textColor: .systemOrange, tintColor: .systemOrange )
    }
       
    func setupConstraints(){
        view.addSubview(mailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(createAccountButton)
        view.addSubview(logInImageView)
   
        NSLayoutConstraint.activate([
            self.logInImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.logInImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.logInImageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            self.logInImageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            
            self.mailTextField.topAnchor.constraint(equalTo: self.logInImageView.bottomAnchor, constant: 30),
            self.mailTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.mailTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.mailTextField.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
           
           self.passwordTextField.topAnchor.constraint(equalTo: self.mailTextField.bottomAnchor, constant: 20),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
            
           self.logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            self.logInButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.logInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.logInButton.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
            
            self.createAccountButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10),
            self.createAccountButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.createAccountButton.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.050)
            
        ])
    }
}
 


