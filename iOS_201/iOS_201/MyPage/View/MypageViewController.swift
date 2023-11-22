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
    
    var collectionImage: [UIImage] = []
    
    var tierImage: [String] = []
    
    var viewmodel = MyPageViewModel()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.bounces = false
        cv.collectionViewLayout = layout
        cv.backgroundColor = .black01
        cv.showsHorizontalScrollIndicator = false
        cv.register(TodoCollectionViewCell.self, forCellWithReuseIdentifier: TodoCollectionViewCell.identifier)
        cv.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
        
        return cv
    }()
    
    let profileHstack: UIStackView = {
        let profileHstack = UIStackView()
        profileHstack.axis = .horizontal
        profileHstack.spacing = 5
        profileHstack.distribution = .fillProportionally
        return profileHstack
    }()
    
    let profileVstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    let profileImage: UIImageView = {
        let imageview = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        imageview.image = .checkmark
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .white
        imageview.makeRounded()
        imageview.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
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
        button.setTitle("프로필 수정", for: .normal)
        button.tintColor = .grey01
        button.backgroundColor = UIColor(cgColor: CGColor(red: 0.22, green: 0.83, blue: 0.33, alpha: 0.4))
        button.layer.cornerRadius = 5
        return button
    }()
    
    let sucessHstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    let studyVstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    let studyImage: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageview.image = UIImage(named: "studyImage")?.resize(targetSize: CGSize(width: 24, height: 24))
        return imageview
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
        stack.alignment = .center
        return stack
    }()
    
    let todoImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "todoImage")?.resize(targetSize: CGSize(width: 24, height: 24))
        return imageview
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
    
    lazy var tierCollectionView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
        }
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        
        let less = UILabel()
        less.text = "less"
        less.font = .systemFont(ofSize: 8)
        less.textColor = .gray
        stack.addArrangedSubview(less)
        
        tierImage.forEach {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
            imageView.image = UIImage(named: $0)?.resize(targetSize: CGSize(width: 8, height: 8))
            imageView.contentMode = .scaleAspectFit
            stack.addArrangedSubview(imageView)
        }
        
        let more = UILabel()
        more.text = "more"
        more.font = .systemFont(ofSize: 8)
        more.textColor = .gray
        stack.addArrangedSubview(more)
        
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            
            make.top.equalTo(collectionView.snp.bottom).offset(12)
            make.leading.greaterThanOrEqualTo(contentView.snp.leading).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
        }
        
        
        
        return contentView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black01
        configureNavigationBar(title: "마이페이지", rightButtonImage: "settingBtn")
        
        for _ in 0 ..< 20 {
            collectionImage.append(UIImage(systemName: "person")!)
        }
        
        for i in 1 ... 5 {
            tierImage.append("tier\(i)")
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        addView()
        setLayout()
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewmodel.requestMyProfile()
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
        
        view.addSubview(profileEditBtn)
        
        view.addSubview(sucessHstack)
        sucessHstack.addArrangedSubview(studyVstack)
        sucessHstack.addArrangedSubview(todoVstack)
        
        studyVstack.addArrangedSubview(studyImage)
        studyVstack.addArrangedSubview(studyLabel)
        studyVstack.addArrangedSubview(studyRate)
        
        todoVstack.addArrangedSubview(todoImage)
        todoVstack.addArrangedSubview(todoLabel)
        todoVstack.addArrangedSubview(todoRate)
        
        view.addSubview(tierCollectionView)
        view.addSubview(introduceTextView)
    }
    
    func setLayout() {
        profileHstack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(96)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        profileEditBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileHstack.snp.bottom).offset(18)
            make.leading.equalTo(view.snp.leading).offset(32)
            make.height.equalTo(30)
        }
        
        sucessHstack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileEditBtn.snp.bottom).offset(50)
            make.leading.equalTo(view.snp.leading).offset(50)
        }
        
        tierCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(sucessHstack.snp.bottom).offset(25)
            make.leading.equalTo(50)
            make.height.equalTo(88)
        }
        
        introduceTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tierCollectionView.snp.bottom).offset(44)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}


//UICollectionViewDelegateFlowLayout
extension MypageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCollectionViewCell.identifier, for: indexPath) as? TodoCollectionViewCell
        else {
            fatalError("Fail to Dequeue TodoCell")
        }
         
        let image = collectionImage[indexPath.row]
        cell.configure(with: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.collectionView.frame.size.width / 10) - 10.8
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
