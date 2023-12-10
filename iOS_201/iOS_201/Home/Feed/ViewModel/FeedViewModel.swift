//
//  FeedViewModel.swift
//  iOS_201
//
//  Created by Hyeonho on 12/9/23.
//

import Foundation

import Alamofire
import RxSwift

class FeedViewModel {
    var studyData: MyStudyModel
    
    var MOCK_Members = StudyMembers.MOCK_StudyMembers
    
    init(studyData: MyStudyModel) {
        self.studyData = studyData
    }
    
    /// 피드조회
    func requestFeed() {
        
    }
    
    
    /// 스터디참여인원 요청
    func requestStudyMembers() -> Observable<StudyMembers> {
        return Observable.create { emit in
            let url = "https://test.201-study.shop/v1/studies/\(self.studyData.id)"
            
            let headers: HTTPHeaders = ["Accept": "application/json"]
            
            AF.request( url,
                        method: .get,
                        headers: headers,
                        interceptor: TokenRequestInterceptor()
            ).responseDecodable(of: StudyMembers.self) { [weak self] response in
                debugPrint(response)
                switch response.result {
                case .success(let members):
                    emit.onNext(members)

                case .failure(let error):
                    print(error.localizedDescription)
                    emit.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
