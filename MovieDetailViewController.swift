//
//  MovieDetailViewController.swift
//  iMovie
//
//  Created by Camila Campana on 22/02/21.
//
import UIKit

protocol MovieDetailDisplaying: AnyObject { }

final class MovieDetailViewController: UIViewController {

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

    private let viewModel: MovieDetailViewModeling
}

extension MovieDetailViewController:MovieDetailDisplaying{ }