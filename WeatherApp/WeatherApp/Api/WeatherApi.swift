//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Dennis van den Berg on 21/08/2022.
//

import Foundation

protocol WeatherApi {
    func dailyForecast(city: String, countryCode: String, days: Int) async -> RForecastDay?
}

struct WeatherApiImpl: WeatherApi {
    let apiKey = "5a013f90dc2049e6aa953c752c0a4d4c"
    let baseUrl = "https://api.weatherbit.io/v2.0/"
    
    func dailyForecast(city: String, countryCode: String, days: Int) async -> RForecastDay? {
        let endpointUrl = "forecast/daily"
        let path = baseUrl + endpointUrl
        
        guard var urlComponents = URLComponents(string: path) else { fatalError("Could not create API URL") }
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "city", value: city),
            URLQueryItem(name: "country", value: countryCode),
            URLQueryItem(name: "days", value: String(days))
        ]
        
        guard let url = urlComponents.url else { fatalError("Could not construct URL") }
        
        do {
            print("Trying to fetch data from url \(url)")
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { print("Status != 200"); return nil }
            
            do {
                let decodedForecast = try JSONDecoder().decode(RForecastDay.self, from: data)
                return decodedForecast
            } catch {
                print("Could not decode: \(error)")
            }
        } catch {
            print("Error while fetching data \(error)")
            return nil
        }
        return nil
    }
    
    
}
