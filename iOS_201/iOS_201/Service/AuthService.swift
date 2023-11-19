import Combine
import Foundation
import UIKit

import Alamofire

class AuthService {
    static let share = AuthService()
    
    private let clientId = "bcb21de82a95323a376f"
    
    /// 사용할 인증 모델
    @Published var authModel: AuthModel?
    
    func requestGithubCode(completion: @escaping (Bool) -> Void) {
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=\(scope)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            completion(true)
        }else{
            completion(false)
        }
    }
    
    func requestToken(with code: String) {
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
                self?.saveToken(authModel: result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //TODO: 차후 Keychain으로 변경할 예정입니다!
    // UserDefault 임시로 에 받아온 authModel을 저장합니다
    // authModel은 accessToken과 accessToken을 가지고 있습니다.
    func saveToken(authModel: AuthModel) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(authModel), forKey:"authModel")
    }
    
    func refreshToken() {
        guard let data = UserDefaults.standard.value(forKey:"authModel") as? Data,
              let authModel = try? PropertyListDecoder().decode(AuthModel.self, from: data)
        else {
            print("UserDefault에 저장된 모델이 없습니다.")
            return
        }
        
        let url = "https://test.201-study.shop/v1/login/tokens/refresh"
        
        let headers: HTTPHeaders = [ "Accept": "application/json" ]
        
        let params: [String: String] = [ "refreshToken" : authModel.refreshToken ]

        AF.request(url,
                   method: .patch,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: headers
        ).responseDecodable(of: AuthModel.self) { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.authModel = result
                self?.saveToken(authModel: result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}
