//
//  MyPageViewModel.swift
//  iOS_201
//
//  Created by Hyeonho sin on 11/22/23.
//

import Foundation

import Alamofire
import RxSwift

class MyPageViewModel {
    
    var tierImages = ["tier1", "tier2", "tier3", "tier4", "tier5"]
    
    var MOKE_collectionImages: [UIImage] = []
    
    var collectionImages: [UIImage] = []
    
    var disposable = DisposeBag()
    
    init() {
        for _ in 0 ..< 20 {
            MOKE_collectionImages.append(UIImage(named: "tier1")!)
        }
    }
    
    func requestMyProfile() -> Observable<ProfileModel> {
        return Observable.create { emit in
            let url = "https://test.201-study.shop/v1/members/my"
            
            let headers: HTTPHeaders = ["Accept": "application/json"]
            
            AF.request( url,
                       method: .get,
                       headers: headers,
                       interceptor: TokenRequestInterceptor()
            ).responseDecodable(of: ProfileModel.self) { [weak self] response in
                switch response.result {
                case .success(let profile):
                    self?.setTierProgressImage(tierProgress: profile.successfulRoundCount, tier: profile.tier)
                    emit.onNext(profile)
                    
                case .failure(let error):
                    emit.onError(error)
                    print(error.localizedDescription)
                }
            }
            return Disposables.create()
        }
        
    }
    
    func setTierProgressImage(tierProgress: Int, tier: Int) {
        if tierProgress >= 5 {
            for _ in 1 ..< tierProgress / 5 {
                self.collectionImages.append(UIImage(named: "tier\(tier)")!)
            }
            
            for _ in tierProgress / 5 ... 20 {
                self.collectionImages.append(UIImage(named: "tier2")!)
            }
        } else {
            for _ in 1 ... 20 {
                self.collectionImages.append(UIImage(named: "tier\(tier)")!)
            }
        }
        
    }
    
}
