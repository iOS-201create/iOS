//
//  StudyListViewModel.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/05.
//

import Foundation
import Alamofire

final class StudyListViewModel {
    
    typealias FilterType = FilterCollectionViewCell.filterType
    
    //MARK: - Properties
    
    var dataSource: [StudyListModel.Response] = []
    var selectedFilter: FilterType                 = .all
    let filterCellTitle                       = ["전체", "모집중", "진행중", "수락 대기중", "시작 대기중"]
    var page                                  = 0
    
    //TODO: - git 정보 받아오기 시작하면 필터에 따라 /study/waiting API콜 해야함.
    func requestData(isPaging: Bool ,search: String = "", completion: @escaping () -> Void){
        if isPaging { self.page += 1
        } else {
            self.page = 0
            self.dataSource.removeAll()
        }
        let status = String(describing: selectedFilter)
        let path = "studies"
        let url = "https://test.201-study.shop/v1/\(path)?page=\(page)&search=\(search)&status=\(status)"
        
        print("page: \(page)", "status: \(status)")
        AF.request(url, method: .get)
            .responseDecodable(of: [StudyListModel.Response].self ,completionHandler: { response in
                switch response.result {
                case .success(let data):
                    
                    self.dataSource.append(contentsOf: data)
                    DispatchQueue.main.async {
                        completion()
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            })
    }
    
    func setFilter(filterType: FilterType){
        self.selectedFilter = filterType
    }
    // ALL, RECRUITING, PROCESSING, END
    // 다른 API -> APPLICANT, NO_ROLE
}
