//
//  MovieListCell.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import Kingfisher
import Foundation

final class MovieListCell: UITableViewCell, Reusable {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private var posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var rateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    private var releaseDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required convenience init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with movie: Movie) {
        title.text = movie.title
        rateLabel.text = "Rate: \(movie.rating)"
        releaseDate.text = "Release date: \(movie.releaseDate?.formatDate() ?? "No available date")"
        
        if let posterPath = movie.posterPath, !posterPath.isEmpty {
            posterImage.kf.setImage(with: URL(string: "\(Environment.production.posterBaseURL)\(posterPath)")!)
        }
    }
    
    override func prepareForReuse() {
        title.text = ""
        rateLabel.text = ""
        releaseDate.text = ""
    }
}

extension MovieListCell: ViewConfiguration {
    func buildViewHierarchy() {
        containerView.addSubview(posterImage)
        containerView.addSubview(title)
        containerView.addSubview(rateLabel)
        containerView.addSubview(releaseDate)
        
        contentView.addSubview(containerView)
    }
    
    func setupConstraints() {
        containerView.constraint {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ]}
        
        posterImage.constraint {[
            $0.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            $0.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            $0.widthAnchor.constraint(equalToConstant: 120),
            $0.heightAnchor.constraint(equalToConstant: 160)
        ]}
        
        title.constraint {[
            $0.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            $0.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 8),
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ]}
        
        releaseDate.constraint {[
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            $0.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 8),
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ]}
        
        rateLabel.constraint {[
            $0.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 8),
            $0.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 8),
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ]}
    }
    
    func additionalSetup() {
        self.backgroundColor = UIColor(red: 224/255, green: 193/255, blue: 247/255, alpha: 1)
    }
}
