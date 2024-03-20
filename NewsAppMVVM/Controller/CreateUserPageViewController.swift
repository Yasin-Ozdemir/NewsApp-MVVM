//
//  CreateUserPageViewController.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 8.02.2024.
//

import UIKit



class CreateUserPageViewController: UIViewController {
    var signPagesViewModel : SignPagesViewModel?
    
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
    
    private let passwordTextField2 : UITextField = {
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
        txtfield.textContentType = .username
        txtfield.translatesAutoresizingMaskIntoConstraints = false
        txtfield.isSecureTextEntry = true
        return txtfield
    }()
    
    private let createImageView :UIImageView = {
       var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
        imageView.backgroundColor = .black
        imageView.tintColor = .systemOrange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let createButton :UIButton = {
       var button = UIButton()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 10
        button.setTitle("CREATE USER", for: UIControl.State.normal)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        button.addTarget(self, action: #selector(createUser), for: UIControl.Event.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupConstraints()
      
    }
    
    @objc func createUser(){
        guard let signPagesViewModel = signPagesViewModel else{
            return
        }
        let mail = mailTextField.text!
        let password = passwordTextField2.text!
        if mail.isEmpty == false && password.isEmpty == false{
            signPagesViewModel.createUser(mail: mail, password: password) { err in
                if err == nil{
                    
                    
                }else{
                    self.present(AlertManager.manager.showAlert(title: "ERROR", message: err!.localizedDescription), animated: true)
                }
             
            }
            
            self.backLoginVC()
           
        }else{
            self.present(AlertManager.manager.showAlert(title: "ERROR", message: "Please Enter Your Mail/Password"), animated: true)
        }
    }
    func backLoginVC(){
        print("back")
        self.navigationController?.popViewController(animated: true)
    }
    
  
}

extension CreateUserPageViewController{
    func setupConstraints(){
        view.addSubview(createImageView)
        view.addSubview(mailTextField)
        view.addSubview(passwordTextField2)
        view.addSubview(createButton)
        NSLayoutConstraint.activate([
            self.createImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.createImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.createImageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            self.createImageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            
            self.mailTextField.topAnchor.constraint(equalTo: self.createImageView.bottomAnchor, constant: 30),
            self.mailTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.mailTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.mailTextField.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
            
            self.passwordTextField2.topAnchor.constraint(equalTo: self.mailTextField.bottomAnchor, constant: 20),
            self.passwordTextField2.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.passwordTextField2.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.passwordTextField2.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
            
            self.createButton.topAnchor.constraint(equalTo: passwordTextField2.bottomAnchor, constant: 25),
            self.createButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.createButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.createButton.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
            
            
        ])
    }
    
    func setupNavigationController(){
        self.navigationItem.title = "Create User"
        
    }
}
