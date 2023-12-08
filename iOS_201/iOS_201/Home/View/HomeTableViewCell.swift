//
//  HomeTableViewCell.swift
//  iOS_201
//
//  Created by Hyeonho on 11/30/23.
//

import Foundation
import UIKit

import SnapKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black01
        configurContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configurContainer() {
        self.addSubview(containerView)
        containerView.backgroundColor = .black02
        containerView.layer.borderColor = UIColor(red: 0.196, green: 0.212, blue: 0.235, alpha: 1).cgColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 8
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setTitle(data: MyStudyModel) {
        /// 스터디 이름
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20,weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.text = data.name
        
        /// 화살표이미지
        let nextImage = UIImageView(image: UIImage(named: "nextImage"))
        nextImage.contentMode = .scaleAspectFit
        
        /// 구분선
        let bottomBolder = UIView()
        bottomBolder.backgroundColor = UIColor(red: 0.196, green: 0.212, blue: 0.235, alpha: 1)
        
        if data.isMaster {
            let kingImage = UIImageView(image: UIImage(named: "kingImage"))
            kingImage.contentMode = .scaleAspectFit
            
            containerView.addSubview(kingImage)
            kingImage.snp.makeConstraints { make in
                make.top.equalTo(containerView.snp.top).offset(13)
                make.leading.equalTo(containerView.snp.leading).offset(16)
                make.size.equalTo(20)
            }
        }
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(nextImage)
        containerView.addSubview(bottomBolder)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(13)
            if data.isMaster {
                make.leading.equalTo(containerView.snp.leading).offset(56)
            } else {
                make.leading.equalTo(containerView.snp.leading).offset(16)
            }
            
            make.trailing.lessThanOrEqualTo(nextImage.snp.leading).offset(-10)
        }
        
        nextImage.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(13)
            make.trailing.equalTo(containerView.snp.trailing).offset(-12)
            make.size.equalTo(20)
        }
        
        bottomBolder.snp.makeConstraints { make in
            make.top.equalTo(nextImage.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        
        
        /// Must Do
        let defaultText = UILabel()
        defaultText.text = "Must Do"
        defaultText.font = .systemFont(ofSize: 14)
        defaultText.textColor = UIColor(hexCode: "6D7681", alpha: 1)
        
        /// d-day
        let dateCount = UILabel()
        dateCount.text = "D - \(data.leftDays)"
        dateCount.font = .systemFont(ofSize: 14)
        dateCount.textColor = UIColor(hexCode: "6D7681", alpha: 1)
        
        /// todo 내용
        let todoContent = UILabel()
        todoContent.text = data.todoContent
        todoContent.font = .systemFont(ofSize: 16)
        todoContent.textColor = .white
        
        /// todo를 인증하면 잔디를 드려요.
        let infoText = UILabel()
        infoText.text = "Must Do를 인증하면 잔디씨앗을 드려요! \n스터디를 완주하면 잔디를 심어드려요!"
        infoText.font = .systemFont(ofSize: 10)
        infoText.textColor = UIColor(hexCode: "6D7681", alpha: 1)
        infoText.numberOfLines = 0
        
        /// 잔디이미지
        let seedImage = UIImageView(image: UIImage(named: "tier2"))
        seedImage.contentMode = .scaleAspectFit
        
        /// 잔디개수
        let seedCount = UILabel()
        seedCount.text = "\(data.grassCount)개"
        seedCount.textColor = .white
        seedCount.font = .systemFont(ofSize: 14)
        
        containerView.addSubview(defaultText)
        containerView.addSubview(dateCount)
        containerView.addSubview(todoContent)
        containerView.addSubview(infoText)
        containerView.addSubview(seedImage)
        containerView.addSubview(seedCount)
        
        defaultText.snp.makeConstraints { make in
            make.top.equalTo(bottomBolder.snp.bottom).offset(12)
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        dateCount.snp.makeConstraints { make in
            make.top.equalTo(defaultText.snp.top)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
        }
        
        todoContent.snp.makeConstraints { make in
            make.top.equalTo(defaultText.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        infoText.snp.makeConstraints { make in
            make.top.equalTo(todoContent.snp.bottom).offset(25)
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.bottom.equalTo(containerView.snp.bottom).offset(-18)
        }
        
        seedImage.snp.makeConstraints { make in
            make.top.equalTo(infoText.snp.top)
            make.leading.greaterThanOrEqualTo(infoText.snp.trailing).offset(10)
            make.trailing.equalTo(seedCount.snp.leading).offset(-4)
            make.size.equalTo(20)
        }
        
        seedCount.snp.makeConstraints { make in
            make.top.equalTo(infoText.snp.top)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
            
        }
        
    }
    
}
