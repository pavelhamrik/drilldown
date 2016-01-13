//
//  DateHelpers.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 13.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//


import Foundation

class DateHelpers {
    
    
    static func formatDate(date: String) -> String {
        return formatDate(date, inputFormat: "yyyy-MM-dd'T'hh:mm:ssXXX", outputDateStyle: NSDateFormatterStyle.MediumStyle, outputTimeStyle: NSDateFormatterStyle.NoStyle)
    }
    
    static func formatDate(date: String, inputFormat: String) -> String {
        return formatDate(date, inputFormat: inputFormat, outputDateStyle: NSDateFormatterStyle.MediumStyle, outputTimeStyle: NSDateFormatterStyle.NoStyle)
    }

    static func formatDate(date: String, inputFormat: String, outputDateStyle: NSDateFormatterStyle) -> String {
        return formatDate(date, inputFormat: inputFormat, outputDateStyle: outputDateStyle, outputTimeStyle: NSDateFormatterStyle.NoStyle)
    }

    static func formatDate(date: String, inputFormat: String, outputDateStyle: NSDateFormatterStyle, outputTimeStyle: NSDateFormatterStyle) -> String {
    
        let formatter = NSDateFormatter()
        var output = ""

        formatter.dateFormat = inputFormat
        let nsDate = formatter.dateFromString(date)
        
        if nsDate != nil {
            formatter.dateStyle = outputDateStyle
            formatter.timeStyle = outputTimeStyle
            output = formatter.stringFromDate(nsDate!)
        }
        
        return output
    
    }


}
