import Combine
import UIKit

extension UITextView {
 
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: self)
        .compactMap{ $0.object as? UITextView}
        .map{ $0.text ?? "" }
        .eraseToAnyPublisher()
     }
}
