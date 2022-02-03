//
//  StackOverFlow.swift
//  StackOverflowApplication
//
//  Created by Елизавета Федорова on 03.02.2022.
//

import Foundation


class StackOverFlowAPI{
    static func setUrl(tag: DataTag) -> String {
        switch tag {
        case .objC:
            return "https://api.stackexchange.com/2.3/questions?pagesize=20&order=desc&sort=activity&tagged=objective-c&site=stackoverflow"
        case .ios:
            return "https://api.stackexchange.com/2.3/questions?pagesize=20&order=desc&sort=activity&tagged=iOS&site=stackoverflow"
        case .iphone:
            return "https://api.stackexchange.com/2.3/questions?pagesize=20&order=desc&sort=activity&tagged=iphone&site=stackoverflow"
        case .xCode:
            return "https://api.stackexchange.com/2.3/questions?pagesize=20&order=desc&sort=activity&tagged=xcode&site=stackoverflow"
        case .cocoaTouch:
            return "https://api.stackexchange.com/2.3/questions?pagesize=20&order=desc&sort=activity&tagged=cocoa-touch&site=stackoverflow"
        }
    }
    static func setUrl(question id: Int) -> String {
        
            return "https://api.stackexchange.com/2.3/questions/\(id)/answers?order=desc&sort=activity&site=stackoverflow&filter=!nKzQURF6Y5"
        }
    }
