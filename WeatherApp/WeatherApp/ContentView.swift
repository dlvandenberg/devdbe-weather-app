//
//  ContentView.swift
//  WeatherApp
//
//  Created by Dennis van den Berg on 20/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    
    @StateObject var weatherService = WeatherService()
    
    var body: some View {
        ZStack {
            Background(isNight: $isNight)
            
            if let forecasts = weatherService.forecasts {
                VStack {
                    CityText(city: forecasts.location)
                    
                    TodayForecast(forecast: forecasts.forecast[0])
                    
                    Spacer()
                    
                    HStack(spacing: 25) {
                        ForEach (forecasts.forecast.dropFirst(),
                                 id: \.id) { f in
                            UpcomingForecast(forecast: f)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        isNight = !isNight
                    } label: {
                        DButton(label: "Change time of day")
                    }
                    
                    Spacer()
                }
            }
        }.onAppear {
            weatherService.getForecasts(for: "Amsterdam", countryCode: "NL", forDays: 6)
        }
        
    }
}

struct UpcomingForecast: View {
    var forecast: Forecast
    
    var body: some View {
        VStack(spacing: 15) {
            Text(forecast.date.dayOfWeek())
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: forecast.weatherImage)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text(String(format: "%.1f°", forecast.avgtemp_c))
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}

struct Background: View {
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(colors: [
            isNight ? .black : Color("darkBlue"),
            isNight ? .gray : Color("lightBlue")
        ],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct CityText: View {
    var city: String
    
    var body: some View {
        Text(city)
            .font(.system(size: 38, weight: .medium))
            .foregroundColor(.white)
    }
}

struct TodayForecast: View {
    var forecast: Forecast
    
    var body: some View {
        VStack {
            Image(systemName: forecast.weatherImage)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .padding()
            
            Text(String(format: "%.1f°", forecast.avgtemp_c))
                .font(.system(size: 40, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
