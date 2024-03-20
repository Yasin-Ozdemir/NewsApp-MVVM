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
    var homePageVM : HomePageViewModel!
    func reloadCollectinView(flag: Bool) {
        if flag{
            DispatchQueue.main.async {
                self.newsCollectionView.reloadData()
                self.scrollToFirstItem()
                
            }
            self.newsCollectionView.addInfiniteScroll { collection in
                self.homePageVM.fetchMoreNewsData()
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
        homePageVM = .init(networkManager: NetworkManager(), firebaseManager: FirebaseManager(), delegate: self)
        setupNavigationController()
        self.homePageVM.fetchNewDatas()
        
       // setupCollectionViewLayouts()
   
        setupCollectionViews()
        setupConstraints()
    }
    
    func setupNavigationController(){
        self.view.backgroundColor = .white
        self.navigationItem.title = "NEWS APP"
        self.navigationController?.setupNavBar(backgroundColor: UIColor.systemOrange, textColor: UIColor.black, tintColor: UIColor.black)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Exit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logOut))
    }
    @objc func logOut(){
        self.homePageVM.logOut()
        self.dismiss(animated : true)
    }
    
    func getNewsData(){
     
       
    }
}

extension HomePageViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categorycollectionView{
            return self.homePageVM.numberofItemsInSection(at: 0)
        }else{
            return self.homePageVM.numberofItemsInSection(at: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categorycollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
            cell.homepageVM = homePageVM
            cell.setupCategoryButtons(title: homePageVM.getCategory(indexPath: indexPath))
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.id, for: indexPath) as! NewsCell
        cell.configureNewsCell(cellViewModel: self.homePageVM.newCellViewModels[indexPath.row])
        return cell
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
        let categoryCollectionlayout = UICollectionViewFlowLayout()
        categoryCollectionlayout.itemSize = CGSize(width: categotyWidth , height: categoryHeight )
        categoryCollectionlayout.scrollDirection = .horizontal
        categoryCollectionlayout.minimumLineSpacing = 15
        categoryCollectionlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        categorycollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryCollectionlayout)
        
        
        
        let newsHeight = (self.view.frame.height - categoryHeight) / 1.75
        let newsWidth = self.view.frame.width - 1
        let newsCollectionLayout = UICollectionViewFlowLayout()
       newsCollectionLayout.itemSize = CGSize(width: newsWidth , height: newsHeight)
        newsCollectionLayout.scrollDirection = .vertical
        newsCollectionLayout.minimumInteritemSpacing = 15
        newsCollectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        newsCollectionView = UICollectionView(frame: .zero, collectionViewLayout : newsCollectionLayout)
        
      
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
