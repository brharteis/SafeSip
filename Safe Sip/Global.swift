//
//  Global.swift
//  Safe Sip
//
//  Created by Benjamin Harteis on 8/27/25.
//
import SwiftUI
import Combine

class Global {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let isSmallDevice = UIScreen.main.bounds.height <= 1000
}

struct Background: View {
    var body: some View {
        Color(red: 0.1, green: 0.1, blue: 0.1)
            .ignoresSafeArea()
    }
}

class KeyboardObserver: ObservableObject {
    @Published var isKeyboardPresent: Bool = false
    private var cancellables = Set<AnyCancellable>()
    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] _ in self?.isKeyboardPresent = true }
            .store(in: &cancellables)
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in self?.isKeyboardPresent = false }
            .store(in: &cancellables)
    }
}

