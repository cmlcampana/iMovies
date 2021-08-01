//
//  String+FormatDate.swift
//  iMovie
//
//  Created by Camila Campana on 01/08/21.
//

import Foundation

extension String {
    func formatDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
           return self
        }
    }
}
