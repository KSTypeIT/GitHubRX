
import Foundation
import RxSwift
import RxRelay

protocol RepositoryDetailsViewModelProtocol {
    var inputs: RepositoryDetailsViewModelInputs { get }
    var outputs: RepositoryDetailsViewModelOutputs { get }
}

protocol RepositoryDetailsViewModelInputs {
    var repository: BehaviorRelay<Repository?> { get }
}

protocol RepositoryDetailsViewModelOutputs {
    var name: Observable<String> { get }
    var id: Observable<String> { get }
    var url: Observable<String> { get }
    var size: Observable<String> { get }
    var description: Observable<String> { get }
    var language: Observable<String> { get }
}

struct RepositoryDetailsViewModel: RepositoryDetailsViewModelProtocol, RepositoryDetailsViewModelInputs, RepositoryDetailsViewModelOutputs {
    init() {
        name = repository.map { "Name: \($0?.name ?? "")" }
        id = repository.map { "Repository id: \($0?.id.description ?? "")" }
        url = repository.map { "URL: \($0?.url ?? "")" }
        size = repository.map { "Size: \($0?.size ?? 0)" }
        description = repository.map { "Description: \($0?.description ?? "")" }
        language = repository.map { "Language: \($0?.language ?? "")" }
    }

    // MARK: Inputs
    let repository = BehaviorRelay<Repository?>(value: nil)

    // MARK: Outputs
    let name: Observable<String>
    let id: Observable<String>
    let url: Observable<String>
    let size: Observable<String>
    let description: Observable<String>
    let language: Observable<String>

    var inputs: RepositoryDetailsViewModelInputs { self }
    var outputs: RepositoryDetailsViewModelOutputs { self }
}
