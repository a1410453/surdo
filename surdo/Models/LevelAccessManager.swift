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
    static private var levelAccessArray = [Bool](repeating: false, count: 42)
    private init() {
        LevelAccessManager.levelAccessArray[0] = true
    }
    
    func checkLevelAccess(level: Int) -> Bool {
        guard level >= 0 && level <= LevelAccessManager.levelAccessArray.count - 1 else {
            return false
        }
        return LevelAccessManager.levelAccessArray[level]
    }
    
    func unlockLevelAccess() {
        for i in 0...LevelAccessManager.currentLevel {
            LevelAccessManager.levelAccessArray[i] = true
        }
    }
}
