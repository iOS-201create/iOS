//
//  FilterCollectionViewCell.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/05.
//

import UIKit
import SnapKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let containerView   = UIView()
    let filterLabel     = UILabel()
    var type            : filterType?
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Configure UI
    
    func configureCell(row: Int, title: String){
        self.type = filterType(rawValue: row)
        filterLabel.text = title
        configureFilterLabel()
        configureFilterView()
    }
    
    private func configureFilterView(){
        addSubview(containerView)
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 13
        filterInactivate()
        if type == .all {
            containerView.backgroundColor = .black03
        }
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
            make.width.equalTo(filterLabel.intrinsicContentSize.width + 25)
            make.height.equalTo(filterLabel.intrinsicContentSize.height + 13)
        }
    }
    
    private func configureFilterLabel(){
        containerView.addSubview(filterLabel)
        filterLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        filterLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Filter Switch Methods
    
    func filterActivate(){
        switch type {
        case .all:
            containerView.backgroundColor = .black03
        case .processing:
            turnViewColor(labelColor: "7ADC4B", viewColor: "19261A")
        case .recruiting:
            turnViewColor(labelColor: "BAB0F4", viewColor: "444449")
        case .waitingForAcceptance:
            turnViewColor(labelColor: "FBBA8B", viewColor: "513C2C")
        case .waitingToStart:
            turnViewColor(labelColor: "EC9BA6", viewColor: "321A20")
        case .none:
            break
        }
    }

    func filterInactivate(){
        filterLabel.textColor = .white
        containerView.backgroundColor = .black02
        containerView.layer.borderColor = UIColor(hexCode: "797F8A").cgColor
    }

    private func turnViewColor(labelColor: String, viewColor: String){
        filterLabel.textColor = UIColor(hexCode: labelColor)
        containerView.backgroundColor = UIColor(hexCode: viewColor)
    }
    
    //MARK: - Filter Type
    
    enum filterType: Int {
        typealias RawValue = Int
        case all                    = 0
        case recruiting             = 1
        case processing             = 2
        case waitingForAcceptance   = 3  // APPLICANT
        case waitingToStart         = 4  // STUDY_MEMBER
    }
}
