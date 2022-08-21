//
//  Forecast.swift
//  WeatherApp
//
//  Created by Dennis van den Berg on 20/08/2022.
//

import Foundation

struct Forecasts {
    var location: String
    var forecast: [Forecast]
}

struct Forecast {
    var id = UUID()
    var date: Date
    var avgtemp_c: Int
    var condition: String
}
