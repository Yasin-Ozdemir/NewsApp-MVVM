//
//  HomePageViewModel.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 28.12.2023.
//

import Foundation


protocol IHomePageViewModel{
    func fetchNewDatas()
    func clearNews()
}

class HomePageViewModel : IHomePageViewModel{
  
  
    var IhomePageVC : IHomePageViewController!
    

    var networkManager : INetworkManager!
    init(networkManager : INetworkManager , firebaseManager : IFireBaseManager , delegate : IHomePageViewController) {
        self.networkManager = networkManager
        self.firebaseManager = firebaseManager
        self.IhomePageVC = delegate
    }
    static var currentCategory : String = "general"
    static var currentPage : Int = 0
    var firebaseManager : IFireBaseManager!
    private var categoryList = ["General" , "Economy" , "Technology" , "Health" , "Sport"]
    
     var newCellViewModels : [NewsCellViewModel] = []

    func clearNews(){
        self.newCellViewModels.removeAll()
    }
    func fetchNewDatas() {

        networkManager.downloadNewData(page: HomePageViewModel.currentPage, category: HomePageViewModel.currentCategory) { result, err in
                if err != nil{
                    print(err?.localizedDescription)
                }else{
                    
                    if let result = result{
                   
                          
                            for result in result{
                                
                                self.newCellViewModels.append(NewsCellViewModel(title: result.name, description: result.description, imageUrlString: result.image, newUrlString: result.url))
                            }
                            self.IhomePageVC.reloadCollectinView(flag: true)
                        
                    }else{
                        self.IhomePageVC.reloadCollectinView(flag: false)
                        print("result error")
                    }
                }
            }
        }
    
    
    
    func fetchMoreNewsData(){
        HomePageViewModel.currentPage += 1
        networkManager.downloadNewData(page: HomePageViewModel.currentPage, category: HomePageViewModel.currentCategory) { result, err in
                if err != nil{
                    print(err?.localizedDescription)
                }else{
                    
                    if let result = result{
                       
                            for result in result{
                                // cell view model oluşturualccak
                                
                                self.newCellViewModels.append(NewsCellViewModel(title: result.name, description: result.description, imageUrlString: result.image, newUrlString: result.url))
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
    

    
}

extension HomePageViewModel {
    
    public func numberofItemsInSection(at section : Int) -> Int{
        if section == 0{
            return categoryList.count
        }else{
            return newCellViewModels.count
        }
    }
    
    public func getCategory(indexPath : IndexPath) -> String{
        return self.categoryList[indexPath.row]
    }
   
  

}
