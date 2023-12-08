//
//  HomeViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/03.
//

import Foundation
import UIKit

import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController{
    var coordinator: HomeTabCoordinator?
    
    let model = MyStudyModel.MOCK_studyModel
    
    let viewmodel = HomeTabViewModel()
    
    var disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black01
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black01
        configureNavigationBar(title: "홈임", rightButtonImage: "settingBtn")
        
//        tableView.delegate = self
//        tableView.dataSource = self
        config()
        bind()
        
    }
    

}

//MARK: - bind

extension HomeViewController {
    func bind() {
        viewmodel.testLoad()
            .bind(to: tableView.rx.items) {
                (tableView: UITableView,
                 index: Int,
                 element: MyStudyModel?)
                -> UITableViewCell in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else { fatalError() }
                
                cell.setTitle(data: element!)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout

extension HomeViewController {
    func config() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(87)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - tableDelegate

extension HomeViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToFeedView()
    }
}


