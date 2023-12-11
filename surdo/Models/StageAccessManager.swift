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
        levelAccessArray[1] = true
        levelAccessArray[2] = true
        levelAccessArray[3] = true
        levelAccessArray[4] = true
    }
    
    func checkLevelAccess(level: Int) -> Bool {
        guard level >= 0 && level <= levelAccessArray.count - 1 else {
            return false
        }
        return levelAccessArray[level]
    }
    
    func setLevelAccess(level: Int, hasAccess: Bool) {
        guard level >= 0 && level <= levelAccessArray.count else {
            return
        }
        levelAccessArray[level] = hasAccess
    }
}
