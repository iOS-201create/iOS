//
//  TodoCollectionView.swift
//  iOS_201
//
//  Created by Hyeonho sin on 11/21/23.
//

import Foundation
import UIKit

import SnapKit

class TodoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TodoCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(named: "person")
        imageview.tintColor = .white
        imageview.clipsToBounds = true
        return imageview
    }()
    
    func configure(with image: UIImage) {
        self.myImageView.image = image
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .red
        self.addSubview(myImageView)
        myImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.myImageView.image = nil
    }
    
}
