import Foundation

class UserDefaultsContainer: DataContainer, InternalDataContainer {

    // MARK: - InternalDataContainer

    func save(value: Data?, for key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

    func value(for key: String) -> Data? {
        UserDefaults.standard.data(forKey: key)
    }
}
