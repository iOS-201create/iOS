//
//  ProfileCollectionViewCell.swift
//  iOS_201
//
//  Created by Hyeonho on 12/9/23.
//

import Foundation
import UIKit

import SnapKit
import Kingfisher

class ProfileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProfileCollectionViewCell"
    
    private let myImageView = UIImageView()

    private let userName = UILabel()
    
    
    func configure(imageURL: String, nickname: String) {
        configureImage(imageURL: imageURL)
        configureUserName(nickname: nickname)
    }
    
    /// configure 프로필이미지
    func configureImage(imageURL: String) {
        myImageView.contentMode = .scaleAspectFit
        myImageView.tintColor = .white
        myImageView.clipsToBounds = true

        /// 테스트용
        myImageView.image = UIImage(named: "tier1")
//        myImageView.kf.setImage(with: URL(string: imageURL))
        myImageView.makeRounded()
        
        addSubview(myImageView)
        myImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(40)
        }
    }
    
    /// configure 닉네임
    func configureUserName(nickname: String) {
        userName.textColor = .gray
        userName.font = .systemFont(ofSize: 10)
        userName.text = nickname
        userName.numberOfLines = 1
        userName.textAlignment = .center
        
        addSubview(userName)
        userName.snp.makeConstraints { make in
            make.top.equalTo(myImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.width.equalTo(myImageView.snp.width)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.myImageView.image = nil
    }

}
