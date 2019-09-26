//
//  LazyLabel.swift
//  Soundhound
//
//  Created by Konstantin Klyatskin on 2019-09-26.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import UIKit

class LazyLabel: UILabel {

    private static var count: Int = 0
    var labelText = "Start/duration = " // some header text...
    private var start: TimeInterval = 0.0
    private let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize:16)]
    private let normAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize:16)]

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .center
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.2
        labelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeLabelBoldInMainThread() {
        let duration = Date().timeIntervalSince1970 - self.start
        self.labelText = self.labelText + String (format: " / %.2f secs",duration)
        self.attributedText = NSAttributedString(string: self.labelText, attributes: self.boldAttribute)

    }
    
    private func makeLabelBold() {  // could be called from background thread!
        DispatchQueue.main.async { [weak self] in
            self!.makeLabelBoldInMainThread()
        }
    }
    
    
    private func labelSetup() {
        
        // show start time
        let date = Date()
        self.start = date.timeIntervalSince1970
        let formatter = DateFormatter()
        formatter.dateFormat = " HH:mm:ss"
        let startStr = formatter.string(from: date as Date)
        LazyLabel.count += 1
        labelText = "(\(LazyLabel.count)) " + labelText + startStr
        self.attributedText = NSAttributedString(string: labelText, attributes: normAttribute)

        // initialise slow background task
        if (QueueManager.threadsLimit == 0) {
            let queue = QueueManager.shared.dispatchQueue
            queue.async { [weak self] in
                sleep(2)
                self!.makeLabelBold()
            }
        } else {
            let queue = QueueManager.shared.operationQueue
            queue.addOperation { [weak self] in
                sleep(2)
                self!.makeLabelBold()
            }
        }
    }

}

