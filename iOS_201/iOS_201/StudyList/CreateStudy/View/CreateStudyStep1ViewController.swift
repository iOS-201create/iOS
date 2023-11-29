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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black01
        self.configureNavigationBar(title: "스터디 만들기", rightButtonImage: .none)
        let vm = CreateStudyViewModel()
        configureStackView()
    }
    
    private func configureStackView(){
        let numOfPeopleStackView = CreateStudyStackView()
        numOfPeopleStackView.configureNumOfPeopleTitle(title: "몇 명과 함께하시나요?", desc: "스터디 인원을 알려주세요!\n스터디원은 최소 2명, 최대 8명과 함께할 수 있습니다",icon: .people)
        self.view.addSubview(numOfPeopleStackView)
        numOfPeopleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24 + ShareConstant.shared.naviBarAndTopSafeAreaHeight)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        let periodStackView = CreateStudyStackView()
        periodStackView.configureNumOfPeopleTitle(title: "스터디는 최소 몇 주간 진행되나요?", desc: "진행될 스터디가 최소 몇 주 진행되는지 알려주세요!\n스터디는 주 단위로 제공됩니다", icon: .period)
        self.view.addSubview(periodStackView)
         
        periodStackView.snp.makeConstraints { make in
            make.top.equalTo(numOfPeopleStackView.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        let repeatStackView = CreateStudyStackView()
        repeatStackView.configureNumOfPeopleTitle(title: "한 주에 몇 회 진행되나요?", desc: "진행될 스터디가 한 주에 몇 회 진행되는지 알려주세요!\n정확한 요일은 스터디가 시작될 때 입력할 수 있습니다", icon: .cycle)
        self.view.addSubview(repeatStackView)
        repeatStackView.snp.makeConstraints { make in
            make.top.equalTo(periodStackView.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        let bottomButton = BottomButton()
        bottomButton.configureButton(title: "다음")
        self.view.addSubview(bottomButton)
        bottomButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(36)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    @objc func nextStep(_ : UITapGestureRecognizer){
        self.coordinator?.showNextStep()
    }
}

