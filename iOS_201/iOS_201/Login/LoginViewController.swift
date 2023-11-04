//
//  LoginViewController.swift
//  iOS_201
//
//  Created by Hyeonho on 11/4/23.
//

import Foundation
import UIKit

import SnapKit

class LoginViewController: UIViewController {
    
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
    
    private let btn_Github = {
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
    
    private let btn_AnounceMent = {
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
    }
}

// MARK: layout

extension LoginViewController {
    func addView() {
        view.addSubview(titleImage)
        view.addSubview(stackView)
        stackView.addArrangedSubview(btn_Github)
        stackView.addArrangedSubview(btn_AnounceMent)
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

// MARK: preview
//
//#if DEBUG
//struct loginViewController : UIViewControllerRepresentable {
//    // update
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
//
//    }
//    // makeui
//    @available(iOS 13.0, *)
//    func makeUIViewController(context: Context) -> UIViewController {
//        LoginViewController()
//    }
//}
//@available(iOS 13.0, *)
//struct mainVC_Previews: PreviewProvider {
//    static var previews: some View{
//        Group{
//            loginViewController()
//                .ignoresSafeArea(.all)//미리보기의 safeArea 이외의 부분도 채워서 보여주게됌.
//                .previewDisplayName("iphone 11")
//        }
//    }
//}
//#endif
