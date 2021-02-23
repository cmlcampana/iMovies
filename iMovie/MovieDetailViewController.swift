//
//  MovieDetailViewController.swift
//  iMovie
//
//  Created by Camila Campana on 23/02/21.
//
import UIKit

protocol MovieDetailDisplaying: AnyObject { }

final class MovieDetailViewController: UIViewController {
    private let viewModel: MovieDetailViewModeling

    init(with viewModel: MovieDetailViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension MovieDetailViewController: MovieDetailDisplaying { }