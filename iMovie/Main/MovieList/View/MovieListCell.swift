//
//  MovieListCell.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import Foundation

final class MovieListCell: UITableViewCell, Reusable {
    private var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required convenience init?(coder aDecoder:NSCoder) {
        self.init(coder: aDecoder)
    }
    
    func configureCell(with movie: Movie) {
        title.text = movie.title
    }
}

extension MovieListCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(title)
    }
    
    func setupConstraints() {
        title.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func additionalSetup() {
        self.backgroundColor = UIColor.clear
        self.contentMode = .scaleToFill
    }
}
