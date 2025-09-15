//
//  ContentView.swift
//  Safe Sip
//
//  Created by Benjamin Harteis on 8/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                VStack{
                    SloganView()
                    CalculateButtonView()
                        .offset(y: Global.isSmallDevice ? Global.screenHeight * 0.15 : Global.screenHeight * 0.05)
                    BreathalyzerView()
                        .offset(y: Global.isSmallDevice ? Global.screenHeight * 0.18 : Global.screenHeight * 0.06)
                    
                    
                }.offset(y: -60)
            }
        }
    }
}

struct LogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .frame(width: Global.screenWidth * 0.6, height: Global.screenHeight * 0.3)
    }
}

struct BreathalyzerView: View {
    var body: some View {
        Image("Breath")
            .resizable()
            .frame(width: Global.screenWidth * 0.5, height: Global.screenHeight * 0.15)
    }
}

struct SloganView: View {
    var body: some View {
        Text("One bad decision can cost you everything.\n\nDo not drive intoxicated.")
            .font(.system(size: Global.screenWidth * 0.1, weight: .bold, design: .default))
            .frame(width: Global.screenWidth * 0.85, alignment: .center)
            .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
    }
}

struct CalculateButtonView: View {
    var body: some View {
        NavigationLink(destination: CalculationView()) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.14, green: 0.14, blue: 0.14))
                    .frame(width: Global.screenWidth * 0.85, height: Global.screenHeight * 0.1)
                HStack {
                    Text("Calculate Alcohol Level")
                        .font(.system(size: Global.screenWidth * 0.07, weight: .bold, design: .default))
                        .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
