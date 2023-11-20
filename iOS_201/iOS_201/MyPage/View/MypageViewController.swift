//
//  MypageViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/03.
//

import UIKit

import SnapKit

class MypageViewController: UIViewController {
    
    var coordinator: MyPageTabCoordinator?
    
    let profileHstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillProportionally
        return stack
    }()
    
    let profileVstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    let profileImage: UIImageView = {
        let imageview = UIImageView()
        let image = UIImage(systemName: "person")
        imageview.image = image
        
        imageview.layer.borderWidth = 1
        imageview.layer.masksToBounds = false
        imageview.layer.borderColor = UIColor.black.cgColor
        imageview.layer.cornerRadius = imageview.frame.height/2
        imageview.clipsToBounds = true
        
        imageview.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        imageview.backgroundColor = .white
        return imageview
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "진지한김진우"
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let userID: UILabel = {
        let label = UILabel()
        label.text = "jwt1234"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hexCode: "595959")
        return label
    }()
    
    let profileEditBtn: UIButton = {
        let button = UIButton()
        button.setTitle("작성완료", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .green01
        button.layer.cornerRadius = 5
        return button
    }()
    
    let sucessHstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    let studyVstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    let studyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        return image
    }()
    
    let studyLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디 성공률"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let studyRate: UILabel = {
        let label = UILabel()
        label.text = "76.2%"
        label.textColor = UIColor(hexCode: "A2FF86")
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let todoVstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    let todoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        return image
    }()
    
    let todoLabel: UILabel = {
        let label = UILabel()
        label.text = "필수투두 완료횟수"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let todoRate: UILabel = {
        let label = UILabel()
        label.text = "82회"
        label.textColor = UIColor(hexCode: "A2FF86")
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black01
        configureNavigationBar(title: "마이페이지", rightButtonImage: "settingBtn")
        addView()
        setLayout()
    }
        
    
}

// MARK: - Layout

extension MypageViewController {
    func addView() {
        view.addSubview(profileHstack)
        profileHstack.addArrangedSubview(profileImage)
        profileHstack.addArrangedSubview(profileVstack)
        profileVstack.addArrangedSubview(userName)
        profileVstack.addArrangedSubview(userID)
        
        view.addSubview(sucessHstack)
        sucessHstack.addArrangedSubview(studyVstack)
        sucessHstack.addArrangedSubview(todoVstack)
        
        studyVstack.addArrangedSubview(studyImage)
        studyVstack.addArrangedSubview(studyLabel)
        studyVstack.addArrangedSubview(studyRate)
        
        todoVstack.addArrangedSubview(todoImage)
        todoVstack.addArrangedSubview(todoLabel)
        todoVstack.addArrangedSubview(todoRate)
        
        
    }
    
    func setLayout() {
        profileHstack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(96)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        sucessHstack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileHstack.snp.bottom).offset(50)
            make.leading.equalTo(view.snp.leading).offset(50)
        }
    }
}
