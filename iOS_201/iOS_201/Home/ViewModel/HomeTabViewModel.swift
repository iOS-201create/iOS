//
//  HomeTabViewModel.swift
//  iOS_201
//
//  Created by Hyeonho on 12/3/23.
//

import Foundation

import Alamofire
import RxSwift

class HomeTabViewModel {
    
    var data : [MyStudyModel?] = []
    
    func requestHomeFeed() -> Observable<[MyStudyModel?]> {
        return Observable.create { emit in
            let url = "https://test.201-study.shop/v1/home"
            
            let headers: HTTPHeaders = ["Accept": "application/json"]
            
            AF.request( url,
                        method: .get,
                        headers: headers,
                        interceptor: TokenRequestInterceptor()
            ).responseDecodable(of: [MyStudyModel?].self) { [weak self] response in
                debugPrint(response)
                switch response.result {
                case .success(let home):
                    self?.data = home
                    emit.onNext(home)
                case .failure(let error):
                    print(error.localizedDescription)
                    emit.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func testLoad() -> Observable<[MyStudyModel?]> {
        self.data = MyStudyModel.MOCK_studyModel
        return Observable.just(data)
    }
    
//    func requestHomeFeed2() -> Observable<[MyStudyModel]>? {
//        if let data = data {
//            return Observable.of(data)
//        } else {
//            return nil
//        }
//    }
    
}

