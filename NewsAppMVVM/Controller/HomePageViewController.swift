//
//  HomePageViewController.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 27.12.2023.
//

import UIKit
import UIScrollView_InfiniteScroll

protocol IHomePageViewController{
    func reloadCollectinView(flag : Bool) -> Void
}

class HomePageViewController: UIViewController , IHomePageViewController  {
    func reloadCollectinView(flag: Bool) {
        if flag{
            DispatchQueue.main.async {
                self.newsCollectionView.reloadData()
                self.scrollToFirstItem()
                
            }
            self.newsCollectionView.addInfiniteScroll { collection in
                HomePageViewModel.homePageVM.fetchMoreNewsData()
                DispatchQueue.main.async {
                    self.newsCollectionView.reloadData()
                }
                self.newsCollectionView.finishInfiniteScroll()
            }
        }
    }
    
    func scrollToFirstItem() {
           let indexPath = IndexPath(item: 0, section: 0)
           newsCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
       }
    
  
    private var categorycollectionView : UICollectionView!
    private var newsCollectionView : UICollectionView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavTitle()
        getNewsData()
        view.backgroundColor = .white
        setupCollectionViewLayouts()
        setupConstraints()
        setupCollectionViews()
    }
    
    func setupNavTitle(){
        self.navigationItem.title = "NEWS APP"
        self.navigationController?.setupNavBar(backgroundColor: UIColor.systemOrange, textColor: UIColor.black, tintColor: UIColor.black)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: #selector(logOut))
    }
    @objc func logOut(){
        HomePageViewModel.homePageVM.logOut()
        self.dismiss(animated: true)
    }
    
    func getNewsData(){
        HomePageViewModel.homePageVM.IhomePageVC = self
        HomePageViewModel.homePageVM.fetchNewDatas()
    }
}

extension HomePageViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categorycollectionView{
            return HomePageViewModel.homePageVM.numberofItemsInSection(at: 0)
        }else{
            return HomePageViewModel.homePageVM.numberofItemsInSection(at: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categorycollectionView{
            return HomePageViewModel.homePageVM.cellForItem(collectionView: collectionView, indexPath: indexPath, cellId: CategoryCell.id)
        }
        
        return HomePageViewModel.homePageVM.cellForItem(collectionView: collectionView, indexPath: indexPath, cellId: NewsCell.id)
        }
  
    private func setupCollectionViews(){
        categorycollectionView.delegate = self
        categorycollectionView.dataSource = self
        categorycollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.id)
        
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.id)
        }
    
    private func setupCollectionViewLayouts(){
     let categoryHeight =  self.view.frame.height * 0.06
        let categotyWidth = self.view.frame.height * 0.12
        categorycollectionView = UICollectionView(frame: .zero, collectionViewLayout: HomePageViewModel.homePageVM.categoryCollectionViewSetup(height: categoryHeight, width: categotyWidth))
        
        let newsHeight = (self.view.frame.height - categoryHeight) / 1.75
        let newsWidth = self.view.frame.width - 1
        newsCollectionView = UICollectionView(frame: .zero, collectionViewLayout:HomePageViewModel.homePageVM.newsCollectionViewSetup(height: newsHeight, width: newsWidth))
        
      
    }
    
    private func setupConstraints(){
        
        presentView(myView: categorycollectionView)
        presentView(myView: newsCollectionView)
        NSLayoutConstraint.activate([
            categorycollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            categorycollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            categorycollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            categorycollectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
            newsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            newsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            newsCollectionView.topAnchor.constraint(equalTo: categorycollectionView.bottomAnchor, constant: 0),
            newsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func presentView(myView : UIView){
        myView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myView)
    }
}
