
import Foundation

public struct Repository: Decodable {
    let id: Int
    let name: String
    let url: String
    let size: Int
    let description: String?
    let language: String?
}
