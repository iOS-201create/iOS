//
//  MypageViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/03.
//

import UIKit

import Kingfisher
import RxSwift
import RxCocoa
import SnapKit

class MypageViewController: UIViewController {
    
    var coordinator: MyPageTabCoordinator?
    
    var viewmodel = MyPageViewModel()
    
    var disposeBag = DisposeBag()
    
    /// 닉네임 & githubID 가 들어가는 vstack
    let profileVstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillProportionally
        stack.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        return stack
    }()
    
    /// profile Image
    let profileImage: UIImageView = {
        let imageview = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        imageview.image = UIImage(systemName: "person")
        imageview.contentMode = .scaleAspectFit
        imageview.backgroundColor = .white
        imageview.makeRounded()
        return imageview
    }()
    
    /// 닉네임
    let userName: UILabel = {
        let label = UILabel()
        label.text = "진지한김진우"
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    /// githubID
    lazy var githubID: UILabel = {
        let label = UILabel()
        label.text = "jwt1234"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hexCode: "595959")
        return label
    }()
    
    /// 프로필수정 버튼 -> 어케동작되는지 플로우를 모르겠음
    let profileEditBtn: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 수정", for: .normal)
        button.tintColor = .grey01
        button.backgroundColor = UIColor(cgColor: CGColor(red: 0.22, green: 0.83, blue: 0.33, alpha: 0.4))
        button.layer.cornerRadius = 5
        return button
    }()
    
    /// 스터디 성공률 & 필수투두 완료횟수를 담는 Hstack
    let rateHstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    /// 스터디성공률을 담는 vstack
    let studyVstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    /// 스터디성공률의 Image
    let studyImage: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageview.image = UIImage(named: "studyImage")?.resize(targetSize: CGSize(width: 24, height: 24))
        return imageview
    }()
    
    /// 스터디성공률의 기본text
    let studyLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디 성공률"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    /// 스터디성공률
    let studyRate: UILabel = {
        let label = UILabel()
        label.text = "76.2%"
        label.textColor = UIColor(hexCode: "A2FF86")
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    /// 투두성공률을 담는 vstack
    let todoVstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    /// 투두성공률의 image
    let todoImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "todoImage")?.resize(targetSize: CGSize(width: 24, height: 24))
        return imageview
    }()
    
    /// 투두성공률의 기본text
    let todoLabel: UILabel = {
        let label = UILabel()
        label.text = "필수투두 완료횟수"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    /// 투두성공률횟수
    let todoRate: UILabel = {
        let label = UILabel()
        label.text = "76번"
        label.textColor = UIColor(hexCode: "A2FF86")
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    /// successRate를 보여줄 collectionView
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.bounces = false
        cv.collectionViewLayout = layout
        cv.backgroundColor = .black01
        cv.showsHorizontalScrollIndicator = false
        cv.register(TodoCollectionViewCell.self, forCellWithReuseIdentifier: TodoCollectionViewCell.identifier)
        
        return cv
    }()
    
    /// collectionView 와 collectionview하단의 티어표를 합친 뷰
    lazy var tierCollectionView: UIView = {
        
        /// collectionView 와 collectionview하단의 티어표를 합친 뷰
        let contentView = UIView()
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(60)
            
        }
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        
        /// collectionView 하단의 티어표 글자
        let less = UILabel()
        less.text = "less"
        less.font = .systemFont(ofSize: 8)
        less.textColor = .gray
        stack.addArrangedSubview(less)
        
        /// collectionView 하단의 티어표
        viewmodel.tierImages.forEach {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
            imageView.image = UIImage(named: $0)?.resize(targetSize: CGSize(width: 8, height: 8))
            imageView.contentMode = .scaleAspectFit
            stack.addArrangedSubview(imageView)
        }
        
        /// collectionView 하단의 티어표 글자2
        let more = UILabel()
        more.text = "more"
        more.font = .systemFont(ofSize: 8)
        more.textColor = .gray
        stack.addArrangedSubview(more)
        
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.greaterThanOrEqualTo(contentView.snp.leading).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
        }
        
        return contentView
    }()
    
    /// 자기소개뷰
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
        addView()
        setLayout()
        bind()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
        
    
}

// MARK: - bind

extension MypageViewController {
    func bind() {
        viewmodel.requestMyProfile()
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] profileModel in
                self?.githubID.text = profileModel.githubId
                self?.userName.text = profileModel.nickname
                self?.introduceTextView.text = profileModel.introduction
                self?.profileImage.kf.setImage(with: URL(string: profileModel.profileImageUrl))
                self?.studyRate.text = "\(profileModel.successRate)회"
                self?.todoRate.text = "\(profileModel.successfulRoundCount)회"
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
}

// MARK: - Layout

extension MypageViewController {
    func addView() {
        view.addSubview(profileImage)
        view.addSubview(profileVstack)
        view.addSubview(profileEditBtn)
        view.addSubview(rateHstack)
        view.addSubview(tierCollectionView)
        view.addSubview(introduceTextView)
        
        profileVstack.addArrangedSubview(userName)
        profileVstack.addArrangedSubview(githubID)
        
        rateHstack.addArrangedSubview(studyVstack)
        rateHstack.addArrangedSubview(todoVstack)
        
        studyVstack.addArrangedSubview(studyImage)
        studyVstack.addArrangedSubview(studyLabel)
        studyVstack.addArrangedSubview(studyRate)
        
        todoVstack.addArrangedSubview(todoImage)
        todoVstack.addArrangedSubview(todoLabel)
        todoVstack.addArrangedSubview(todoRate)

    }
    
    func setLayout() {
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(89)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.size.equalTo(50)
        }
        
        profileVstack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(89)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.trailing.equalTo(view.snp.trailing).offset(40)
            make.height.equalTo(50)
        }
        
        profileEditBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(18)
            make.leading.equalTo(view.snp.leading).offset(32)
            make.height.equalTo(30)
        }
        
        rateHstack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileEditBtn.snp.bottom).offset(50)
            make.leading.equalTo(view.snp.leading).offset(50)
        }
        
        tierCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rateHstack.snp.bottom).offset(25)
            make.leading.equalTo(50)
            make.height.equalTo(90)
        }
        
        introduceTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tierCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MypageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.collectionImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCollectionViewCell.identifier, for: indexPath) as? TodoCollectionViewCell
        else {
            fatalError("Fail to Dequeue TodoCell")
        }
         
        let image = viewmodel.collectionImages[indexPath.row]
        cell.configure(with: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 24 = 좌우 패딩
        // 36 = cellSpacing 4 * 9
        let size = ((self.tierCollectionView.frame.size.width - 24 - 36) / 10)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}
