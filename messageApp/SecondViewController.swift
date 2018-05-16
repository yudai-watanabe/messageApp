//
//  SecondViewController.swift
//  messageApp
//
//  Created by watanabe-yudai on 2018/05/10.
//  Copyright © 2018年 watanabe-yudai. All rights reserved.
//

import UIKit
import IGListKit

class SecondViewController: UIViewController {
	
	@IBOutlet weak var navigationBar: UINavigationBar!
	@IBOutlet weak var collectionView: UICollectionView!
	
	let channelCell: ChannelCollectionViewCell = ChannelCollectionViewCell()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.dataSource = self
		let channelNib: UINib = UINib(nibName: channelCell.id, bundle: nil)
		collectionView.register(channelNib, forCellWithReuseIdentifier: channelCell.id)
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension SecondViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: channelCell.id,
															for: indexPath) as? ChannelCollectionViewCell
		let width: Int = Int((self.view.frame.width / 2) - 20)
		cell?.frame = CGRect(x: 0, y: 0, width: width, height: 150)
		return  cell!
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
}
