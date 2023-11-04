//
//  OnBoardingViewController.swift
//  iOS_201
//
//  Created by Hyeonho on 11/4/23.
//
import Foundation
import SwiftUI
import UIKit

import SnapKit

class OnBoardingViewController: UIViewController {
    
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
    
    private let vstack_title = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.axis = .vertical
//        stack.backgroundColor = .red
        return stack
    }()
    
    private let vstack_name = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
//        stack.backgroundColor = .green
        return stack
    }()
    
    private let hstack_name = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }()
    
    private let vstack_introduce = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
//        stack.backgroundColor = .blue
        return stack
    }()
    
    private let hstack_introduce = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }()
    
    private let lb_mainTitle : UILabel = {
        let label = UILabel()
        label.text = "나에 대해 소개해주세요!"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24,weight: .bold)
        return label
    }()
    
    private let lb_subTitle : UILabel = {
        let label = UILabel()
        label.text = "나에 대해 소개해주세요!"
        label.textColor = .grey01
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let lb_name1 : UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        return label
    }()
    
    private let lb_name2 : UILabel = {
        let label = UILabel()
        label.text = "2 ~ 8자(공백불가)한글, 영문, 숫자, 언더바(_) 사용 가능"
        label.textColor = .grey01
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let tf_name : UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임 입력"
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 14)
        textField.backgroundColor = .black02
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let lb_nameResult : UILabel = {
        let label = UILabel()
        label.text = "중복된 닉네임입니다!"
        label.textColor = .red01
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let lb_introduce1 : UILabel = {
        let label = UILabel()
        label.text = "간단 소개"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        return label
    }()
    
    private let lb_introduce2 : UILabel = {
        let label = UILabel()
        label.text = "200자 이내"
        label.textColor = .grey01
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let tv_introduce: UITextView = {
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
    
    private let btn_submit : UIButton = {
        let button = UIButton()
        button.setTitle("작성완료", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .green02
        button.layer.cornerRadius = 10
//        button.addTarget(viewmodel, action: #selector(viewmodel.showLog), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        setNotification()
        setTapMethod()
    }
}

// MARK: layout

extension OnBoardingViewController {
    func addView() {
        view.addSubview(scrollview)
        scrollview.addSubview(contentView)
        
        contentView.addSubview(vstack_title)
        
        vstack_title.addArrangedSubview(lb_mainTitle)
        vstack_title.addArrangedSubview(lb_subTitle)
        
        contentView.addSubview(vstack_name)
        vstack_name.addArrangedSubview(hstack_name)
        vstack_name.addArrangedSubview(tf_name)
        vstack_name.addArrangedSubview(lb_nameResult)
        hstack_name.addArrangedSubview(lb_name1)
        hstack_name.addArrangedSubview(lb_name2)
        
        contentView.addSubview(vstack_introduce)
        vstack_introduce.addArrangedSubview(hstack_introduce)
        hstack_introduce.addArrangedSubview(lb_introduce1)
        hstack_introduce.addArrangedSubview(lb_introduce2)
        vstack_introduce.addArrangedSubview(tv_introduce)
        
        contentView.addSubview(btn_submit)
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
        
        vstack_title.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(48)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        tf_name.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        vstack_name.snp.makeConstraints { make in
            make.top.equalTo(vstack_title.snp.bottom).offset(51)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        vstack_introduce.snp.makeConstraints { make in
            make.top.equalTo(vstack_name.snp.bottom).offset(46)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        tv_introduce.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        btn_submit.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(vstack_introduce.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(32)
            make.height.equalTo(50)
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
        
        /// 키보드 프레임의 높이 사이즈를 구함 - 23.10.23 신현호
        guard let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        
        /// 키보드 높이만큼 화면을 늘려야하기에 그 높이를 구함 - 23.10.23 신현호
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height,
            right: 0.0)
        
        /// scrollview 에 위에서 구한 contentInset을 줌 - 23.10.23 신현호
        scrollview.contentInset = contentInset
        scrollview.scrollIndicatorInsets = contentInset
    }
    
    ///키보드가 사라질때
    @objc func keyBoardWillHide(_ notification : Notification) {
        
        /// contentInset을 0 으로 함
        let contentInset = UIEdgeInsets.zero
        
        /// scrollview에 contentInset 을 적용함
        scrollview.contentInset = contentInset
        scrollview.scrollIndicatorInsets = contentInset
    }
    
    @objc private func RunTapMethod(){
        self.view.endEditing(true)
    }
}

// MARK: preview

#if DEBUG
struct onboardingViewController : UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){

    }
    // makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        OnBoardingViewController()
    }
}
@available(iOS 13.0, *)
struct mainVC_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            onboardingViewController()
                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
                .previewDisplayName("iphone 11")
        }
    }
}
#endif
