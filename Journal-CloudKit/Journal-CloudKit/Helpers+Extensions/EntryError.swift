//
//  EntryError.swift
//  Journal-CloudKit
//
//  Created by Ian Becker on 8/17/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String {
        switch self {
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "Unable to get this Entry."
        }
    }
} // End of enum
