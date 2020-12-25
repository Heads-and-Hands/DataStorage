import Foundation

public final class DataStorage {
    // MARK: Lifecycle

    public init() {
        let userDefaultsContainer = container(strategy: .userDefaults)
        let launched: Bool = userDefaultsContainer.value(for: Keys.keychainLaunched) ?? false

        if !launched {
            userKeychain.clear()
            internalKeychain.clear()

            userDefaultsContainer.save(value: true, for: Keys.keychainLaunched)
        }
    }

    // MARK: Public

    public enum Strategy {
        case userDefaults
        case keychain
    }

    public func container(strategy: Strategy) -> DataContainer {
        switch strategy {
        case .keychain:
            return userKeychain
        case .userDefaults:
            return UserDefaultsContainer()
        }
    }

    // MARK: Private

    private struct KeychainConfiguration: Codable {
        let userId: String?
        let keychainDomain: String
    }

    private enum Keys: String {
        case keychainConfiguration
        case keychainLaunched
    }

    private enum Domains: String {
        case `internal`
    }

    private lazy var userKeychainDomain = userKeychainConfig.keychainDomain

    private var internalKeychain: KeychainContainer {
        KeychainContainer(domain: Domains.internal.rawValue)
    }

    private var userKeychain: KeychainContainer {
        KeychainContainer(domain: userKeychainDomain)
    }

    private var userKeychainConfig: KeychainConfiguration {
        get {
            if let config: KeychainConfiguration = internalKeychain.value(for: Keys.keychainConfiguration) {
                return config
            } else {
                let config = KeychainConfiguration(userId: nil, keychainDomain: UUID().uuidString)
                self.userKeychainConfig = config
                return config
            }
        }
        set {
            internalKeychain.save(value: newValue, for: Keys.keychainConfiguration)
        }
    }
}
