//
//  RequestInterceptor.swift
//  iOS_201
//
//  Created by Hyeonho sin on 11/22/23.
//

import Foundation
import Alamofire
final class TokenRequestInterceptor: RequestInterceptor {
    
    /// header에 토큰을 추가합니다.
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("https://test.201-study.shop/v1") == true,
              let data = UserDefaults.standard.value(forKey:"authModel") as? Data,
              let authModel = try? PropertyListDecoder().decode(AuthModel.self, from: data) else {
            completion(.success(urlRequest))
            return
        }

        var urlRequest = urlRequest
        urlRequest.setValue(authModel.accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }

    
    // 401에러시, 토큰재발급을 요청합니다.
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard let data = UserDefaults.standard.value(forKey:"authModel") as? Data,
              let authModel = try? PropertyListDecoder().decode(AuthModel.self, from: data)
        else {
            print("RequestInterceptor: retry() - UserDefault is nil")
            return
        }
        
        let url = "https://test.201-study.shop/v1/login/tokens/refresh"
        
        let headers: HTTPHeaders = [ "Accept": "application/json" ]
        
        let params: [String: String] = [ "refreshToken" : authModel.refreshToken ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: headers
        ).responseDecodable(of: AuthModel.self) { [weak self] response in
            debugPrint(response)
            switch response.result {
            case .success(let result):
                print(result)
                AuthService.share.refreshToken(authModel: result)
                completion(.retry)
                
            case .failure(let error):
                completion(.doNotRetryWithError(error))
            }
        }
        
    }
}
