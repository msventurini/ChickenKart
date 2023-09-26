//
//  MotionBasicsView.swift
//  ChickenKart
//
//  Created by Raquel Ramos on 25/09/23.
//

import SwiftUI
import CoreMotion

struct MotionBasicsView: View {
    @StateObject private var motionManager = MotionManager()
    @State private var biggestX: Double = -100.0

    var body: some View {
        
            var offset = motionManager.rotationRateValue.z * 10
        VStack{
            Image(systemName: "square")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
                .padding()
                .offset(x: offset)
            Button{
                motionManager.rotationRateValue.z = 0.0
            }label: {
                Text("back to the middle")
            }
        }
        
                
 
    }
}

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
                        self.rotationRateValue.z -= rotationRate.z
                    }
                }
            }

        }
    }
}


struct MotionBasicsView_Previews: PreviewProvider {
    static var previews: some View {
        MotionBasicsView()
    }
}
