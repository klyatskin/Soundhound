//
//  ViewController.swift
//  Soundhound
//
//  Created by Konstantin Klyatskin on 2019-09-26.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCell.kLazyLabelCellReuseId)
    }
    
    private var labelCache: [IndexPath:LazyLabel] = [:]
}

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.kLazyLabelCellReuseId, for: indexPath) as! TableViewCell
        let label = labelCache[indexPath] ?? LazyLabel(frame: cell.contentView.bounds)
        labelCache[indexPath] = label
        cell.labelPlaceholder.addSubview(label)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
