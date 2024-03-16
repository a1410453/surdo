//
//  StageAccessManager.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/9/23.
//
import Foundation

final class LevelAccessManager {
    static let shared = LevelAccessManager()
    static let alphabet = "AӘБВГҒДЕЁЖЗИЙКҚЛМНҢОӨПРСТУҰҮФХҺЦЧШЩЪЫІЬЭЮЯ"
    static var currentLevel: Int = 0
    static var learningScore: Int = 0
    static private var levelAccess: Int = 0
    
    func checkLevelAccess(level: Int) -> Bool {
        guard level >= 0 && level <= LevelAccessManager.levelAccess else {
            return false
        }
        return true
    }
    
    func unlockLevelAccess() {
        LevelAccessManager.levelAccess = LevelAccessManager.currentLevel
    }
}
