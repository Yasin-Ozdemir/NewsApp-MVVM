//
//  CategoryCell.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 27.12.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let id = "categoryCell"
    
    private let categoryButton : UIButton = {
        let button  = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(.systemOrange, for: .normal)
        button.backgroundColor = .black
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCategoryButtonLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCategoryButtons(title : String){
        self.categoryButton.setTitle(title, for: UIControl.State.normal)
        self.categoryButton.addTarget(HomePageViewController(), action: #selector(fetchNews), for: UIControl.Event.allTouchEvents)
    }
    
    @objc func fetchNews(){
        if let category = self.categoryButton.currentTitle{
            HomePageViewModel.currentCategory = category.lowercased()
            HomePageViewModel.currentPage = 0
            HomePageViewModel.homePageVM.fetchNewDatas()
        }
        
    }
    
    private func setupCategoryButtonLayout(){
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoryButton)
        NSLayoutConstraint.activate([
            categoryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            categoryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            categoryButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            categoryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    
}
