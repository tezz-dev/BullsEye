//
//  ContentView.swift
//  Novelore
//
//  Created by Tejas M R on 19/09/20.
//  Copyright © 2020 Tejas M R. All rights reserved.
//

import SwiftUI

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    var body : some View{
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(textColor)
        }
        .padding()
    }
}

struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff*rDiff + gDiff*gDiff + bDiff*bDiff)
        return Int((1.0 - diff) * 100 + 0.5)
    }
    var body: some View {
        VStack {
            Text("BullsEye")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.purple)
            HStack {
                VStack {
                    Rectangle()
                        .cornerRadius(15)
                        .foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))
                        .padding()
                        .aspectRatio(1.0, contentMode: .fit)
                    
                    Text("Match This color")
                }
                VStack {
                    Rectangle()
                        .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))
                        .cornerRadius(15)
                        .padding()
                    .aspectRatio(1.0, contentMode: .fit)
                    HStack {
                        Text("R: \(Int(rGuess * 255.0))")
                        Text("G: \(Int(gGuess * 255.0))")
                        Text("B: \(Int(bGuess * 255.0))")
                    }
                }
            }
            ColorSlider(value: $rGuess, textColor: .red)
            ColorSlider(value: $gGuess, textColor: .green)
            ColorSlider(value: $bGuess, textColor: .blue)
            Button(action: {
                self.showAlert = true
            }) {
                Text("Submit")
                    .padding(12)
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.3, green: 0.2, blue: 1), Color(red: 0.6, green: 0.2, blue: 1)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15.0)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your Score:"),
                      message: Text("\(computeScore())"))
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
    }
}
