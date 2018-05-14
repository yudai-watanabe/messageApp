//
//  SelfMessageTableViewCell.swift
//  messageApp
//
//  Created by watanabe-yudai on 2018/05/11.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import UIKit

class SelfMessageTableViewCell: UITableViewCell {
	
	open let identifier: String = "SelfMessageTableViewCell"
	
	@IBOutlet weak var messageLabel: UILabel!
	
	public var message: String? {
		didSet {
			self.messageLabel.text = message
		}
	}

}
