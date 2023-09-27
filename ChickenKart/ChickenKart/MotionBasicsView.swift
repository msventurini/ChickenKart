////
////  MotionBasicsView.swift
////  ChickenKart
////
////  Created by Raquel Ramos on 25/09/23.
////
//
//import SwiftUI
//import CoreMotion
//
//struct MotionBasicsView: View {
//    @StateObject private var motionManager = MotionManager()
//    @State private var biggestX: Double = -100.0
//
//    var body: some View {
//        
//            let offset = motionManager.rotationRateValue.z * 10
//        VStack{
//            Image(systemName: "square")
//                .resizable()
//                .scaledToFit()
////                .frame(width: 100, height: 100)
//                .foregroundColor(.yellow)
//                .padding()
//                .offset(x: offset)
//            Button{
//                motionManager.rotationRateValue.z = 0.0
//            }label: {
//                Text("back to the middle")
//            }
//        }
//        
//                
// 
//    }
//}
//
//
//
//
//struct MotionBasicsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MotionBasicsView()
//    }
//}
