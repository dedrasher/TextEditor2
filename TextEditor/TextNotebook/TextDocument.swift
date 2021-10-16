//
//  TextDocument.swift
//  TextDocument
//
//  Created by Serega on 16.10.2021.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers
public struct TextDocument: FileDocument {
    public static var readableContentTypes = [UTType.plainText]
    public var text : String
    init(initialText: String = "") {
        text = initialText
    }
    public init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
