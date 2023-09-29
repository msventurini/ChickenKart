//
//  MotionManager.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import CoreMotion

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    let motionQueue = OperationQueue()
    
    @Published var rotationRateValue = CMRotationRate()

    init() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.001
            motionManager.startGyroUpdates(to: motionQueue) { data, _ in
                if let rotationRate = data?.rotationRate {
                    DispatchQueue.main.async {
                        self.rotationRateValue.z += rotationRate.z
                        self.rotationRateValue.y += rotationRate.y
                    }
                }
            }

        }
    }
}
