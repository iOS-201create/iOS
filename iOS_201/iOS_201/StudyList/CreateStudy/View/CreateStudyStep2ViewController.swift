//
//  CreateStudyStep2ViewController.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/17.
//

import UIKit

class CreateStudyStep2ViewController: UIViewController {
    
    var coordinator: CreateStudyStep2Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.coordinator?.finish()
        }
    }

}
