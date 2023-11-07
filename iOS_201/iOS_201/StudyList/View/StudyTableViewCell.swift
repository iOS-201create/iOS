//
//  StudyTableViewCell.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/04.
//

import UIKit
import SnapKit

class StudyTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    let containerView = UIView()
    
    //MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black01
        self.selectionStyle = .none
        self.configureContainerView()
        self.configurePeopleImageView()
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
    
    func configureCell(data: StudyListModel.Response){
        self.configureTierImageView(tier: data.averageTier ?? 1)
        self.configureTitleLabel(title: data.name ?? "")
        self.configureDateLabel(date: "모집시작일 \(data.createdAt ?? "") · 최소 \(data.minimumWeeks ?? 0)주 · 주 \(data.meetingDaysPerWeek ?? 0)회")
        self.numOfPeopleLabel(numOfPeople: "\(data.numberOfCurrentMembers ?? 0)/\(data.numberOfMaximumMembers ?? 0)")
        
         //TODO: - 모집중 태그 -> Dynamic하게 수정 필요함
        let tagView = UIView()
        tagView.layer.borderWidth = 1
        tagView.layer.borderColor = UIColor(red: 0.208, green: 0.349, blue: 0.161, alpha: 1).cgColor
        tagView.backgroundColor = UIColor(red: 0.098, green: 0.149, blue: 0.102, alpha: 1)
        
        containerView.addSubview(tagView)
        tagView.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(18)
            make.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().offset(20)
        }
        
        let tagLabel = UILabel()
        tagLabel.text = getTagText(value: data.processingStatus!)
        tagLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        tagLabel.textColor = UIColor(red: 0.478, green: 0.863, blue: 0.294, alpha: 1)
        
        tagView.addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    //TODO: - 모집중 태그 -> Dynamic하게 수정 필요함
    func getTagText(value: Int) -> String{
        if value == 0 { return "모집중" }
        else if value == 1 { return "진행중"}
        else { return "???"}
    }
    
    private func configureContainerView(){
        self.addSubview(containerView)
        containerView.backgroundColor = .black02
        containerView.layer.borderColor = UIColor(red: 0.196, green: 0.212, blue: 0.235, alpha: 1).cgColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 8
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func configureTierImageView(tier: Int){
        let tierImageView = UIImageView()
        tierImageView.image = UIImage(named: "tier\(tier)" )
        containerView.addSubview(tierImageView)
        tierImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(22)
            make.bottom.equalToSuperview().inset(38)
        }
        configureTierLabel(tierImageView)
    }
    
    private func configureTierLabel(_ tierImageView: UIImageView){
        let tierLabel = UILabel()
        containerView.addSubview(tierLabel)
        tierLabel.text = "평균티어"
        tierLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        tierLabel.textColor = UIColor(hexCode: "797F8A")
        tierLabel.snp.makeConstraints { make in
            make.centerX.equalTo(tierImageView.snp.centerX)
            make.top.equalTo(tierImageView.snp.bottom).offset(5)
        }
    }
    
    private func configureTitleLabel(title: String){
        let titleLabel = UILabel()
        containerView.addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(60)
        }
    }
    
    private func configureDateLabel(date: String){
        let dateLabel = UILabel()
        containerView.addSubview(dateLabel)
        dateLabel.text = date
        dateLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        dateLabel.textColor = UIColor(red: 0.475, green: 0.498, blue: 0.541, alpha: 1)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().inset(25)
        }
    }
    
    private func configurePeopleImageView(){
        let peopleImage = UIImageView(image: UIImage(named: "peopleImage"))
        containerView.addSubview(peopleImage)
        peopleImage.snp.makeConstraints { make in
            make.width.height.equalTo(14)
            make.bottom.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(45)
        }
    }
    
    private func numOfPeopleLabel(numOfPeople: String){
        let numOfPeopleLabel = UILabel()
        numOfPeopleLabel.text = numOfPeople
        numOfPeopleLabel.textColor = UIColor(red: 0.502, green: 0.522, blue: 0.561, alpha: 1)
        numOfPeopleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        containerView.addSubview(numOfPeopleLabel)
        numOfPeopleLabel.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.trailing.equalToSuperview().inset(13)
            make.bottom.equalToSuperview().inset(24)
        }
    }
}


//
//[
//  {
//    "id": 2,
//    "processingStatus": 1,
//    "name": "자바 스프링 잘하는법",
//    "averageTier": 2,
//    "createdAt": "2023-11-05",
//    "numberOfCurrentMembers": 6,
//    "numberOfMaximumMembers": 6,
//    "meetingDaysPerWeek": 2,
//    "minimumWeeks": 8
//  }
//]


// -> study/wating REQEUST
//쿼리는 page, search, 똑같음
//쿼리 role -> MASTER, STUDY_MEMBER, APPLICANT, NO_ROLE


//"createdAt": "2023-11-07T01:19:34.040Z",
//"updatedAt": "2023-11-07T01:19:34.040Z",
//"id": 0,
//"githubId": "string",
//"nickname": "string",
//"profileImageUrl": "string",
//"experience": 0,
//"introduction": "string",
//"deleted": true,
//"tier": "BRONZE",
//"onboardingDone": true
//}


//response
//[
//  {
//    "id": 2,
//    "processingStatus": 1,
//    "name": "자바 스프링 잘하는법",
//    "averageTier": 2,
//    "createdAt": "2023-11-07",
//    "numberOfCurrentMembers": 6,
//    "numberOfMaximumMembers": 6,
//    "meetingDaysPerWeek": 2,
//    "minimumWeeks": 8
//  }
//]
