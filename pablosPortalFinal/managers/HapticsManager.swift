//
//  HapticsManager.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 10/15/21.
//

import Foundation
import UIKit
import CoreHaptics

final class HapticsManager {
    static let shared = HapticsManager()
    
    private var engine: CHHapticEngine?
    
    private init() {}
    
    public func buttonHaptic() {
        DispatchQueue.main.async {
            let selectionFeedbackgenerator = UISelectionFeedbackGenerator()
            selectionFeedbackgenerator.prepare()
            selectionFeedbackgenerator.selectionChanged()
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do {
            self.engine = try CHHapticEngine()
            try? engine?.start()
        } catch {
            print("error creating engine")
        }
    }
    
    public func hapticSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        var events = [CHHapticEvent]()
        
        //create one instance, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makeAdvancedPlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("error with haptics")
        }
        
    }
    
    
    
}
