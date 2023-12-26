//
//  StageAccessManager.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/9/23.
//
import Foundation

final class LevelAccessManager {
    static let shared = LevelAccessManager()
    private let alphabet = "AӘБВГҒДЕЁЖЗИЙКҚЛМНҢОӨПРСТУҰҮФХҺЦЧШЩЪЫІЬЭЮЯ"
    static var currentLevel: Int = 0
    private var levelAccessArray = [Bool](repeating: false, count: 42)
    private init() {
        levelAccessArray[0] = true
    }
    
    func checkLevelAccess(level: Int) -> Bool {
        guard level >= 0 && level <= levelAccessArray.count - 1 else {
            return false
        }
        return levelAccessArray[level]
    }
    
    func unlockLevelAccess(level: Int) {
        guard level >= 0 && level <= levelAccessArray.count else {
            return
        }
        LevelAccessManager.currentLevel = level
        levelAccessArray[level] = true
    }
}
