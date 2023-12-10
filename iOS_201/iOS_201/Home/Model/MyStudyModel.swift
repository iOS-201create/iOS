//
//  MyStudyModel.swift
//  iOS_201
//
//  Created by Hyeonho on 12/1/23.
//

import Foundation

struct MyStudyModel : Decodable {
    let id                     : Int
    let name                   : String
    let todoContent             : String
    let leftDays                : Int
    let grassCount              : Int
    let isMaster                : Bool
    
    static var MOCK_studyModel : [MyStudyModel] = [
        MyStudyModel(id: 1, name: "코틀린 스터디 구해여1", todoContent: "Rx공부해보기", leftDays: 3, grassCount: 321, isMaster: true),
        MyStudyModel(id: 2, name: "코틀린 스터디 구해여 아맞다 스위프트도 구하는중임여2", todoContent: "MVVM-Coordinator패턴 공부하기", leftDays: 3, grassCount: 32, isMaster: true),
        MyStudyModel(id: 3, name: "코틀린 스터디 구해여3", todoContent: "Rx공부해보기", leftDays: 3, grassCount: 321, isMaster: true),
        MyStudyModel(id: 4, name: "코틀린 스터디 구해여4", todoContent: "Rx공부해보기", leftDays: 3, grassCount: 321, isMaster: false),
        MyStudyModel(id: 5, name: "코틀린 스터디 구해여5", todoContent: "Rx공부해보기", leftDays: 3, grassCount: 321, isMaster: false),
        MyStudyModel(id: 6, name: "코틀린 스터디 구해여6", todoContent: "Rx공부해보기", leftDays: 3, grassCount: 321, isMaster: false),
        MyStudyModel(id: 7, name: "코틀린 스터디 구해여7", todoContent: "Rx공부해보기", leftDays: 3, grassCount: 321, isMaster: false)
    ]
}
