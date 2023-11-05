//
//  StudyListViewModel.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/05.
//

import Foundation
import Alamofire

final class StudyListViewModel {
    
    // MARK: - Properties
    var dataSource: [StudyListModel.Response] = []
    var page = 0
    
    func requestData(isPaging: Bool ,search: String = "", status: String = "", completion: @escaping () -> Void){
        if isPaging { self.page += 1 }
        let url = "https://test.201-study.shop/v1/studies?page=\(page)&search=\(search)&status=\(status)"
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
}
