//
//  UIViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/05.
//

import UIKit

extension UIViewController{
    
    /// 오른쪽버튼 이미지이름을 받도록 수정했습니다..!
    func configureNavigationBar(title: String, rightButtonImage: NaviRightButton){
        self.navigationController?.isNavigationBarHidden = true
        let customNavigationBar = CustomNavigationBar()
        customNavigationBar.configureUI(title: title,rightButtonImage: rightButtonImage)
        view.addSubview(customNavigationBar)
        customNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
}
