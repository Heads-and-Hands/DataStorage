# DataStorage

## Стратегии хранения данных

* userDefaults - для общих флагов приложения, например был ли совершенн первый запуск приложения
* keychain - для хранения данных пользователя, после авторизации данные бесшовно переносятся в "другой" keychain

## Использование

````
protocol RegionsStorage: AnyObject {
    var region: Region? { get set }
}

extension DataStorage: RegionsStorage {
    enum RegionsKeys: String {
        case region
    }

    var region: Region? {
        get {
            container(strategy: .keychain).value(for: RegionsKeys.region)
        }
        set {
            container(strategy: .keychain).save(value: newValue, for: RegionsKeys.region)
        }
    }
}
````

## Фичи

- [x] UserDefaults Container
- [x] Keychain Container
- [ ] FileManager Container
- [ ] Потокобезопасность
- [ ] Обновление контейнеров после авторизации или логаута
- [ ] Кеширование данных 
