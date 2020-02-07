
import Foundation
import RxSwift
import RxRelay

protocol RepositoryCollectionViewModelProtocol {
    var inputs: RepositoryCollectionViewModelInputs { get }
    var outputs: RepositoryCollectionViewModelOutputs { get }
}

protocol RepositoryCollectionViewModelInputs {
    var searchRepository: BehaviorRelay<String> { get }
}

protocol RepositoryCollectionViewModelOutputs {
    var repositories: BehaviorRelay<[Repository]> { get }
}

final class RepositoryCollectionViewModel: RepositoryCollectionViewModelProtocol, RepositoryCollectionViewModelInputs, RepositoryCollectionViewModelOutputs {
    private let dataProvider: DataProviding
    private let disposeBag = DisposeBag()

    init (dataProvider: DataProviding = DataProvider()) {
        self.dataProvider = dataProvider

        let repositoriesObservable = dataProvider.repositoriesAsObservable()

        repositoriesObservable.bind(to: repositories)
        .disposed(by: disposeBag)

        searchRepository.withLatestFrom(repositoriesObservable) { term, repos in
            term.isEmpty ? repos : repos.filter { $0.name.range(of: term, options: .caseInsensitive) != nil }
        }
        .bind(to: repositories)
        .disposed(by: disposeBag)
    }
    
    // MARK: Inputs
    var searchRepository = BehaviorRelay<String>(value: "")

    // MARK: Outputs
    var repositories = BehaviorRelay<[Repository]>(value: [])

    var inputs: RepositoryCollectionViewModelInputs { self }
    var outputs: RepositoryCollectionViewModelOutputs { self }
}
