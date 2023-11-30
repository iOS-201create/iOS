//
//  BottomButton.swift
//  iOS_201
//
//  Created by 유준용 on 11/29/23.
//

import UIKit

class BottomButton: UIView {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton(title: String){
        configureTitleLabel(title: title)
        self.layer.cornerRadius = 16
    }
    
    func enable(){
        titleLabel.textColor = .white
        self.backgroundColor = UIColor(hexCode: "#39D353", alpha: 0.9)
    }
    
    func disable(){
        titleLabel.textColor = UIColor(hexCode: "#799E82")
        self.backgroundColor = UIColor(hexCode: "#39D353", alpha: 0.4)
    }
    
    func configureTitleLabel(title: String){
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.text = title
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        disable()
    }
}
