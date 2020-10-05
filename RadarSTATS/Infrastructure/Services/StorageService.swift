//
//  StorageService.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

struct StorageKey {
    struct UserDefaults {
        static let hourlyStats = "kHourlyStats"

        static let all = [hourlyStats]
    }
}

enum Storage<Model: Codable> {
    case defaults(key: String)
}

protocol StorageService {
    func store<Model: Codable>(item: Model, on storage: Storage<Model>) throws
    func retrieve<Model: Codable>(from storage: Storage<Model>) -> Model?
    func clean()
}

class StorageServiceDefault: StorageService {
    internal var userDefaults: UserDefaults

    init() {
        userDefaults = UserDefaults.standard
    }

    func store<Model: Codable>(item: Model, on storage: Storage<Model>) throws {
        switch storage {
        case .defaults(let key): try onUserDefaultsStore(item: item, on: key)
        }
    }

    internal func onUserDefaultsStore<Model: Codable>(item: Model, on key: String) throws {
        let encodedItem = try PropertyListEncoder().encode([item])
        userDefaults.set(encodedItem, forKey: key)
    }

    func retrieve<Model: Codable>(from storage: Storage<Model>) -> Model? {
        switch storage {
        case .defaults(let key): return fromUserDefaultsRetrieve(on: key)
        }
    }

    internal func fromUserDefaultsRetrieve<Model: Codable>(on key: String) -> Model? {
        if Model.self == Bool.self {
            guard let _ = userDefaults.object(forKey: key) as? [Model] else { return nil }
        }
        guard let storedItemData = userDefaults.data(forKey: key) else { return nil }
        let decodedItem = try? PropertyListDecoder().decode([Model].self, from: storedItemData)
        return decodedItem?.first
    }

    func clean() {
        for defaultsKey in StorageKey.UserDefaults.all {
            userDefaults.removeObject(forKey: defaultsKey)
        }
    }
}
