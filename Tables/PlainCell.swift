//
//  PlainCell.swift
//  Tables
//
//  Created by Ulrik Damm on 05/11/2015.
//  Copyright © 2015 Ufd.dk. All rights reserved.
//

import UIKit

public class TablesPlainCell : UITableViewCell, DeclarativeCell {
	lazy var spinner = UIActivityIndicatorView()
	
	public var cellType : CellType? {
		didSet {
			if let cellType = cellType {
				textLabel?.text = cellType.title
			}
			
			if cellType is DetailsCellType {
				accessoryType = .DisclosureIndicator
			}
			
			if let cellType = cellType as? SubtitleCellType {
				detailTextLabel?.text = cellType.subtitle
			}
			
			if let cellType = cellType as? SpinnerCellType where cellType.spinning {
				accessoryView = spinner
				spinner.startAnimating()
			} else {
				accessoryView = nil
			}
            
            if let cellType = cellType as? ImageCellType {
                imageView?.image = cellType.image
            } else {
                imageView?.image = nil
            }
		}
	}
}

public class TablesButtonCell : UITableViewCell, DeclarativeCell {
	lazy var spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
	
	override init(style : UITableViewCellStyle, reuseIdentifier : String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}
	
	required public init?(coder : NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	func setup() {
		textLabel?.textAlignment = .Center
		textLabel?.textColor = tintColor
	}
	
	public var cellType : CellType? {
		didSet {
			if let cellType = cellType as? ButtonCell {
				textLabel?.text = cellType.title
			}
			
			if let cellType = cellType as? SpinnerCellType where cellType.spinning {
				contentView.addSubview(spinner)
				contentView.addConstraint(NSLayoutConstraint(item: spinner, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: 0))
				contentView.addConstraint(NSLayoutConstraint(item: spinner, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))
				spinner.translatesAutoresizingMaskIntoConstraints = false
				spinner.startAnimating()
				textLabel?.hidden = true
			} else {
				spinner.removeFromSuperview()
				textLabel?.hidden = false
			}
		}
	}
	
	public override func tintColorDidChange() {
		super.tintColorDidChange()
		
		if cellType is ButtonCell {
			textLabel?.textColor = tintColor
		}
	}
}
