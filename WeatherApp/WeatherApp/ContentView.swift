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
            
            VStack {
                CityText(city: weatherService.forecasts.location)
                
                TodayForecast(forecast: weatherService.forecasts.forecast[0])
                
                Spacer()
                
                HStack(spacing: 25) {
                    ForEach (weatherService.forecasts.forecast.dropFirst(), id: \.id) { f in
                        UpcomingForecast(day: "TST", forecast: f)
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
    }
}

struct UpcomingForecast: View {
    var day: String
    var forecast: Forecast
    
    var body: some View {
        VStack(spacing: 15) {
            Text(forecast.date.dayOfWeek())
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: getIconName(forecast.condition))
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(forecast.avgtemp_c)°")
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
            Image(systemName: getIconName(forecast.condition))
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .padding()
            
            Text("\(forecast.avgtemp_c)°")
                .font(.system(size: 40, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

func getIconName(_ condition: String) -> String {
    switch(condition) {
    case "Sunny":
        return "sun.max.fill"
    case "Clear":
        return "moon.fill"
    case "Partly cloudy":
        return "cloud.sun.fill"
    case "Cloudy":
        return "cloud.fill"
    case "Overcast":
        return ""
    case "Mist":
        return "sun.haze.fill"
    case "Patchy rain possible":
        return "cloud.sun.rain.fill"
    case "Patchy snow possible":
        return ""
    case "Patchy sleet possible":
        return ""
    case "Patchy freezing drizzle possible":
        return ""
    case "Thundery outbreaks possible":
        return ""
    case "Blowing snow":
        return ""
    case "Blizzard":
        return ""
    case "Fog":
        return ""
    case "Freezing fog":
        return ""
    case "Patchy light drizzle":
        return ""
    case "Light drizzle":
        return ""
    case "Freezing drizzle":
        return ""
    case "Heavy freezing drizzle":
        return ""
    case "Patchy light rain":
        return ""
    case "Light rain":
        return ""
    case "Moderate rain at times":
        return "cloud.rain.fill"
    case "Heavy rain at times":
        return ""
    case "Heavy rain":
        return ""
    case "Light freezing rain":
        return ""
    case "Moderate or heavy freezing rain":
        return ""
    case "Light sleet":
        return ""
    case "Moderate or heavy sleet":
        return ""
    case "Patchy light snow":
        return ""
    case "Light snow":
        return ""
    case "Patchy moderate snow":
        return ""
    case "Moderate snow":
        return ""
    case "Patchy heavy snow":
        return ""
    case "Heavy snow":
        return ""
    case "Ice pellets":
        return ""
    case "Light rain shower":
        return ""
    case "Moderate or heavy rain shower":
        return ""
    case "Torrential rain shower":
        return ""
    case "Light sleet showers":
        return ""
    case "Moderate or heavy sleet showers":
        return ""
    case "Light snow showers":
        return ""
    case "Moderate or heavy snow showers":
        return ""
    case "Light showers of ice pellets":
        return ""
    case "Moderate or heavy showers of ice pellets":
        return ""
    case "Patchy light rain with thunder":
        return ""
    case "Moderate or heavy rain with thunder":
        return "cloud.bolt.rain.fill"
    case "Patchy light snow with thunder":
        return ""
    case "Moderate or heavy snow with thunder":
        return ""
    default:
        fatalError("No image yet for condition: \(condition)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
