//
//  UnsafeMutablePointerProvider.swift
//  Pango
//
//  Created by Rayman Rosevear on 2023/05/28.
//

/// This file adds methods providing some extensibility to the library, giving access to the pointers.

public protocol UnsafeMutablePointerProvider
{
    /// The type of value being pointed at by this pointer
    associatedtype Pointee

    /// Calls the given closure with the underlying `UnsafeMutablePointer`.
    ///
    /// The pointer passed as an argument to `body` is valid only during the execution of
    /// `withUnsafeMutablePointer(_:)`. Do not store or return the pointer for later use.
    ///
    /// - Parameters:
    ///   - body: A closure with a pointer parameter. If `body` has a return value, that value is also used as the
    ///     return value for the `withUnsafeMutablePointer(_:)` method. The pointer argument is valid only for the
    ///     duration of the method's execution.
    /// - Returns: The return value, if any, of the `body` closure parameter.
    func withUnsafeMutablePointer<Result>(_ body: (UnsafeMutablePointer<Pointee>) throws -> Result) rethrows -> Result
}

/// Internally conform to this protocol to automatically become an `UnsafeMutablePointerProvider`.
internal protocol UnsafeMutablePointerOwner: UnsafeMutablePointerProvider
{
    var internalPointer: UnsafeMutablePointer<Pointee> { get }
}

extension UnsafeMutablePointerOwner
{
    public func withUnsafeMutablePointer<Result>(
        _ body: (UnsafeMutablePointer<Pointee>
    ) throws -> Result) rethrows -> Result
    {
        try body(self.internalPointer)
    }
}
