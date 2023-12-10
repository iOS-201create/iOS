//
//  FeedViewController.swift
//  iOS_201
//
//  Created by Hyeonho on 12/4/23.
//

import Foundation
import UIKit

import SnapKit

class FeedViewController: UIViewController {

    var coordinator: FeedCoordinator
    
    var viewmodel : FeedViewModel
    
    init(coordinator: FeedCoordinator, viewmodel: FeedViewModel) {
        self.coordinator = coordinator
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.bounces = false
        cv.collectionViewLayout = layout
        cv.backgroundColor = .black01
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cv.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black01
        
        setLayout()
        profileCollectionView.dataSource = self
        profileCollectionView.delegate = self
        
    }
    
    
}

// MARK: - layout

extension FeedViewController {
    func setLayout() {
        /// profileImage collectionView
        view.addSubview(profileCollectionView)
        profileCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}

// MARK: - collectionView Delegate

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.MOCK_Members.members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell
        else {
            fatalError("Fail to Dequeue TodoCell")
        }
         

        cell.configure(imageURL: viewmodel.MOCK_Members.members[indexPath.row].profileImage, nickname: viewmodel.MOCK_Members.members[indexPath.row].nickname)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 24 = 좌우 패딩, 36 = cellSpacing 4 * 9
//        let size = ((self.tierCollectionView.frame.size.width - 24 - 36) / 10)
        
        return CGSize(width: 60, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
