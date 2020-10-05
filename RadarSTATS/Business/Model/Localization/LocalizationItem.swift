//
//  LocalizationItems.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 01/10/2020.
//

import Foundation

struct LocalizationItem: Codable {
    var id: Int?
    var content: LocalizationContent

    enum CodingKeys: String, CodingKey {
        case id
        case es
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let currentLanguage = Locale.current.languageCode ?? "es"
        let currentLanguageCodingKey = CodingKeys(stringValue: currentLanguage) ?? .es

        do { id = try container.decode(Int.self, forKey: .id) } catch { id = nil }
        content = try container.decode(LocalizationContent.self, forKey: currentLanguageCodingKey)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)

        let currentLanguage = Locale.current.languageCode ?? "es"
        let currentLanguageCodingKey = CodingKeys(stringValue: currentLanguage) ?? .es
        try container.encode(content, forKey: currentLanguageCodingKey)
    }
}
