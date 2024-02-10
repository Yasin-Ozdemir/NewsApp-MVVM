//
//  NewsCell.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 27.12.2023.
//

import UIKit
import SDWebImage

class NewsCell: UICollectionViewCell {
    
    static let id = "newsCell"
    private var newUrlString = ""
    private var views : [UIView] = []
    private let newImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private let newTextView : UITextView = {
       let txtView = UITextView()
        txtView.textColor = .black
        txtView.font = .systemFont(ofSize: 14, weight: UIFont.Weight.bold)
       
        txtView.isEditable = false
        txtView.isScrollEnabled = false
        
        return txtView
    }()
    
    private let detailButton : UIButton = {
        let button  = UIButton(type: UIKit.UIButton.ButtonType.system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.heavy)
        button.setTitle("Haber Detayı ->", for: UIControl.State.normal)
        
        button.setTitleColor(.systemOrange, for: .normal)
        
        button.addTarget(HomePageViewController(), action: #selector(openNewDetail), for: UIControl.Event.touchUpInside)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        views = [self.newImageView , self.newTextView , self.detailButton]
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
       
        for i in 0...2 {
            presentView(myView: self.views[i])
        }
        
        NSLayoutConstraint.activate([
            newImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            newImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            newImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            newImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55),
            
            newTextView.topAnchor.constraint(equalTo: newImageView.bottomAnchor, constant: 0),
            newTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            newTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            newTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40),
            
            detailButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            detailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            detailButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            detailButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10)
            
            
        ])
        
        
    }
    private  func presentView(myView : UIView){
        myView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(myView)
    }
    
   public func configureNewsCell(title : String , description : String , imageUrlString : String , newUrlString : String){
        guard let imageUrl = URL(string: imageUrlString)  else{
            return
        }
        self.newUrlString = newUrlString
        newImageView.sd_setImage(with: imageUrl)
        
        let attr = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold) , NSAttributedString.Key.foregroundColor : UIColor.black ])
        attr.append(NSAttributedString(string: "\n\(description)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium) , NSAttributedString.Key.foregroundColor : UIColor.black]))
        
        self.newTextView.attributedText = attr
    }
    
     @objc private func openNewDetail(){
        guard let newUrl = URL(string: self.newUrlString) else{
            return
        }
        
        UIApplication.shared.open(newUrl, options: [:], completionHandler: nil)
    }
}
