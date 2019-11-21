//
//  JsonObjects.swift
//  MaadJSON
//
//  Created by Noman Yousuf on 11/18/19.
//  Copyright © 2019 colors. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let abstractURL: String
    let answerType, infobox, abstractText: String
    let relatedTopics: [RelatedTopic]
    let answer, definition, abstract: String
    let results: [JSONAny]
    let imageIsLogo: Int
    let type, heading, image, definitionSource: String
    let definitionURL: String
    let imageWidth: Int
    let meta: Meta
    let imageHeight: Int
    let redirect, entity, abstractSource: String

    enum CodingKeys: String, CodingKey {
        case abstractURL = "AbstractURL"
        case answerType = "AnswerType"
        case infobox = "Infobox"
        case abstractText = "AbstractText"
        case relatedTopics = "RelatedTopics"
        case answer = "Answer"
        case definition = "Definition"
        case abstract = "Abstract"
        case results = "Results"
        case imageIsLogo = "ImageIsLogo"
        case type = "Type"
        case heading = "Heading"
        case image = "Image"
        case definitionSource = "DefinitionSource"
        case definitionURL = "DefinitionURL"
        case imageWidth = "ImageWidth"
        case meta
        case imageHeight = "ImageHeight"
        case redirect = "Redirect"
        case entity = "Entity"
        case abstractSource = "AbstractSource"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let status, devMilestone: String
    let unsafe: Int
    let jsCallbackName, srcName: String
    let srcOptions: SrcOptions
    let id, name, productionState, srcDomain: String
    let srcID: Int
    let repo: String
    let developer: [Developer]
    let srcURL: JSONNull?
    let tab, exampleQuery: String
    let createdDate: JSONNull?
    let signalFrom: String
    let designer, blockgroup, isStackexchange, attribution: JSONNull?
    let topic: [String]
    let devDate: JSONNull?
    let metaDescription: String
    let producer: JSONNull?
    let maintainer: Maintainer
    let liveDate: JSONNull?
    let perlModule: String

    enum CodingKeys: String, CodingKey {
        case status
        case devMilestone = "dev_milestone"
        case unsafe
        case jsCallbackName = "js_callback_name"
        case srcName = "src_name"
        case srcOptions = "src_options"
        case id, name
        case productionState = "production_state"
        case srcDomain = "src_domain"
        case srcID = "src_id"
        case repo, developer
        case srcURL = "src_url"
        case tab
        case exampleQuery = "example_query"
        case createdDate = "created_date"
        case signalFrom = "signal_from"
        case designer, blockgroup
        case isStackexchange = "is_stackexchange"
        case attribution, topic
        case devDate = "dev_date"
        case metaDescription = "description"
        case producer, maintainer
        case liveDate = "live_date"
        case perlModule = "perl_module"
    }
}

// MARK: - Developer
struct Developer: Codable {
    let type: String
    let url: String
    let name: String
}

// MARK: - Maintainer
struct Maintainer: Codable {
    let github: String
}

// MARK: - SrcOptions
struct SrcOptions: Codable {
    let sourceSkip: String
    let skipAbstract, isWikipedia, skipAbstractParen: Int
    let srcInfo: String
    let skipImageName, isFanon: Int
    let directory, skipQr, language: String
    let isMediawiki: Int
    let skipEnd, minAbstractLength: String
    let skipIcon: Int

    enum CodingKeys: String, CodingKey {
        case sourceSkip = "source_skip"
        case skipAbstract = "skip_abstract"
        case isWikipedia = "is_wikipedia"
        case skipAbstractParen = "skip_abstract_paren"
        case srcInfo = "src_info"
        case skipImageName = "skip_image_name"
        case isFanon = "is_fanon"
        case directory
        case skipQr = "skip_qr"
        case language
        case isMediawiki = "is_mediawiki"
        case skipEnd = "skip_end"
        case minAbstractLength = "min_abstract_length"
        case skipIcon = "skip_icon"
    }
}

// MARK: - RelatedTopic
struct RelatedTopic: Codable {
    let icon: Icon
    let text: String
    let firstURL: String
    let result: String

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case text = "Text"
        case firstURL = "FirstURL"
        case result = "Result"
    }
}

// MARK: - Icon
struct Icon: Codable {
    let height, width: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case width = "Width"
        case url = "URL"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

}
