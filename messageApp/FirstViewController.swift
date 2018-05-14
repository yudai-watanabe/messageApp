//
//  FirstViewController.swift
//  messageApp
//
//  Created by watanabe-yudai on 2018/05/10.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirstViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var sendButton: UIButton!
	
	private let selfMessageTableViewCell: SelfMessageTableViewCell = SelfMessageTableViewCell()
	
	private var DBRef: DatabaseReference?
	
	private var messages: Array<String> = [] {
		didSet {
			tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.messages.removeAll()
		self.setTableView()
		self.sendButton.addTarget(self, action: #selector(self.send(_:)), for: .touchUpInside)
		DBRef = Database.database().reference()
		self.setObservers()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.textField.endEditing(true)
	}
	
	// MARK: -
	
	@objc func send(_ sender: UIButton) {
		guard let message = self.textField.text, message != "" else {
			return
		}
		self.textField.text = nil
		DBRef?.child(String(messages.count)).setValue(message)
	}
	
	// MARK: - private
	
	private func setTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: selfMessageTableViewCell.identifier,bundle: nil),
						   forCellReuseIdentifier: selfMessageTableViewCell.identifier)
	}
	
	private func setObservers() {
		DBRef?.observe(.childChanged, with: {[weak self] snapShot in
			guard let message = snapShot.value as? String, let keyNumnber = Int(snapShot.key) else{
				return
			}
			self?.messages[keyNumnber] = message
		})
		
		DBRef?.observe(.childAdded, with: {[weak self] snapShot in
			guard let message = snapShot.value as? String else{
				return
			}
			self?.messages.append(message)
		})
		
		DBRef?.observe(.childRemoved, with: {[weak self] snapShot in
			let key = snapShot.key
			guard let keyNumber = Int(key) else {
				return
			}
			self?.messages.remove(at: keyNumber)
		})	
	}
	
}

// MARK: - extension

extension FirstViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
}

extension FirstViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messages.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: selfMessageTableViewCell.identifier,
												 for: indexPath) as! SelfMessageTableViewCell
		cell.message = messages[indexPath.row]
		return cell
	}
	
}

