//
//  StageAccessManager.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/9/23.
//
import Foundation

class LevelAccessManager {
    static let shared = LevelAccessManager()
    
    private var levelAccessArray = [Bool](repeating: false, count: 42)
    private init() {
        levelAccessArray[0] = true
    }
    
    func checkLevelAccess(level: Int) -> Bool {
        guard level >= 1 && level <= levelAccessArray.count else {
            return false
        }
        return levelAccessArray[level - 1]
    }
    
    func setLevelAccess(level: Int, hasAccess: Bool) {
        guard level >= 1 && level <= levelAccessArray.count else {
            return
        }
        levelAccessArray[level - 1] = hasAccess
    }
}
