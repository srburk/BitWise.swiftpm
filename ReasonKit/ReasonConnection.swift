//
//  ReasonConnection.swift
//
//
//  Created by Sam Burkhard on 2/1/24.
//

import Foundation

final class ReasonConnection {
    let id: UUID
    
    var head: BaseReasonComponent
    var tail: BaseReasonComponent
    var value: Bool
    
    init(head: BaseReasonComponent, tail: BaseReasonComponent, value: Bool = false) {
        self.id = UUID()
        self.head = head
        self.tail = tail
        self.value = value
    }
}

//extension ReasonConnection {
//    
//    public func removeConnections() {
//        self.tail.inputConnections.removeAll(where: { $0.id == self.id })
//        self.head.outputConnections.removeAll(where: { $0.id == self.id })
//    }
//    
//}
