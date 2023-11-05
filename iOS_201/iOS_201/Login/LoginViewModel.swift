//
//  LoginViewModel.swift
//  iOS_201
//
//  Created by Hyeonho on 11/5/23.
//

import Foundation
import Combine

class LoginViewModel : ObservableObject {
    
    @objc func fetchCodeToGithub() {
        AuthService.share.requestCode {
            if $0 {
                print("LoginViewModel : fetchCodaToGithub() - 인증성공 알림호출 & 화면이동")
                return
            }
            print("LoginViewModel : fetchCodaToGithub() - 인증실패 알림 호출")
        }
    }
}
