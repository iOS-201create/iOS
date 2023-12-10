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
    
    // 스터디가 아직은없어서 []를 리턴하여 하단에 테스트전용을 만들어두었습니다.
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
    
    /// 테스트용
    func testLoad() -> Observable<[MyStudyModel?]> {
        self.data = MyStudyModel.MOCK_studyModel
        return Observable.just(data)
    }
    
}

