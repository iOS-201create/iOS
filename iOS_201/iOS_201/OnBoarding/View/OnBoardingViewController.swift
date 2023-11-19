import Combine
import Foundation
import UIKit

import SnapKit

class OnBoardingViewController: UIViewController {
    
    var coordinator: OnBoardingCoordinator?
    
    var viewmodel = OnBoardingViewModel()
    
    var cancellable: Set<AnyCancellable> = []
    
    var input: PassthroughSubject<OnBoardingViewModel.Input, Never> = .init()
    
    private let scrollview = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .black
        return scrollview
    }()
    
    private let contentView : UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .black
        return contentView
    }()
    
    private let titleVstack = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.axis = .vertical
        return stack
    }()
    
    private let nameVstack = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    private let nameHstack = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }()
    
    private let nameHstack2 = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }()
    
    private let introduceVstack = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    private let introduceHstack = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }()
    
    private let mainTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "나에 대해 소개해주세요!"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24,weight: .bold)
        return label
    }()
    
    private let subTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "나에 대해 소개해주세요!"
        label.textColor = .grey01
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        return label
    }()
    
    private let nameLabel2 : UILabel = {
        let label = UILabel()
        label.text = "2 ~ 8자(공백불가)한글, 영문, 숫자, 언더바(_) 사용 가능"
        label.textColor = .grey01
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var nameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임 입력"
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 14)
        textField.backgroundColor = .black02
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    private lazy var loddingView : UIActivityIndicatorView = {
        let lodding = UIActivityIndicatorView()
        lodding.color = .white
        lodding.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        return lodding
    }()
    
    private let nameResultLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red01
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let introduceLabel : UILabel = {
        let label = UILabel()
        label.text = "간단 소개"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        return label
    }()
    
    private let introduceLabel2 : UILabel = {
        let label = UILabel()
        label.text = "200자 이내"
        label.textColor = .grey01
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var introduceTextView: UITextView = {
        let view = UITextView()
        view.textColor = .white
        view.backgroundColor = .black02
        view.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        view.scrollIndicatorInsets = .init(top: 10, left: 10, bottom: 10, right: 20)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.font = .systemFont(ofSize: 14)
        view.isScrollEnabled = false
        return view
    }()
    
    private let submitBtn : UIButton = {
        let button = UIButton()
        button.setTitle("작성완료", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .green02
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        setNotification()
        setTapMethod()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancellable.removeAll()
    }
}

// MARK: - layout

extension OnBoardingViewController {
    func addView() {
        view.addSubview(scrollview)
        scrollview.addSubview(contentView)
        
        contentView.addSubview(titleVstack)
        
        titleVstack.addArrangedSubview(mainTitleLabel)
        titleVstack.addArrangedSubview(subTitleLabel)
        
        contentView.addSubview(nameVstack)
        nameVstack.addArrangedSubview(nameHstack)
        nameVstack.addArrangedSubview(nameTextField)
        nameVstack.addArrangedSubview(nameHstack2)
        nameHstack2.addArrangedSubview(loddingView)
        nameHstack2.addArrangedSubview(nameResultLabel)
        nameHstack.addArrangedSubview(nameLabel)
        nameHstack.addArrangedSubview(nameLabel2)
        
        contentView.addSubview(introduceVstack)
        introduceVstack.addArrangedSubview(introduceHstack)
        introduceHstack.addArrangedSubview(introduceLabel)
        introduceHstack.addArrangedSubview(introduceLabel2)
        introduceVstack.addArrangedSubview(introduceTextView)
        
        contentView.addSubview(submitBtn)
    }
    
    func setLayout() {
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.edges.equalToSuperview()
            make.height.equalTo(view.snp.height)
        }
        
        titleVstack.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(48)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        nameVstack.snp.makeConstraints { make in
            make.top.equalTo(titleVstack.snp.bottom).offset(51)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        introduceVstack.snp.makeConstraints { make in
            make.top.equalTo(nameVstack.snp.bottom).offset(46)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        introduceTextView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        submitBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.greaterThanOrEqualTo(introduceVstack.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}

//MARK: - Notification

extension OnBoardingViewController {
    
    ///키보드 on off 에 대한 Notification 설정
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    ///텝시 화면 닫게하는 설정
    private func setTapMethod(){
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RunTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollview.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    ///키보드가 올라올때
    @objc func keyBoardWillShow(_ notification : Notification) {
        guard let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height,
            right: 0.0)
        
        scrollview.contentInset = contentInset
        scrollview.scrollIndicatorInsets = contentInset
        
    }
    
    // 키보드 사라질때
    @objc func keyBoardWillHide(_ notification : Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollview.contentInset = contentInset
        scrollview.scrollIndicatorInsets = contentInset
        
    }
    
    /// 탭하여 화면을 내림
    @objc private func RunTapMethod(){
        self.view.endEditing(true)
    }
}

// MARK: - bind

extension OnBoardingViewController {
    func bind() {
        nameTextField.publisher
            .receive(on: DispatchQueue.main)
            .sink {
                self.loddingView.startAnimating()
                self.input.send(.changedTextfield(textfield: $0))
            }
            .store(in: &cancellable)
        
        introduceTextView.textPublisher
            .receive(on: DispatchQueue.main)
            .sink { self.input.send(.changedTextView(textView: $0)) }
            .store(in: &cancellable)
        
        submitBtn.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { self.input.send(.tapSubmitButton) }
            .store(in: &cancellable)
        
        viewmodel.isMatchPasswordInput
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                if result {
                    self?.submitBtn.backgroundColor = .green02
                } else {
                    self?.submitBtn.backgroundColor = .green01
                }
                self?.submitBtn.isEnabled = result
            }
            .store(in: &cancellable)
        
        let output = viewmodel.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                switch event {
                case .valiableNickname(let result):
                    if result {
                        self?.nameResultLabel.text = "사용 가능한 닉네임입니다."
                        self?.nameResultLabel.textColor = .blue01
                    }else{
                        self?.nameResultLabel.text = "중복된 닉네임입니다!"
                        self?.nameResultLabel.textColor = .red01
                    }
                    self?.loddingView.stopAnimating()
                case .submitDidSuccess:
                    self?.coordinator?.goToMain()
                }
            }
            .store(in: &cancellable)
    }
}
