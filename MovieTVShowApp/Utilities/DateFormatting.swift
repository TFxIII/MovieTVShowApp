//
//  DateFormatting.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 24.04.2024.
//

import Foundation

func formatDate (_ dateString: String, _ dateFormat: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let date = dateFormatter.date(from: dateString) else { return nil }
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter.string(from: date)
}
