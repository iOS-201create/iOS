//
//  LoginViewController.swift
//  iOS_201
//
//  Created by Hyeonho on 11/4/23.
//
import Combine
import Foundation
import UIKit

import SnapKit

class LoginViewController: UIViewController {
    
    var coordinator: LoginCoordinator?
    
    let viewmodel = LoginViewModel()
    
    var cancellable = Set<AnyCancellable>()
    
    var input: PassthroughSubject<LoginViewModel.Input, Never> = .init()
    
    private let titleImage = {
        let imageview = UIImageView(image: UIImage(named: "loginTitle"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let stackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 5
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    private lazy var githubBtn: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.title = "깃허브로 시작하기"
        config.image = UIImage(named: "loginGit")?.resize(targetSize: CGSize(width: 24, height: 24))
        config.imagePlacement = .leading
        config.imagePadding = 57
        config.contentInsets = .init(top: 14, leading: 24, bottom: 14, trailing: 105)
        
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.backgroundColor = .black02
        button.layer.borderWidth = 1
        button.configuration = config
        button.layer.borderColor = UIColor(named: "black03")?.cgColor
        return button
    }()
    
    private let anouncementBtn = {
        let button = UIButton()
        button.setTitle("비회원으로 둘러보기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addView()
        setLayout()
        bind()
    }
}

//MARK: - layout

extension LoginViewController {
    func addView() {
        view.addSubview(titleImage)
        view.addSubview(stackView)
        stackView.addArrangedSubview(githubBtn)
        stackView.addArrangedSubview(anouncementBtn)
    }
    
    func setLayout() {
        titleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(193)
            make.leading.equalToSuperview().inset(38)
        }
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-91)
            make.leading.equalTo(view.snp.leading).offset(25)
            make.centerX.equalToSuperview()
        }
    }
}

//MARK: - bind

extension LoginViewController {
    func bind() {
        // 깃헙 로그인
        githubBtn.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { self.input.send(.tabGithubLogin) }
            .store(in: &cancellable)
        
        //비회원 로그인
        
        //애플 로그인
        
        let output = viewmodel.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: RunLoop.main)
            .sink { event in
                switch event {
                case .requestCodeFail:
                    print("차후 AlterView 로 인증실패 알림")
                case .requestCodeSuccess:
                    print("SceneDelegate 의 웹뷰로 이동하게됌")
                }
            }
            .store(in: &cancellable)
    }
}
