//
//  LoginViewModel.swift
//  iOS_201
//
//  Created by Hyeonho on 11/5/23.
//

import Foundation
import Combine

class LoginViewModel : ObservableObject {
    enum Input {
        case tabGithubLogin
        case anouncementLogin
        case appleLogin
    }
    
    enum Output {
        case requestCodeSuccess
        case requestCodeFail
    }
    
    /// view에 보내줄 publisher
    private var output : PassthroughSubject<Output,Never> = .init()
    
    var cancellable = Set<AnyCancellable>()
    
    func transform(input: AnyPublisher<Input,Never>) -> AnyPublisher<Output,Never> {
        input
            .sink { event in
                switch event {
                case .tabGithubLogin:
                    self.fetchCodeToGithub()
                case .anouncementLogin:
                    print("비회원 로그인 구현코드 수행")
                case .appleLogin:
                    print("리젝후 만들 애플로그인 수행")
                }
            }
            .store(in: &cancellable)
        return output.eraseToAnyPublisher()
    }

}

extension LoginViewModel {
    func fetchCodeToGithub() {
        AuthService.share.requestGithubCode {
            if $0 {
                self.output.send(.requestCodeSuccess)
                return
            }
            self.output.send(.requestCodeFail)
        }
    }
}
