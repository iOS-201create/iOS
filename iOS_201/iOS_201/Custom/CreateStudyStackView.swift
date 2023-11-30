//
//  CreateStudyStackView.swift
//  iOS_201
//
//  Created by 유준용 on 11/24/23.
//

import UIKit

class CreateStudyStackView: UIStackView {
    
    let inputLb = UILabel()
    var icon: CreateStudyStackView.Icon?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureNumOfPeopleTitle(title: String, desc: String, icon: CreateStudyStackView.Icon){
        self.icon = icon
        self.axis = .vertical
        self.distribution = .equalSpacing
        
        let titleLb = UILabel()
        self.addArrangedSubview(titleLb)
        titleLb.text = title
        titleLb.textColor = .white
        titleLb.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLb.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        self.setCustomSpacing(4, after: titleLb)

        let descLb = UILabel()
        descLb.numberOfLines = 0
        self.addArrangedSubview(descLb)
        descLb.setTextWithLineHeight(text: desc, lineHeight: 16.7)
        descLb.textColor = UIColor(hexCode: "666C77")
        descLb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descLb.snp.makeConstraints { make in
            make.height.equalTo(34)
        }
        self.setCustomSpacing(12, after: descLb)

        let filedBox = UIView()
        filedBox.layer.cornerRadius = 10
        self.addArrangedSubview(filedBox)
        filedBox.backgroundColor = UIColor.black03
        filedBox.layer.borderWidth = 1
        filedBox.layer.borderColor = UIColor.black03?.cgColor
        filedBox.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        inputLb.font = UIFont(name: "Pretendard-Regular", size: 16)
        disable()
        filedBox.addSubview(inputLb)
        inputLb.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: icon.rawValue)
        filedBox.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }
    
    func enable(){
        self.inputLb.textColor = .white
    }
    
    func disable(){
        switch icon {
        case .people:
            inputLb.text = "2명"
        case .period:
            inputLb.text = "약 8주간 진행"
        case .cycle:
            inputLb.text = "1회"
        case nil:
            return
        }
        self.inputLb.textColor = UIColor(hexCode: "#797F8A")
    }
    
    
    enum Icon: String {
        case people, period, cycle
    }
    
}
