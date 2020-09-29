//
//  MulticastDelegate.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import Foundation

class MulticastDelegate<Delegate> {
    private let delegates: NSHashTable<AnyObject>
    var isEmpty: Bool { return delegates.count == 0 }

    init(strongReferences: Bool = false) {
        delegates = strongReferences ? NSHashTable<AnyObject>() : NSHashTable<AnyObject>.weakObjects()
    }

    internal func addDelegate(_ delegate: Delegate) {
        if !containsDelegate(delegate) { delegates.add(delegate as AnyObject) }
    }

    internal func removeDelegate(_ delegate: Delegate) {
        if containsDelegate(delegate) { delegates.remove(delegate as AnyObject) }
    }

    internal func invokeDelegates(_ invocation: (Delegate) -> Void) {
        for delegate in delegates.allObjects {
            guard let validDelegate = delegate as? Delegate else { continue }
            invocation(validDelegate)
        }
    }

    private func containsDelegate(_ delegate: Delegate) -> Bool {
        return delegates.contains(delegate as AnyObject)
    }

    private func containsDelegate<DelegateType: Any>(ofType type: DelegateType) -> Bool {
        let enumerator = delegates.objectEnumerator()
        while let delegate = enumerator.nextObject() { if delegate is DelegateType { return true } }
        return false
    }
}

func +=<Delegate>(left: MulticastDelegate<Delegate>, right: Delegate) { left.addDelegate(right) }
func -=<Delegate>(left: MulticastDelegate<Delegate>, right: Delegate) { left.removeDelegate(right) }

precedencegroup MulticastPrecedence {
    associativity: left
    higherThan: TernaryPrecedence
}

infix operator ~~> : MulticastPrecedence
func ~~><Delegate>(left: MulticastDelegate<Delegate>, right: (Delegate) -> Void) { left.invokeDelegates(right) }
