import UIKit

extension UIImageView {
    
    /// CircleImage 
    func makeRounded() {
        backgroundColor = .white
        layer.cornerRadius = self.bounds.size.height / 2
        layer.borderWidth = 2
        layer.masksToBounds = true
        layer.borderColor = UIColor.red.cgColor
        self.clipsToBounds = true
        
        
    }
    
}
