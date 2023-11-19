import Foundation

/// 닉네임중복여부를 체크시, 응답으로 오는 모델
struct NicknameModel: Codable {
    let exists: Bool
}
