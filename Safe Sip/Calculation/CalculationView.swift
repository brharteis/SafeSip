//
//  CalculationView.swift
//  Safe Sip
//
//  Created by Benjamin Harteis on 8/29/25.
//
import SwiftUI

struct CalculationView: View {
    @StateObject var viewModel = CalculationViewModel()
    
    var body: some View {
        ZStack {
            Background()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: Global.screenHeight * 0.06) {
                    GenderSelectView(viewModel: viewModel)
                    BodyWeightView(viewModel: viewModel)
                    TimeView(viewModel: viewModel)
                    DrinkView(viewModel: viewModel)
                    DrinkButtonView(viewModel: viewModel)
                    ErrorView(viewModel: viewModel)
                    CalculationButtonView(viewModel: viewModel)
                    ResultViewModel(viewModel: viewModel)
                }
            }
        }
    }
}

struct GenderSelectView: View {
    @ObservedObject var viewModel: CalculationViewModel
    var body: some View {
        VStack {
            Text("Gender")
                .font(.system(size: Global.screenWidth * 0.08, weight: .bold, design: .default))
                .frame(width: Global.screenWidth * 0.85, alignment: .center)
                .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
            
            HStack {
                Text("Male")
                    .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                    .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
                Button(action: {
                    viewModel.gender = "male"
                }) {
                    Circle()
                        .foregroundStyle(Color(red: 0.14, green: 0.14, blue: 0.14))
                        .frame(width: Global.screenWidth * 0.07, height: Global.screenWidth * 0.07)
                        .overlay(viewModel.gender == "male" ?
                            
                                Circle()
                                    .frame(width: Global.screenWidth * 0.04, height: Global.screenWidth * 0.04)
                                    .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                                 : nil
                            
                            )
                }.padding(.trailing, Global.screenWidth * 0.1)
                Text("Female")
                    .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                    .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
                Button(action: {
                    viewModel.gender = "female"
                }) {
                    Circle()
                        .foregroundStyle(Color(red: 0.14, green: 0.14, blue: 0.14))
                        .frame(width: Global.screenWidth * 0.07, height: Global.screenWidth * 0.07)
                        .overlay(viewModel.gender == "female" ?
                            
                                Circle()
                                    .frame(width: Global.screenWidth * 0.04, height: Global.screenWidth * 0.04)
                                    .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                                 : nil
                            
                            )
                }
            }
        }
    }
}

struct BodyWeightView: View {
    @ObservedObject var viewModel: CalculationViewModel
    var body: some View {
        VStack {
            Text("Body Weight")
                .font(.system(size: Global.screenWidth * 0.08, weight: .bold, design: .default))
                .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
            ZStack {
                if viewModel.bodyWeight.isEmpty {
                    Text("Weight in pounds")
                        .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                        .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
                        .background(RoundedRectangle(cornerRadius: 50).fill(Color(red: 0.14, green: 0.14, blue: 0.14)))
                }
                TextField("", text: $viewModel.bodyWeight, onEditingChanged: { editing in
                    if editing {
                        viewModel.isKeyboardPresent = true
                    }
                }).toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                           
                            viewModel.isKeyboardPresent = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }
                }
                
                    .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                    .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)

            }.frame(width: Global.screenWidth * 0.52, height: Global.screenWidth * 0.1)
             .background(RoundedRectangle(cornerRadius: 50).fill(Color(red: 0.14, green: 0.14, blue: 0.14)))
        }.onChange(of: viewModel.isKeyboardPresent) {
            viewModel.checkPoundLabel()
        }
            
    }
}

struct TimeView: View {
    @ObservedObject var viewModel: CalculationViewModel
    var body: some View {
        VStack {
            Text("Time since first drink")
                .font(.system(size: Global.screenWidth * 0.08, weight: .bold, design: .default))
                .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
            ZStack {
                HStack {
                    
                    
                    
                    HStack(spacing: -20) {
                        TextField("", text: $viewModel.hours)
                        Text("Hours")
                            .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                            .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
                            .background(RoundedRectangle(cornerRadius: 50).fill(Color(red: 0.14, green: 0.14, blue: 0.14)))
                            .padding(.trailing, Global.screenWidth * 0.07)
                    }.frame(width: Global.screenWidth * 0.4, height: Global.screenWidth * 0.1)
                        .background(RoundedRectangle(cornerRadius: 50).fill(Color(red: 0.14, green: 0.14, blue: 0.14)))
                    
                    HStack(spacing: -20) {
                        TextField("", text: $viewModel.minutes)
                        Text("Minutes")
                            .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                            .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
                            .background(RoundedRectangle(cornerRadius: 50).fill(Color(red: 0.14, green: 0.14, blue: 0.14)))
                            .padding(.trailing, Global.screenWidth * 0.04)
                           
                    }.frame(width: Global.screenWidth * 0.45, height: Global.screenWidth * 0.1)
                    .background(RoundedRectangle(cornerRadius: 50).fill(Color(red: 0.14, green: 0.14, blue: 0.14)))
                }
                    .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                    .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)

            }.frame(width: Global.screenWidth * 0.52, height: Global.screenWidth * 0.1)
             
        }
            
    }
}



struct DrinkView: View {
    @ObservedObject var viewModel: CalculationViewModel
    @FocusState var isSizeFocused: Bool
    @FocusState var isPercentFocused: Bool
    @FocusState var isQuantityFocused: Bool
    
    var body: some View {
        
        
            VStack {
                ForEach(0..<viewModel.drinks.count, id: \.self) { index in
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: Global.screenWidth * 0.75, height: Global.screenHeight * 0.25)
                            .foregroundStyle(Color(red: 0.14, green: 0.14, blue: 0.14))
                        
                    VStack(spacing: Global.screenHeight * 0.03) {
                        
                        ZStack {
                            Button(action: {
                                isSizeFocused = true
                            } ) {
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: Global.screenWidth * 0.4, height: Global.screenHeight * 0.05)
                                    .foregroundStyle(Color(red: 0.11, green: 0.11, blue: 0.11))
                                    .offset(x: -Global.screenWidth * 0.3)
                            }
                            HStack {
                                Text("Size in oz: ")
                                TextField("oz", text: $viewModel.drinks[index][0])
                                    .focused($isSizeFocused)
                                    .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                                    .keyboardType(.decimalPad)

                                
                            }
                        }
                        
                        
                        ZStack {
                            Button(action: {
                                isPercentFocused = true
                            } ) {
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: Global.screenWidth * 0.6, height: Global.screenHeight * 0.05)
                                    .foregroundStyle(Color(red: 0.11, green: 0.11, blue: 0.11))
                                    .offset(x: -Global.screenWidth * 0.2)
                            }
                            HStack {
                                Text("Alcohol Percentage: ")
                                TextField("%", text: $viewModel.drinks[index][1])
                                    .focused($isPercentFocused)
                                    .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                                    .keyboardType(.decimalPad)

                            }
                        }
                        
                        
                        ZStack {
                            Button(action: {
                                isQuantityFocused = true
                            } ) {
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: Global.screenWidth * 0.4, height: Global.screenHeight * 0.05)
                                    .foregroundStyle(Color(red: 0.11, green: 0.11, blue: 0.11))
                                    .offset(x: -Global.screenWidth * 0.3)
                            }
                            HStack {
                                Text("Quantity: ")
                                TextField("1", text: $viewModel.drinks[index][2])
                                    .focused($isQuantityFocused)
                                    .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                                    .keyboardType(.decimalPad)

                            }
                        }
                        
                    }
                    .foregroundStyle(Color(red: 0.85, green: 0.82, blue: 0.82))
                    .frame(width: Global.screenWidth * 0.9)
                    .padding(.leading, Global.screenWidth * 0.35)
                    .font(.system(size: Global.screenWidth * 0.045, weight: .bold, design: .default))
                    
                    
                }
                
            }
        }
    }
}

struct DrinkButtonView: View {
    @ObservedObject var viewModel: CalculationViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button("Add Drink") {
                viewModel.addDrink()
            }
            Button("Remove Drink") {
                viewModel.removeDrink()
            }
            .disabled(viewModel.drinks.count == 1)
            
        }.foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
            .offset(x: Global.isSmallDevice ? -Global.screenWidth * 0.25 : -Global.screenWidth * 0.28, y: -Global.screenHeight * 0.03)
            .font(.system(size: Global.screenWidth * 0.03))
        
    }
}

struct CalculationButtonView: View {
    @ObservedObject var viewModel: CalculationViewModel
    var body: some View {
        
        
        Button(action: {
            viewModel.checkForError()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.14, green: 0.14, blue: 0.14))
                    .frame(width: Global.screenWidth * 0.85, height: Global.screenHeight * 0.1)
                HStack {
                    Text("Estimate Alcohol Level")
                        .font(.system(size: Global.screenWidth * 0.07, weight: .bold, design: .default))
                        .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                }
            }
        }.offset(y: -Global.screenHeight * 0.03)
            .padding(.bottom, Global.screenWidth * 0.07)
    }
}

struct ErrorView: View {
    @ObservedObject var viewModel: CalculationViewModel
    var body: some View {
        if viewModel.showErrorMessage ?? false {
            Text("All fields must include a valid value")
                .foregroundStyle(Color.red)
                .font(.system(size: Global.screenWidth * 0.045))
        }
    }
}

struct ResultViewModel: View {
    @ObservedObject var viewModel: CalculationViewModel
    
    var body: some View {
        
        if viewModel.showErrorMessage == false && viewModel.showErrorMessage != nil {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: Global.screenWidth * 0.8, height: Global.isSmallDevice ? Global.screenHeight * 0.52 : Global.screenHeight * 0.64)
                    .foregroundStyle(Color(red: 0.14, green: 0.14, blue: 0.14))
                
                    Text("Results")
                        .font(.system(size: Global.screenWidth * 0.08, weight: .bold, design: .default))
                        .foregroundStyle(Color(.white))
                        .offset(y: Global.isSmallDevice ? -Global.screenHeight * 0.2 : -Global.screenHeight * 0.25)
                VStack(spacing: viewModel.BAC ?? 0.0 >= 0.08 ? Global.screenHeight * 0.04 : Global.screenHeight * 0.08) {
                    Text(String(format: "%.4f% Blood Alcohol Level", viewModel.BAC ?? 0.0))
                        .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                        .foregroundStyle(Color(red: 0.9, green: 0.6, blue: 0.3))
                    Text(viewModel.message)
                        .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                        .foregroundStyle(Color(.white))
                    if viewModel.BAC ?? 0.0 >= 0.08 {
                        Text("Would you like to be notified when it becomes legal for you to drive?")
                            .font(.system(size: Global.screenWidth * 0.05, weight: .bold, design: .default))
                            .foregroundStyle(Color(.white))
                        
                        HStack {
                            Button(action: {
                                viewModel.notify()
                            }) {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: Global.screenWidth * 0.35, height: Global.screenHeight * 0.06)
                                    .foregroundStyle(Color(red: 0.11, green: 0.11, blue: 0.11))
                                    .overlay(
                                        Text("Yes")
                                            .font(.system(size: Global.screenWidth * 0.04, weight: .bold, design: .default))
                                    )
                            }
                            
                            Button(action: {
                                print("Hello")
                            }) {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: Global.screenWidth * 0.35, height: Global.screenHeight * 0.06)
                                    .foregroundStyle(Color(red: 0.11, green: 0.11, blue: 0.11))
                                    .overlay(
                                        Text("No")
                                            .font(.system(size: Global.screenWidth * 0.04, weight: .bold, design: .default))
                                    )
                            }
                        }.offset(y: -Global.screenHeight * 0.028)
                    }
                }.frame(width: Global.screenWidth * 0.75)
                .offset(y: Global.screenHeight * 0.05)
            }
        }
    }
    
}

#Preview {
    CalculationView()
}
