//
//  CustomNavigationBar.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/04.
//

import UIKit
import SnapKit

class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        return label
    }()
    
    let searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "searchBtn"), for: .normal)
        btn.setTitle(nil, for: .normal)
        btn.setTitleColor(.clear, for: .normal)
        return btn
    }()
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .black03
        return view
    }()

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func configureUI(title: String) {
        backgroundColor = .black01
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        addSubview(bottomBorder)
        bottomBorder.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        addSubview(searchBtn)
        searchBtn.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.trailingMargin.equalToSuperview().inset(20)
        }
    }
}
