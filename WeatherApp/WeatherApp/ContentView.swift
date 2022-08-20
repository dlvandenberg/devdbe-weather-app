//
//  ContentView.swift
//  WeatherApp
//
//  Created by Dennis van den Berg on 20/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Background(topColor: Color("darkBlue"), bottomColor: Color("lightBlue"))
            
            VStack {
                CityText(city: "Amsterdam")
                
                TodayForecast(imageName: "cloud.sun.rain.fill", degrees: 20)
                
                Spacer()
                
                HStack(spacing: 25) {
                    UpcomingForecast(day: "MON", imageName: "cloud.heavyrain.fill", degrees: 19)
                    UpcomingForecast(day: "TUE", imageName: "cloud.sun.rain.fill", degrees: 20)
                    UpcomingForecast(day: "WED", imageName: "cloud.sun.bolt.fill", degrees: 25)
                    UpcomingForecast(day: "THU", imageName: "sun.max.fill", degrees: 30)
                    UpcomingForecast(day: "FRI", imageName: "cloud.bolt.rain.fill", degrees: 18)
                }
                
                Spacer()
                
                Button {
                    print("Tapped")
                } label: {
                    DButton(label: "Change time of day")
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UpcomingForecast: View {
    var day: String
    var imageName: String
    var degrees: Int
    
    var body: some View {
        VStack(spacing: 15) {
            Text(day)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.original)
                .frame(width: 40, height: 40)
                .aspectRatio(contentMode: .fit)
            
            Text("\(degrees)°")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}

struct Background: View {
    var topColor: Color
    var bottomColor: Color
    var body: some View {
        LinearGradient(colors: [topColor, bottomColor],
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
    var imageName: String
    var degrees: Int
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.original)
                .frame(width: 180, height: 180)
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text("\(degrees)°")
                .font(.system(size: 40, weight: .medium))
                .foregroundColor(.white)
        }
    }
}
