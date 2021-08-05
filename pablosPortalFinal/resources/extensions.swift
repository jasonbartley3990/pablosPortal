//
//  extensions.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import Foundation
import UIKit

extension UIView {
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        frame.origin.y+height
    }
    var height: CGFloat {
        frame.size.height
    }
    var width: CGFloat {
        frame.size.width
    }
    var right: CGFloat {
        frame.origin.x+width
    }
    var left: CGFloat {
        frame.origin.x
    }
}

extension Encodable {
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return json
    }
}

extension Decodable {
    init?(with dictionary: [String: Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {return nil}
        guard let result = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }
        self = result
        
    }
}

extension String {
    static func date(from date: Date) -> String? {
    let formatter = DateFormatter.formatter
    let string = formatter.string(from: date)
    return string
    }
}

extension DateFormatter {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        //formatter.timeStyle = .short
        return formatter
    }()
    
}
