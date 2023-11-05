//
//  LodingTableViewCell.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/05.
//

import UIKit
import SnapKit

class LodingTableViewCell: UITableViewCell {
    
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    //MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black02
        self.selectionStyle = .none
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Configure UI
    
    private func configureCell(){
        self.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        activityIndicatorView.startAnimating()
    }
    
}
