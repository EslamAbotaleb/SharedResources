//
//  tasksStatisticsModelCerqel.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation

// MARK: - Welcome
public struct tasksStatisticsModelCerqel: Codable {
    public let message: String?
    public let success: Bool?
    public let result: tasksStatisticsResultCerqel?
}

// MARK: - Result
public struct tasksStatisticsResultCerqel: Codable {
    public let data: tasksStatisticsDataClassCerqel?
}

// MARK: - DataClass
public struct tasksStatisticsDataClassCerqel: Codable {
    public let totalCount: Int?
    public let statusDto: [StatusDtoCerqel]?
}

// MARK: - StatusDto
public struct StatusDtoCerqel: Codable {
    public let statusName, statusCode, statusColor: String?
    public let persentage: Double?
    public let count: Int?
    
    public init(statusName: String?, statusCode: String?, statusColor: String?, persentage: Double?, count: Int?) {
        self.statusName = statusName
        self.statusCode = statusCode
        self.statusColor = statusColor
        self.persentage = persentage
        self.count = count
    }
}
