//
//  DButton.swift
//  WeatherApp
//
//  Created by Dennis van den Berg on 20/08/2022.
//

import SwiftUI

struct DButton: View {
    var label: String
    
    var width: CGFloat = 280
    var height: CGFloat = 40
    var cornerRadius: CGFloat = 10
    var textSize: CGFloat = 14
    
    var body: some View {
        Text(label)
            .frame(width: width, height: height)
            .background(.white)
            .cornerRadius(cornerRadius)
            .font(.system(size: textSize, weight: .bold))
    }
}
