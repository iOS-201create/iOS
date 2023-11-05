//
//  UIViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/05.
//

import UIKit

extension UIViewController{
    
    func configureNavigationBar(title: String){
        self.navigationController?.isNavigationBarHidden = true
        let customNavigationBar = CustomNavigationBar()
        customNavigationBar.configureUI(title: title)
        view.addSubview(customNavigationBar)
        customNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
}
