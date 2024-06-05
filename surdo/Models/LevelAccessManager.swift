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
    static let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 
                          20, 30, 40, 50, 60, 70, 80, 90,
                          100, 200, 300, 400, 500, 600, 700, 800, 900, 
                          1000, 1000000, 1000000000, 0]
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
