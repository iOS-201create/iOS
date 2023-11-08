import Combine
import Foundation
import UIKit

import Alamofire

class AuthService {
    static let share = AuthService()
    
    private let clientId = "bcb21de82a95323a376f"
    
    /// 사용할 인증 모델
    @Published var authModel: AuthModel?
    
    func requestCode(completion: @escaping (Bool) -> Void) {
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=\(scope)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            completion(true)
        }else{
            completion(false)
        }
    }
    
    func requestAccessToken(with code: String) {
        let url = "https://test.201-study.shop/v1/login/github/tokens?code=\(code)"
        
        let headers: HTTPHeaders = ["Accept": "application/json"]

        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers
        ).responseDecodable(of: AuthModel.self) { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.authModel = result
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
