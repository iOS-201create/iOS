import Combine
import Foundation
import UIKit

import Alamofire

class AuthService {
    static let share = AuthService()
    
    private let clientId = "05d00879fa4c8a479d3c"
    private let clientSecret = "de4fbff00100b5d8596dc5b2f598d2eeae3edc39"
    
    /// 사용할 인증 모델
    @Published var authModel: AuthModel?
    
    @objc func requestCode(completion: @escaping (Bool) -> Void) {
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=\(scope)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            completion(true)
        }
        completion(false)
    }
    
    func requestAccessToken(with code: String) {
        let url = "https://github.com/login/oauth/access_token"
        let parameters = ["client_id": clientId,
                          "client_secret": clientSecret,
                          "code": code]

        let headers: HTTPHeaders = ["Accept": "application/json"]

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   headers: headers
        ).responseDecodable(of: AuthModel.self) { [weak self] response in
            switch response.result {
            case .success(let result):
                print(result)
                self?.authModel = result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
