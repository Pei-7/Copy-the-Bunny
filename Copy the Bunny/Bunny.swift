//
//  Bunny.swift
//  Copy the Bunny
//
//  Created by 陳佩琪 on 2023/7/5.
//


import Foundation
import UIKit

struct BunnySymbol {
    var ear : AttributedString
    var face : AttributedString
    var actionleft : AttributedString
    var emojiContent : AttributedString
    var actionRight : AttributedString

    func makeBunny() -> AttributedString {
        var bunnyText = AttributedString()
        bunnyText += ear
        bunnyText += face
        bunnyText += actionleft
        bunnyText += emojiContent
        bunnyText += actionRight
        
        return bunnyText
    }
}

struct BunnyImage {
    var ear : NSMutableAttributedString
    var face : NSMutableAttributedString
    var actionleft : NSMutableAttributedString
    var imageContent : NSTextAttachment
    var actionRight : NSMutableAttributedString

    func makeBunny() -> NSMutableAttributedString {
        let bunnyText = NSMutableAttributedString()
        bunnyText.append(ear)
        bunnyText.append(face)
        bunnyText.append(actionleft)
        bunnyText.append(NSMutableAttributedString(attachment: imageContent))
        bunnyText.append(actionRight)
        
        return bunnyText
    }
}

enum Emotion {
    case general, glad, speechless, angry
    
    var icon: String {
        switch self {
        case .general:
            return " •_•"
        case .glad:
            return "´▽`"
        case .speechless:
            return " -_-"
        case . angry:
            return "`Д´"
        }
    }
    
    var name: String {
        switch self {
        case .general:
            return "一般"
        case .glad:
            return "開心"
        case .speechless:
            return "無語"
        case . angry:
            return "生氣"
        }
    }
}
        
enum Action {
    case holding, handingOut, carrying, takingBack
    
    var leftIcon: String {
        switch self {
        case .holding:
            return "/>"
        case .handingOut:
            return "/>"
        case .carrying:
            return "/"
        case . takingBack:
            return "/"
        }
    }
    
    var rightIcon: String {
        switch self {
        case .holding:
            return ">"
        case .handingOut:
            return ""
        case .carrying:
            return ""
        case . takingBack:
            return "<\\"
        }
    }
        
    var name: String {
        switch self {
        case .holding:
            return "捧住"
        case .handingOut:
            return "遞出"
        case .carrying:
            return "拿著"
        case . takingBack:
            return "收回"
        }
        
    }
}
  
