//
//  Timer.swift
//  ChickenKart
//
//  Created by Raquel Ramos on 27/09/23.
//

import Foundation

class RaceTimer: ObservableObject {
    
    var timer: Timer?
    
    @Published var seconds: Double = 0
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerFired() {
        self.seconds += 0.5
        
    }
}
