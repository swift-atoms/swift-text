// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-text-primitives open source project
//
// Copyright (c) 2025 Coen ten Thije Boonkkamp and the swift-text-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension Text.Line.Number {
    /// Errors that can occur during line number construction.
    public enum Error: Swift.Error, Hashable, Sendable {
        /// The source integer was negative.
        ///
        /// - Parameter value: The negative value that was provided.
        case negativeSource(Int)
    }
}
