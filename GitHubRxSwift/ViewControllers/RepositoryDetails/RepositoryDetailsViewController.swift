
import Foundation
import UIKit
import RxSwift
import RxCocoa

fileprivate enum Static: String {
    case xibName = "RepositoryDetailsViewController"
}

final class RepositoryDetailsViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var lanugaeLabel: UILabel!
    @IBOutlet private weak var sizeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!

    private let disposeBag = DisposeBag()
    let viewModel: RepositoryDetailsViewModelProtocol = RepositoryDetailsViewModel()

    init() {
        super.init(nibName: Static.xibName.rawValue, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.outputs.name.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.outputs.id.bind(to: idLabel.rx.text).disposed(by: disposeBag)
        viewModel.outputs.language.bind(to: lanugaeLabel.rx.text).disposed(by: disposeBag)
        viewModel.outputs.size.bind(to: sizeLabel.rx.text).disposed(by: disposeBag)
        viewModel.outputs.description.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.outputs.url.bind(to: urlLabel.rx.text).disposed(by: disposeBag)
    }
}
