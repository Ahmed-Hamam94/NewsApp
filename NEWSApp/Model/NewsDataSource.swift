//
//  NewsDataSource.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 01/11/2023.
//

import RxDataSources

//
//struct NewsSection: Codable {
//    var header: String
//    var items: [Item]
//}
//
//extension NewsSection: SectionModelType {
//    typealias Item = Articles
//    init(original: NewsSection, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}
enum NewsSection {
    case sliderSection(header: String, items: [Articles])
    case newsSection(header: String, items: [Articles])
}

extension NewsSection: SectionModelType {
    typealias Item = Articles
    
    init(original: NewsSection, items: [Item]) {
        switch original {
        case let .sliderSection(header: header, items: _):
            self = .sliderSection(header: header, items: items)
        case let .newsSection(header: header, items: _):
            self = .newsSection(header: header, items: items)
        }
    }
    
    var header: String {
        switch self {
        case let .sliderSection(header: header, _):
            return header
        case let .newsSection(header: header, _):
            return header
        }
    }
    
    var items: [Item] {
        switch self {
        case let .sliderSection(_, items: items):
            return items
        case let .newsSection(_, items: items):
            return items
        }
    }
}


//
//enum SectionOfCustomData: SectionModelType {
//
//  typealias Item = Row
//
//  case customDataSection(header: String, items: [Row])
//  case stringSection(header: String, items: [Row])
//
//  enum Row {
//    case customData(customData: CustomData) // wrapping CustomData to Row type
//    case string(string: String)             // wrapping String to Row type
//  }
//
//  // followings are not directly related to this topic, but represents how to conform to SectionModelType
//  var items: [Row] {
//    switch self {
//    case .customDataSection(_, let items):
//      return items
//
//    case .stringSection(_, let items):
//      return items
//    }
//  }
//
//  public init(original: SectionOfCustomData, items: [Row]) {
//    switch original {
//    case .customDataSection(let header, _):
//      self = .customDataSection(header: header, items: items)
//
//    case .stringSection(let header, _):
//      self = .stringSection(header: header, items: items)
//    }
//  }
//}

