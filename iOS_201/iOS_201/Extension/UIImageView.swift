import UIKit

extension UIImageView {
    
    /// CircleImage 
    func makeRounded() {
        backgroundColor = .white
        layer.cornerRadius = self.frame.size.height / 2
        layer.borderWidth = 1.5
        layer.masksToBounds = true
        layer.borderColor = UIColor(hexCode: "#989DA5").cgColor
        self.clipsToBounds = true
        
        
    }
    
}
