//
//  UITableView+Extensions.swift
//  Messenger
//
//  Created by Soohan Lee on 2020/05/23.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
  func register<Cell>(cell: Cell.Type, forCellReuseIdentifier reuseIdentifier: String = Cell.identifier) where Cell: UITableViewCell {
    register(cell, forCellReuseIdentifier: reuseIdentifier)
  }
  
  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell where Cell: UITableViewCell {
    if let cell = dequeueReusableCell(withIdentifier: reusableCell.identifier) as? Cell {
      return cell
    } else {
      fatalError("Identifier required")
    }
  }
  
  func dequeue<Cell>(_ reuseableCell: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
    dequeueReusableCell(withIdentifier: reuseableCell.identifier, for: indexPath) as! Cell
  }
}
