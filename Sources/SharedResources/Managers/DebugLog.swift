//
//  DebugLog.swift
//  SharedResources
//
//  Copyright © 2024 Youxel. All rights reserved.
//

import Foundation

/// A lightweight debug logging manager.
/// Use `debugLog(...)` instead of `print(...)` to ensure
/// logs only appear in DEBUG builds.
///
/// Usage:
///   `debugLog("User token refreshed")`
///   `debugLog("API response:", data, "status:", code)`
///
public final class DebugLogger {

    public static let shared = DebugLogger()

    private init() {}

    /// Logs a message only in DEBUG builds.
    /// - Parameters:
    ///   - items: Zero or more items to print.
    ///   - separator: Separator between items (default: space).
    ///   - terminator: Line terminator (default: newline).
    ///   - file: The calling file (auto-filled).
    ///   - line: The calling line number (auto-filled).
    public func log(
        _ items: Any...,
        separator: String = " ",
        terminator: String = "\n",
        file: String = #file,
        line: Int = #line
    ) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print("[\(fileName):\(line)] \(output)", terminator: terminator)
        #endif
    }
}

/// Global shorthand so you can call `debugLog(...)` anywhere.
public func debugLog(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n",
    file: String = #file,
    line: Int = #line
) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let output = items.map { "\($0)" }.joined(separator: separator)
    Swift.print("[\(fileName):\(line)] \(output)", terminator: terminator)
    #endif
}
