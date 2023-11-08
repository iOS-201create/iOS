import Combine
import Foundation
import UIKit

final class OnBoardingViewModel: ObservableObject {
    
    /// view에서 들어오는 input
    enum Input {
        case tapSubmitButton
        case changedTextfield(textfield: String)
        case changedTextView(textView: String)
    }
    
    /// view에 보내줄 output
    enum Output {
        case valiableNickname(isEnabled: Bool)
        case submitDidSuccess
    }
    
    private var output : PassthroughSubject<Output,Never> = .init() /// view에 보내줄 publisher
    
    private var nickname =  PassthroughSubject<String,Never>()  /// 닉네임
    private var resultNickname = "" /// 서버로 보낼 닉네임
    
    @Published var content = "" /// 소개란
    
    @Published var isEnableNickname = false /// 닉네임 사용가능여부
    
    @Published var authModel: AuthModel?    /// auth

    weak var coordinator: AppCoordinator?   /// coordinator
    
    var cancellable = Set<AnyCancellable>() /// rx로 치면 disposeback?? 그런애
    
    lazy var isMatchPasswordInput = Publishers  /// 닉네임이 가능하고 설명란이 입력되면 버튼이 활성화
        .CombineLatest($isEnableNickname,$content)
        .map{ isEnable, content in
            if isEnable && !content.isEmpty {
                return true
            }
            return false
        }
        .eraseToAnyPublisher()
    
    // MARK: - init
    
    init() {
        AuthService.share.$authModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.authModel = result
            }
            .store(in: &cancellable)
        
        nickname
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] result in
                self?.resultNickname = result
                self?.nicknameInput()
            }
            .store(in: &cancellable)
    }
    
    /// view에서 들어온 input 을 받는곳.
    func transform(input: AnyPublisher<Input,Never>) -> AnyPublisher<Output,Never> {
        input
            .sink { event in
                switch event {
                case .tapSubmitButton:
                    self.submitButtonDidTap()
                case .changedTextfield(let text):
                    self.nickname.send(text)
                case .changedTextView(let text):
                    self.content = text
                }
            }
            .store(in: &cancellable)
        return output.eraseToAnyPublisher()
    }

}

extension OnBoardingViewModel {

    /// 닉네임중복여부 검사
    func nicknameInput() {
        UserService.share.shouldEnalbeNickname(nickname: resultNickname) { result in
            switch result {
            case .success(let nicknameModel):
                if !nicknameModel.exists {
                    self.output.send(.valiableNickname(isEnabled: true))
                    self.isEnableNickname = true
                }else{
                    self.output.send(.valiableNickname(isEnabled: false))
                    self.isEnableNickname = false
                }
            case.failure(let error):
                print("OnBoardingViewModel : checkNickname() error \(error)")
                self.output.send(.valiableNickname(isEnabled: false))
                self.isEnableNickname = false
            }
        }
    }
    
    /// patch - 닉네임, content
    func submitButtonDidTap() {
        UserService.share.patchUserInfo(nickname: resultNickname, content: content, accessToken: authModel?.accessToken ?? "") { result in
            if result {
                print("메인페이지로 이동")
                self.coordinator?.changeToMainView()
            } else {
                print("인증실패 알림.")
            }
        }
    }
}
