//
//  PostListTableViewCell.swift
//  UserListDemo
//
//  Created by Bishal Ram on 26/04/24.
//

import UIKit
import Stevia

class PostListTableViewCell: UITableViewCell {
        
        // MARK: // Computed Property
        var postModel: Post? {
            didSet {
                setupCell()
            }
        }
        
        // MARK: // UI Components
        private let postIDLabel: UILabel = {
            let label = UILabel()
            return label
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont.boldSystemFont(ofSize: 26)
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        // MARK: // Initializer
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViewLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: // Private MAethods
        private func setupViewLayout() {
            contentView.backgroundColor = .white
            
            contentView.subviews {
                postIDLabel
                titleLabel
                descriptionLabel
            }
            
            postIDLabel.Top == contentView.Top + Constants.verticalSpacing
            postIDLabel.Left == contentView.Left + Constants.leftMargin
            postIDLabel.Right == contentView.Right - Constants.horizontalSpacing
            
            titleLabel.Top == postIDLabel.Bottom + Constants.descriptionTopSpacing
            titleLabel.Leading == postIDLabel.Leading
            titleLabel.Trailing == postIDLabel.Trailing
            
            descriptionLabel.Top == titleLabel.Bottom + Constants.descriptionTopSpacing
            descriptionLabel.Leading == titleLabel.Leading
            descriptionLabel.Trailing == titleLabel.Trailing
            descriptionLabel.bottom(Constants.verticalSpacing)
        }
        
        private func setupCell() {
            guard let postModel = postModel else { return }
            postIDLabel.text = String(postModel.id)
            titleLabel.text = postModel.title
            descriptionLabel.text = postModel.body
        }
        
        // MARK: // Constants
        private enum Constants {
            //Dimensions:
            static let verticalSpacing: CGFloat = 20
            static let descriptionTopSpacing: CGFloat = 8
            static let descriptionBottomSpacing: CGFloat = 12
            static let leftMargin: CGFloat = 8
            static let horizontalSpacing: CGFloat = 8
            static let imageViewHeight: CGFloat = 164
        }
    }
