
import UIKit
import RxSwift

private enum Constans: CGFloat {
    case cellHeight = 70
    case minimumLineSpacing = 10
}

private enum Static: String {
    case cellReuseIdentifier = "kRepositoryCell"
    case cellNibName = "RepositoryCollectionViewCell"
}

final class RepositoryCollectionViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = RepositoryCollectionViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchControllerSetup()
        defineCollectionViewLayout()
        collectionView.register(UINib(nibName: Static.cellNibName.rawValue, bundle: nil),
                                forCellWithReuseIdentifier: Static.cellReuseIdentifier.rawValue)

        viewModel.outputs.repositories.bind(to: collectionView.rx.items(cellIdentifier: Static.cellReuseIdentifier.rawValue, cellType: RepositoryCollectionViewCell.self)) { _, repository, cell in
            cell.setupWith(repository: repository)
        }.disposed(by: disposeBag)
    }

    private func defineCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: Constans.cellHeight.rawValue)
        layout.minimumLineSpacing = Constans.minimumLineSpacing.rawValue
        collectionView!.collectionViewLayout = layout
    }

    private func searchControllerSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension RepositoryCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // If this app was made to be bigger this should be propobally handeled by some Flow Controller
        // Also created a DetailVC from XIB directy insted of createing a Segue in Storyboard to "show" handling of ViewControllers in code
        let repository = viewModel.outputs.repositories.value[indexPath.row]
        let repositoryDetailsVC = RepositoryDetailsViewController()
        repositoryDetailsVC.viewModel.inputs.repository.accept(repository)
        self.navigationController?.pushViewController(repositoryDetailsVC, animated: true)
    }
}

extension RepositoryCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.inputs.searchRepository.accept(searchBar.text!)
    }
}
