//
//  QueueManager.swift
//  Soundhound
//
//  Created by Konstantin Klyatskin on 2019-09-26.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import Foundation

class QueueManager
{
    static let shared = QueueManager()
    static private(set) var threadsLimit = 0 // 0 - to not limit, or max number of threads e.g. =2
    
    private init()
    {
    }

    // multiple treads
    lazy var dispatchQueue: DispatchQueue = {
       return DispatchQueue.init(label: "ConcurrentQueue", attributes: .concurrent)
    }()

    // limited amount of threads
    lazy var operationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "OperationQueue"
        queue.maxConcurrentOperationCount = QueueManager.threadsLimit
        return queue
    }()
}
