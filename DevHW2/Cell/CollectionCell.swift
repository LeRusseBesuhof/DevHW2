import UIKit

protocol CellProtocol : AnyObject {
    static var reuseID : String { get }
    func setUpCell(with item: Character)
}

final class CollectionCell: UICollectionViewCell, CellProtocol {
    
    static internal var reuseID : String = "cell"
    
    private lazy var canvasView : UIView = {
        .config(view: $0) {
            $0.layer.cornerRadius = 15
            $0.backgroundColor = .darkGray
        }
    }(UIView())
    
    private lazy var imageView : UIImageView = {
        .config(view: UIImageView()) {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 150
        }
    }()
    
    private lazy var nameLabel : UILabel = AppUIFuncs.createLabel(alignment: .center, font: UIFont.getCreepsterFont(fontSize: 40))
    
    private lazy var statusLabel : UILabel = AppUIFuncs.createLabel(with: "\u{2022} Status: ", alignment: .left, font: UIFont.getShadowFont(fontSize: 32))
    
    private lazy var genderLabel : UILabel = AppUIFuncs.createLabel(with: "\u{2022} Gender: ", alignment: .left, font: UIFont.getShadowFont(fontSize: 32))
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func setUpCell(with item: Character) {
        layer.cornerRadius = 15
        
        let imageUrl = URL(string: item.image ?? "")
        imageView.load(url: imageUrl!)
        nameLabel.text = item.name ?? ""
        statusLabel.text = "\u{2022} Status: \(item.status ?? "")"
        genderLabel.text = "\u{2022} Gender: \(item.gender ?? "")"
        
        [imageView, nameLabel, statusLabel, genderLabel].forEach { canvasView.addSubview($0) }
        addSubview(canvasView)
        
        activateConstraints()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: topAnchor),
            canvasView.leadingAnchor.constraint(equalTo: leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: trailingAnchor),
            canvasView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor),
    
            imageView.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: 26),
            imageView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor),
            genderLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            genderLabel.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            
            genderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
}
