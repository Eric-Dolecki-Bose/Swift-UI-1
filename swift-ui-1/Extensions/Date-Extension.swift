//
//  Date-Extension.swift
//  swift-ui-1
//
//  Created by Eric Dolecki on 2/24/20.
//  Copyright © 2020 Eric Dolecki. All rights reserved.
//

import Foundation
import SwiftUI

extension Date {

    // Monday . 24 F

    func toString(withFormat format: String = "EEEE ، MMMM dd, yyyy") -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
