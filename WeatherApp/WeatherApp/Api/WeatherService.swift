//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Dennis van den Berg on 21/08/2022.
//

import Foundation

class WeatherService: ObservableObject {
    @Published var forecasts: Forecasts

    init() {
        forecasts = Forecasts(location: "Borculo", forecast: [
            Forecast(
                date: Date(),
                avgtemp_c: 20,
                condition: "Partly cloudy"
            ),
            Forecast(
                date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                avgtemp_c: 18,
                condition: "Patchy rain possible"
            ),
            Forecast(
                date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                avgtemp_c: 24,
                condition: "Clear"
            ),
            Forecast(
                date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                avgtemp_c: 29,
                condition: "Moderate rain at times"
            ),
            Forecast(
                date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                avgtemp_c: 31,
                condition: "Mist"
            ),
            Forecast(
                date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                avgtemp_c: 21,
                condition: "Moderate or heavy rain with thunder"
            ),
        ])
    }
}
