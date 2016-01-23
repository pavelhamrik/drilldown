//
//  DateHelpers.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 13.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import Foundation

class DateHelpers {
    
    
    // format a date String that's already a String
    
    static func formatDate(date: String) -> String {
        return DateHelpers.formatDate(date, inputFormat: "yyyy-MM-dd'T'hh:mm:ssXXX", outputDateStyle: NSDateFormatterStyle.MediumStyle, outputTimeStyle: NSDateFormatterStyle.NoStyle)
    }
    
    static func formatDate(date: String, inputFormat: String) -> String {
        return DateHelpers.formatDate(date, inputFormat: inputFormat, outputDateStyle: NSDateFormatterStyle.MediumStyle, outputTimeStyle: NSDateFormatterStyle.NoStyle)
    }

    static func formatDate(date: String, inputFormat: String, outputDateStyle: NSDateFormatterStyle) -> String {
        return DateHelpers.formatDate(date, inputFormat: inputFormat, outputDateStyle: outputDateStyle, outputTimeStyle: NSDateFormatterStyle.NoStyle)
    }

    static func formatDate(date: String, inputFormat: String, outputDateStyle: NSDateFormatterStyle, outputTimeStyle: NSDateFormatterStyle) -> String {
    
        let formatter = NSDateFormatter()
        var output = ""

        formatter.dateFormat = inputFormat
        let nsDate = formatter.dateFromString(date)
        
        if nsDate != nil {
            output = DateHelpers.dateToString(nsDate!, dateStyle: outputDateStyle, timeStyle: outputTimeStyle)
        }
        
        return output
    
    }
    
    
    // format an NSDate
    
    static func dateToString(date: NSDate) -> String {
        return DateHelpers.dateToString(date, dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)
    }
    
    static func dateToString(date: NSDate, dateStyle: NSDateFormatterStyle) -> String {
        return DateHelpers.dateToString(date, dateStyle: dateStyle, timeStyle: NSDateFormatterStyle.NoStyle)
    }
    
    static func dateToString(date: NSDate, dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle) -> String {
    
        let formatter = NSDateFormatter()
        var output = ""
        
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        output = formatter.stringFromDate(date)
        
        return output
    
    }
    
    
    // convert a String to NSDate
    
    static func stringToDate(string: String) -> NSDate {
        
        let formatter = NSDateFormatter()
        return formatter.dateFromString(string)!
        
    }
    
    
    // convert Double to NSDate
    
    static func doubleToDate(double: Double) -> NSDate {
        
        return NSDate(timeIntervalSince1970: double)
        
    }
    

}
