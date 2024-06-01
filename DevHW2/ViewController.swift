import UIKit

protocol ViewControllerProtocol : AnyObject {
    var networkService : NetworkProtocol { get }
    var queryParams : QueryParameters { get set }
}

final class ViewController: UIViewController {
    
    internal var networkService : NetworkProtocol = NetworkService()
    
    private lazy var logoImageView : UIImageView = AppUIFuncs.createTitleImageView(
        with: CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 120),
        image: .rnmlogo)
    
    internal var queryParams = QueryParameters(name: .beth, status: .dead)
    
    private var collectionData : [Character] = []
    
    private lazy var collectionView : UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        
        $0.backgroundColor = .clear
        $0.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseID)
        $0.dataSource = self
        return $0
    }(UICollectionView(frame: CGRect(x: .zero, y: logoImageView.frame.maxY + 20, width: view.frame.width, height: view.frame.height), collectionViewLayout: UICollectionViewFlowLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        [logoImageView, collectionView].forEach { view.addSubview($0) }
        
        networkService.sendRequest(queryParams) { char in
            DispatchQueue.main.async {
                self.collectionData = char
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionData[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseID, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        cell.setUpCell(with: item)
        return cell
    }
}
