//
//  CalculationViewModel.swift
//  Safe Sip
//
//  Created by Benjamin Harteis on 8/29/25.
//
import SwiftUI
import Combine

class CalculationViewModel: ObservableObject {
    
    @Published var gender: String?
    @Published var bodyWeight: String
    @Published var isKeyboardPresent: Bool
    @Published var drinks = [[String]]()
    @Published var BAC: Double?
    @Published var showErrorMessage: Bool?
    @Published var hours: String
    @Published var minutes: String
    @Published var message: String
    @Published var time: String?

    
    init() {
        bodyWeight = ""
        isKeyboardPresent = false
        drinks = [["2", "1", "1"]]
        hours = "0"
        minutes = "0"
        message = ""
    }
    
    func checkPoundLabel() {
        if !bodyWeight.contains("lbs") && !isKeyboardPresent {
            bodyWeight += " lbs"
        } else if isKeyboardPresent && bodyWeight.contains("lbs"){
            bodyWeight.removeLast(4)
        }
    }
    
    
    func addDrink() {
        drinks.append(["1", "1", "1"])
    }
    
    func removeDrink() {
        drinks.removeLast()
    }
    
    func checkForError() {
        
        for drink in drinks {
            for value in drink {
                if value.isEmpty {
                    showErrorMessage = true
                    return
                }
            }
            
        }
        
        if gender == nil || bodyWeight.isEmpty || hours.isEmpty || minutes.isEmpty {
            showErrorMessage = true
            return
        }
        
        
        showErrorMessage = false
        calculate()
        
    }
    
    func getR () -> Double? {   //r is a constant used in the equation, based off of gender
        if gender == "male" {
            return 0.68
        } else if gender == "female" {
            return 0.55
        } else {
            return nil
        }
    }
    
    func calculate() -> Double? {
        
        var bodyWeightValue = bodyWeight
        bodyWeightValue.removeLast(4)
        
        
        
        
        var alcoholGrams = 0.0
        
        let hours = Double(self.hours) ?? 0.0
        let minutes = Double(self.minutes) ?? 0.0
        
        for drink in drinks {
            
            alcoholGrams += (Double(drink[0])! * 28.3495 * (Double(drink[1])! / 100)) * Double(drink[2])!
            
            
        }
        
        BAC = (alcoholGrams / (Double(bodyWeightValue)! * 453.592 * getR()!) * 100)
        
        
        BAC! -= 0.016 * (hours + minutes / 60.0)
        
        calculateTime()
        assignMessage()
        
        if BAC == nil {
            return nil
        } else {
            return BAC
        }
        
    }
    
    
    func assignMessage() {
        if BAC ?? 0.0 > 0.200 {
            message = "You Blood-Alcohol Level is dangerously high. Please do not drive or continue to drink. It will take approximately " + (time ?? "") + " until you can drive."
        } else if BAC ?? 0.0 >= 0.08 {
        message = "You are above the legal limit to drive. It will take approximatelty " + (time ?? "") + " until your BAC drops below the legal limit."
        } else if BAC ?? 0.0 < 0.08 {
            message = "You are under the legal driving limit. Drive with caution. If you experience any dizziness or blurred vision, do not drive."
        }
    }
    
    func calculateTime() {
        let hours = ((BAC ?? 0.0) - 0.08) / 0.016
        let minutes = (hours - Double(Int(hours))) * 60
        
        time = "\(Int(hours)) hours and \(Int(minutes)) minutes"
        
        
    }
    
    func notify() {
        //gets user permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error {
                print(error.localizedDescription)
                return
            }
        }
        
        
        let content = UNMutableNotificationContent()
        content.title = "Drive with caution"
        content.body = "If you haven't had any drinks since your last calculation, you should be legal to drive!"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let seconds = (((Double(hours) ?? 0.0) * 60) + (Double(minutes) ?? 0.0)) * 60
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
        
    }
}
