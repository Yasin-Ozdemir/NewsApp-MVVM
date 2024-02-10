//
//  HomePageViewModel.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 28.12.2023.
//

import Foundation
import UIKit


private protocol IHomePageViewModel{
    func fetchNewDatas() -> Void
}

class HomePageViewModel : IHomePageViewModel{
  
    private init(){
        
    }
      var IhomePageVC : IHomePageViewController = HomePageViewController()
    
    static let homePageVM = HomePageViewModel()
    static var currentCategory : String = "general"
    static var currentPage : Int = 0
    let firebaseManager = FirebaseManager()
    
    func fetchNewDatas() {

        NetworkManager.shared.downloadNewData(page: HomePageViewModel.currentPage, category: HomePageViewModel.currentCategory) { result, err in
                if err != nil{
                    print(err?.localizedDescription)
                }else{
                    
                    if let result = result{
                        DispatchQueue.main.async {
                          
                                self.newsList = result
                            self.IhomePageVC.reloadCollectinView(flag: true)
                        }
                    }else{
                        print("result error")
                    }
                }
            }
        }
    
    func fetchMoreNewsData(){
        HomePageViewModel.currentPage += 1
        NetworkManager.shared.downloadNewData(page: HomePageViewModel.currentPage, category: HomePageViewModel.currentCategory) { result, err in
                if err != nil{
                    print(err?.localizedDescription)
                }else{
                    
                    if let result = result{
                        DispatchQueue.main.async {
                            for result in result{
                                self.newsList.append(result)
                            }
                      
                        }
                    }else{
                        print("result error")
                    }
                }
            }
    }
    
    func logOut(){
        firebaseManager.logOut()
    }
    
    private var categoryList = ["General" , "Economy" , "Technology" , "Health" , "Sport"]
    
    private var newsList : [Result] = []
    
}

extension HomePageViewModel {
    
    public func numberofItemsInSection(at section : Int) -> Int{
        if section == 0{
            return categoryList.count
        }else{
            return newsList.count
        }
    }
    
    public func getCategory(indexPath : IndexPath) -> String{
        return self.categoryList[indexPath.row]
    }
    
    public func cellForItem(collectionView : UICollectionView ,indexPath: IndexPath ,cellId : String ) -> UICollectionViewCell{
        if cellId == CategoryCell.id{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
            cell.setupCategoryButtons(title: getCategory(indexPath: indexPath))
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsCell
        cell.configureNewsCell(title: self.newsList[indexPath.row].name, description: self.newsList[indexPath.row].description, imageUrlString: self.newsList[indexPath.row].image, newUrlString: self.newsList[indexPath.row].url)
        return cell
    }
  
    
   public func categoryCollectionViewSetup(height : Double , width :Double) -> UICollectionViewFlowLayout{
        let categoryCollectionlayout = UICollectionViewFlowLayout()
        categoryCollectionlayout.itemSize = CGSize(width: width , height: height )
        categoryCollectionlayout.scrollDirection = .horizontal
        categoryCollectionlayout.minimumLineSpacing = 15
        categoryCollectionlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return categoryCollectionlayout
    }
    
    public func newsCollectionViewSetup(height : Double , width :Double) -> UICollectionViewFlowLayout{
        let newsCollectionLayout = UICollectionViewFlowLayout()
       newsCollectionLayout.itemSize = CGSize(width: width , height: height)
        newsCollectionLayout.scrollDirection = .vertical
        newsCollectionLayout.minimumInteritemSpacing = 15
        newsCollectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return newsCollectionLayout
    }
}
