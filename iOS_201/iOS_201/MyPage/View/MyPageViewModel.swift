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
    
    var collectionImages: [UIImage] = []
    
    var disposable = DisposeBag()
    
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
                    print(profile.tier)
                    self?.setTierProgressImage(tierProgress: 80, tier: profile.tier)
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
        if tierProgress > 5 {
            for _ in 1 ..< tierProgress / 5 {
                self.collectionImages.append(UIImage(named: "tier\(tier)")!)
            }
            
            for _ in tierProgress / 5 ... 20 {
                self.collectionImages.append(UIImage(named: "tier2")!)
            }
        } else {
            for _ in tierProgress / 5 ... 20 {
                self.collectionImages.append(UIImage(named: "tier2")!)
            }
        }
        
    }
    
//    func testRefresh() {
////        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
////            completion(.doNotRetryWithError(error))
////            return
////        }
//        
//        guard let data = UserDefaults.standard.value(forKey:"authModel") as? Data,
//              let authModel = try? PropertyListDecoder().decode(AuthModel.self, from: data)
//        else {
//            print("RequestInterceptor: retry() - UserDefault is nil")
//            return
//        }
//        
//        let url = "https://test.201-study.shop/v1/login/tokens/refresh"
//        
//        let headers: HTTPHeaders = [ "Accept": "application/json" ]
//        
//        let params: [String: String] = [ "refreshToken" : authModel.refreshToken ]
//        
//        AF.request(url,
//                   method: .post,
//                   parameters: params,
//                   encoding: JSONEncoding.default,
//                   headers: headers
//        ).responseDecodable(of: AuthModel.self) { [weak self] response in
//            debugPrint(response)
//            switch response.result {
//            case .success(let result):
//                print(result)
//                AuthService.share.refreshToken(authModel: result)
////                completion(.retry)
//                
//            case .failure(let error):
////                completion(.doNotRetryWithError(error))
//                print(error)
//            }
//        }
//    }
}
