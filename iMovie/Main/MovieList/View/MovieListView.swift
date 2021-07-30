//
//  MovieListView.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import SnapKit
import Foundation

final class MovieListView: UIView {
    private var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
       
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView(dataSource: UITableViewDataSource,
                       delegate: UITableViewDelegate) {
        self.tableView.register(cellType: MovieListCell.self)
        
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
        self.tableView.separatorStyle = .none
    }
    
    func  reloadTableView() {
        tableView.reloadData()
    }
}

extension MovieListView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
