//
//  StudyListViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/03.
//

import UIKit
import SnapKit

class StudyListViewController: UIViewController {
    
    //MARK: - Properties
    
    let viewModel = StudyListViewModel()
    var isPaging = false
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .black01
        return tv
    }()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black01
        configureNavigationBar(title: "스터디 목록")
        self.configureFilterView()
        viewModel.requestData(isPaging: false) {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        self.configureTableView()
        self.makeStudyButtonView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    private func fetchNextPage(){
        self.isPaging = true
        self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        self.viewModel.requestData(isPaging: true){
            self.isPaging = false
            self.tableView.reloadData()
        }
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(94)
            make.right.bottom.leading.equalToSuperview()
        }
    }
    
    private func makeStudyButtonView(){
        let makeStudyView = UIView()
        makeStudyView.backgroundColor = .green02
        self.view.addSubview(makeStudyView)
        makeStudyView.layer.cornerRadius = 12
        makeStudyView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(42)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(28)
        }
        
        let bookIcon = UIImageView(image: UIImage(named: "bookIcon"))
        makeStudyView.addSubview(bookIcon)
        bookIcon.snp.makeConstraints { make in
            make.width.equalTo(18.1)
            make.height.equalTo(14.3)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        let makeStudyLabel = UILabel()
        makeStudyView.addSubview(makeStudyLabel)
        makeStudyLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        makeStudyLabel.textColor = .white
        makeStudyLabel.text = "스터디 만들기"
        makeStudyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(bookIcon.snp.trailing).offset(4)
        }
    }
    

    // TODO: - 디자인 가이드 잘못되었음, CollectionView로 교체 필요
    private func configureFilterView(){
        let filterStackView = UIStackView()
        filterStackView.axis = .horizontal
        filterStackView.distribution = .equalSpacing
        ["전체", "모집중", "진행중", "수락 대기중"].forEach {
            let label = UILabel()
            label.text = $0 
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
            let view = UIView()
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 10
            view.backgroundColor = .black02
            view.layer.borderColor = UIColor.black03?.cgColor
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            view.snp.makeConstraints { make in
                make.width.equalTo(label.intrinsicContentSize.width + 25.0)
            }
            filterStackView.addArrangedSubview(view)
        }
        self.view.addSubview(filterStackView)
        filterStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(275)
            make.height.equalTo(30)
        }
    }
    
}

extension StudyListViewController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.viewModel.dataSource.count
        }
        else if section == 1 , isPaging {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1{
            let cell = LodingTableViewCell()
            return cell
        }
        let cell = StudyTableViewCell()
        cell.configureCell(data: self.viewModel.dataSource[indexPath.row])
        return cell
    }
    
    // MARK: - TableView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        if offsetY > (contentHeight - height) {
            if isPaging == false {
                fetchNextPage()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
