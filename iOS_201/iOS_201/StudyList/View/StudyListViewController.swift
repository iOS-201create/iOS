//
//  StudyListViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/03.
//

import UIKit
import SnapKit

class StudyListViewController: UIViewController {
    
    typealias FilterType        = FilterCollectionViewCell.filterType
    
    //MARK: - Properties
    
    let viewModel               = StudyListViewModel()
    var filterCells             = [FilterCollectionViewCell]()
    var isPaging                = false
    var nowFilter: FilterType   = .all
    
    let tableView: UITableView  = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .black01
        return tv
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        cv.collectionViewLayout = layout
        cv.backgroundColor = .black01
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black01
        configureNavigationBar(title: "스터디 목록")
        self.configureFilterCollectionView()
        viewModel.requestData(isPaging: false) {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        self.configureTableView()
        self.makeStudyButtonView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    //MARK: - Configure UI
    
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
    
    private func configureFilterCollectionView(){
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "filterCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.leading.trailing.equalToSuperview().offset(10)
            make.height.equalTo(50)
        }
    }
    
    //MARK: - Request Data From ViewModel
    private func setFilterAndFetchData(filterType: FilterType){
        viewModel.setFilter(filterType: filterType)
        viewModel.requestData(isPaging: false) {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    private func fetchNextPage(){
        self.isPaging = true
        self.tableView.reloadSections(IndexSet(integer: 1), with: .none) // Loading cell ui update
        self.viewModel.requestData(isPaging: true){
            self.isPaging = false
            self.tableView.reloadData()
        }
    }
}

extension StudyListViewController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// section 0: 스터디 목록 , section 1: 로딩 셀 (페이징 과정 진행시)
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
    
    /// 페이징 처리를 위한 메서드
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

extension StudyListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - TableView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filterCellTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
        cell.configureCell(row: indexPath.row, title: viewModel.filterCellTitle[indexPath.row])
        filterCells.append(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
        setFilterAndFetchData(filterType: FilterType(rawValue: indexPath.row)!)
        filterCells.forEach {
            $0.filterInactivate()
        }
        cell.filterActivate()
    }
}
