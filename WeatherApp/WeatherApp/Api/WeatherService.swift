//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Dennis van den Berg on 21/08/2022.
//

import Foundation
import devdbe_weather_sdk

@MainActor
class WeatherService: ObservableObject {
    @Published var forecasts: Forecasts?
    
    private var task: Task<Void, Never>?
    private static var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "weather-api", ofType: "plist") else {
                fatalError("Could not find file: weather-api.plist")
            }

            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Could not find key 'API_KEY' in 'weather-api.plist'")
            }

            return value
        }
    }
    private var weatherApi = WeatherApiImpl(apiKey: apiKey)
    
    private func map(data: RForecastDay?) -> Forecasts? {
        guard let forecastDay = data else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-mm-DD"
        
        let mappedForecastList = forecastDay.data.map { (forecast) in
            guard let date = formatter.date(from: forecast.datetime ?? "") else { fatalError("Not a date") }
            let temp = forecast.temp ?? 0
            let condition = forecast.weather?.code ?? 0
            
            return Forecast(date: date,
                            avgtemp_c: temp,
                            weatherImage: getSystemImage(fromWeatherCode: condition)
                            )
        }
        let mappedForecasts = Forecasts(location: forecastDay.city_name ?? "Unknown", forecast: mappedForecastList)
        return mappedForecasts
    }
    
    private func getSystemImage(fromWeatherCode code: Int) -> String {
        switch (code) {
        case 200, 201, 202:
            return "cloud.bolt.rain.fill"
        case 230, 231, 232, 233:
            return "cloud.bolt"
        case 300, 301, 302:
            return "cloud.drizzle.fill"
        case 500:
            return "cloud.rain.fill"
        case 501, 502, 511:
            return "cloud.heavyrain.fill"
        case 520, 521, 522:
            return "cloud.sun.rain.fill"
        case 600, 602, 610, 621, 622, 623:
            return "cloud.snow.fill"
        case 611, 612:
            return "cloud.sleet.fill"
        case 700, 711, 721:
            return "sun.haze.fill"
        case 731:
            return "sun.dust.fill"
        case 741, 751:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801, 802:
            return "cloud.sun.fill"
        case 803:
            return "smoke.fill"
        case 804:
            return "cloud.fill"
        case 900:
            return "wind"
        default:
            fatalError("Could not convert condition '\(code)' to system image")
        }
    }
    
    func getForecasts(for city: String, countryCode: String, forDays days: Int) -> Void {
        guard !city.isEmpty && !countryCode.isEmpty && days >= 1 else {
            task?.cancel()
            forecasts = nil
            return
        }
        
        task?.cancel()
        
        task = Task {
            guard !Task.isCancelled else {
                return
            }
            
            print("APP: Using SDK to fetch daily forecast")
            let forecasts = await weatherApi.dailyForecast(city: city, countryCode: countryCode, days: days)
            let mappedForecasts = map(data: forecasts)
            self.forecasts = mappedForecasts
        }
 
    }
}
