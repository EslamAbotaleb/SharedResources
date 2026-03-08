//
//  FieldValidationType.swift
//  SharedResources
//
//  Created by Eslam on 08/03/2026.
//

import Foundation

public enum FieldValidationType {
    case required, maxAttachment,minimumDate,maximumDate,minimumTime,maximumTime,allowedDaysRange, dateTime, minimumCharacterLength, maximumCharacterLength, minimumWordLength, maximumWordLength, email, url, numeric, alphabetic, alphanumeric, custom, minimumValue, maximumValue, minimumDigits, maximumDigits, minimumNumberOfSelectedOptions, maximumNumberOfSelectedOptions,minRows,maxRows,maxAttachmentNumber,maxAttachmentSize,attachmentType,attachmentExtensions
}

public enum FieldValidationRequiredType {
    case fileUpload, table, input, number, dateTime, mcq
}
