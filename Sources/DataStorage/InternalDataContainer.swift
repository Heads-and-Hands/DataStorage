import Foundation

protocol InternalDataContainer {
    func save(value: Data?, for key: String)
    func value(for key: String) -> Data?
}
