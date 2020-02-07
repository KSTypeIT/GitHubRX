
import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }

    public func setupWith(repository: Repository) {
        nameLabel.text = repository.name
    }
}
