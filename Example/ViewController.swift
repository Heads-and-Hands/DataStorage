//
//  ViewController.swift
//  DataStorage
//
//  Created by basalaev on 25.12.2020.
//

import UIKit
import DataStorage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let region = Region(id: 1, name: "Москва")
        let storage: RegionsStorage = DataStorage()
        storage.region = region

        let storage2: RegionsStorage = DataStorage()

        if storage.region?.id == region.id {
            print("Успех")
        } else {
            print("Не удача")
        }
    }
}

// MARK: - Entity

struct Region: Codable {
    let id: Int
    let name: String
}

// MARK: - Storage

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
