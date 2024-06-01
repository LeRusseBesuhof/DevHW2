import Foundation
import UIKit

final class AppUIFuncs {
    
    static func createLabel(with header: String? = nil, alignment: NSTextAlignment, font: UIFont) -> UILabel {
        .config(view: UILabel()) {
            $0.textAlignment = alignment
            $0.font = font
            $0.numberOfLines = .zero
            guard let header = header else { return }
            $0.text = header
        }
    }
    
    static func createTitleImageView(with size: CGRect, image: UIImage) -> UIImageView {
        {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.image = image
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .black
            return $0
        }(UIImageView(frame: size))
    }
}
