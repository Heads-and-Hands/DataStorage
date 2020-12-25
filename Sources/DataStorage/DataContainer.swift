import Foundation

public protocol DataContainer {
    func save<T: Codable, K: RawRepresentable>(value: T?, for key: K) where K.RawValue == String
    func value<T: Codable, K: RawRepresentable>(for key: K) -> T? where K.RawValue == String
}

extension DataContainer where Self: InternalDataContainer {
    func save<T: Codable, K: RawRepresentable>(value: T?, for key: K) where K.RawValue == String {
        let key = convert(key: key)

        if let value = value {
            let data = try? JSONEncoder().encode(value)
            save(value: data, for: key)
        } else {
            save(value: nil, for: key)
        }
    }

    func value<T: Codable, K: RawRepresentable>(for key: K) -> T? where K.RawValue == String {
        if let data = value(for: convert(key: key)) {
            return try? JSONDecoder().decode(T.self, from: data)
        } else {
            return nil
        }
    }

    func convert<K: RawRepresentable>(key: K) -> String where K.RawValue == String {
        String(describing: K.self) + key.rawValue
    }
}
