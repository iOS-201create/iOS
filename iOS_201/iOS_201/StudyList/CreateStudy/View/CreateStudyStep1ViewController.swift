//
//  CreateStudyViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/16.
//

import UIKit
import SnapKit

class CreateStudyStep1ViewController: UIViewController {
    
    var coordinator: CreateStudyStep1Coordinator?
    let nextStepBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .yellow
        btn.titleLabel?.text = "다음페이지"
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.view.addSubview(nextStepBtn)
        nextStepBtn.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
            make.height.equalTo(100)
        }
        nextStepBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextStep(_ :))))

    }
    
    @objc func nextStep(_ : UITapGestureRecognizer){
        self.coordinator?.showNextStep()
    }
}
