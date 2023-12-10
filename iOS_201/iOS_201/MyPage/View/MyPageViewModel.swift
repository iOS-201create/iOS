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
    
    /// collectionview하단에 보여질 티어종류
    var tierImages = ["tier1", "tier2", "tier3", "tier4", "tier5"]
    
    /// successRate에 따른 collectionView 데이터
    var collectionImages: [UIImage] = []
    
    var disposable = DisposeBag()
    
    /// request 나의프로필
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
    
    /// successRate에 따른 collectionview 데이터 설정
    ///  (successRate / 20) 만큼 자신의 티어로 색을칠하게 됌.
    func setTierProgressImage(tierProgress: Int, tier: Int) {
        // tierProgress가 5 이상인 경우
        if tierProgress >= 5 {
            for _ in 1 ..< tierProgress / 5 {
                self.collectionImages.append(UIImage(named: "tier\(tier)")!)
            }
            
            for _ in tierProgress / 5 ... 20 {
                self.collectionImages.append(UIImage(named: "tier6")!)
            }
        } else {
            for _ in 1 ... 20 {
                self.collectionImages.append(UIImage(named: "tier6")!)
            }
        }
        
    }
    
}
