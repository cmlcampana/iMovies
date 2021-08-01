//
//  MovieDetailView.swift
//  iMovie
//
//  Created by Camila Campana on 01/08/21.
//

import UIKit
import Kingfisher

final class MovieDetailView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var releaseDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var rating: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var overview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [movieTitle, releaseDate, rating, overview])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(with movie: Movie) {
        movieTitle.text = movie.title
        releaseDate.text = "Release date: \(movie.releaseDate?.formatDate() ?? "No available date")"
        rating.text = "Rating: \(movie.rating)"
        overview.text = movie.overview
        
        if let backdrop = movie.backdrop, !backdrop.isEmpty {
            imageView.kf.setImage(with: URL(string: "\(Environment.production.backdropBaseURL)\(backdrop)")!)
        }
    }
}

extension MovieDetailView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        imageView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor),
            $0.heightAnchor.constraint(equalToConstant: 250)
        ]}
        
        stackView.constraint {[
            $0.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]}
    }
    
    func additionalSetup() {
        self.backgroundColor = UIColor(red: 224/255, green: 193/255, blue: 247/255, alpha: 1)
    }
}
