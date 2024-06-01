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
}
