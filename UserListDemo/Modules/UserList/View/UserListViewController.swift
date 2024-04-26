//
//  UserListViewController.swift
//  UserListDemo
//
//  Created by Bishal Ram on 26/04/24.
//

import UIKit
import Stevia
import RxSwift
import RxCocoa

class UserListViewController: UIViewController {
    
    // MARK: // Properties
    private var viewModel: UserListViewModelProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: // UI-Components
    private lazy var postListTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(PostListTableViewCell.self, forCellReuseIdentifier: "\(PostListTableViewCell.self)")
        tableview.estimatedRowHeight = 42.0
        tableview.separatorStyle = .none
        tableview.delegate = self
        tableview.rowHeight = UITableView.automaticDimension
        return tableview
    }()
    
    
    // MARK: // Initialization
    init(viewModel: UserListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: // LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
        addBindings()
        viewModel.fetchPosts(page: viewModel.currentPage)
    }
    
    // MARK: // Private Methods
    private func setupViewLayout() {
        view.backgroundColor = .white
        
        view.subviews {
            postListTableView
        }
        
        postListTableView.fillContainer()
    }
    
    private func addBindings() {
        viewModel.dataSource
            .bind(to: postListTableView.rx.items(cellIdentifier: "\(PostListTableViewCell.self)", cellType: PostListTableViewCell.self)) { [weak self] row, element, cell in
                cell.postModel = element
            }.disposed(by: disposeBag)
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            viewModel.currentPage += 1
            viewModel.fetchPosts(page: viewModel.currentPage)
        }
    }
}
