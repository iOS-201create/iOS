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
    
    private var output : PassthroughSubject<Output,Never> = .init() /// view에 보내줄 publisher

    weak var coordinator : AppCoordinator?
    
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
        AuthService.share.requestCode {
            if $0 {
                print("LoginViewModel : fetchCodaToGithub() - 인증성공 알림호출 & 화면이동")
                self.output.send(.requestCodeSuccess)
                self.coordinator?.goToOnBoardingView()
                return
            }
            self.output.send(.requestCodeFail)
            print("LoginViewModel : fetchCodaToGithub() - 인증실패 알림 호출")
        }
    }
}
