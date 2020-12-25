import Foundation
import KeychainAccess

class KeychainContainer: DataContainer, InternalDataContainer {
    // MARK: Lifecycle

    init(domain: String) {
        keychain = Keychain(service: domain)
    }

    // MARK: Internal

    let keychain: Keychain

    func clear() {
        try? keychain.removeAll()
    }

    // MARK: - InternalDataContainer

    func save(value: Data?, for key: String) {
        if let value = value {
            try? keychain.set(value, key: key)
        } else {
            try? keychain.remove(key)
        }
    }

    func value(for key: String) -> Data? {
        try? keychain.getData(key)
    }
}
