//
//  MovieListViewController.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import Lottie
import Foundation

protocol MovieListDisplaying: AnyObject {
    func showLoading(_ isLoading: Bool)
    func showError(with error: NetworkError)
    func fillMovieList(with movies: [Movie])
}

final class MovieListViewController: UIViewController {
    
    private let viewModel: MovieListViewModeling
    private var animationView: AnimationView?
    private var isLoadingList = false
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        return refresh
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        return table
    }()
    
//    TODO - List of categories
//    private var categoryLabel = UITextField()
//    private var categoriesDropDown = UIPickerView()
//
//    var categories = ["Popular", "Now Playing", "Top Rated", "Upcoming"]
    
    private var movies: [Movie] = [Movie]() {
        didSet {
            tableView.reloadData()
            tableView.isHidden = false
        }
    }
    
    init(viewModel: MovieListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
        self.viewModel.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 224/255, green: 193/255, blue: 247/255, alpha: 1)
               
        setUpNavigation()
        
        buildViewHierarchy()
        setupConstraints()
        
        configureTableView()
        
        viewModel.getMovieList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLoading() {
        animationView = .init(name: "52795-loading-alone2")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        
        view.addSubview(animationView!)
        animationView!.play()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "iMovies"
        navigationController?.navigationBar.barTintColor = UIColor(red: 75/255, green: 0, blue: 130/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func configureTableView() {
        tableView.register(cellType: MovieListCell.self)
        tableView.backgroundColor = UIColor(red: 224/255, green: 193/255, blue: 247/255, alpha: 1)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
    }

    private func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.constraint {[
            $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]}
    }
    
    @objc private func refreshTable() {
        movies.removeAll()
        viewModel.currentPage = 0
        viewModel.getMovieList()
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieListCell.self)
        let currentLastItem = movies[indexPath.row]
        cell.configureCell(with: currentLastItem)
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        viewModel.openMovieDetail(movie: movie)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && !isLoadingList){
            isLoadingList = true
            viewModel.loadMoreMovies()
        }
    }
}

extension MovieListViewController: MovieListDisplaying {
    func showLoading(_ isLoading: Bool) {
        if isLoading {
            tableView.isHidden = true
            setUpLoading()
        } else {
            tableView.isHidden = false
            animationView?.stop()
            animationView?.removeFromSuperview()
        }
    }
    
    func showError(with error: NetworkError) {
        let alert = UIAlertController(
            title: "Error :(",
            message: "Error searcing movies: \(error.localizedDescription)",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func fillMovieList(with movies: [Movie]) {
        isLoadingList = false
        refreshControl.endRefreshing()
        
        self.movies.append(contentsOf: movies)
    }
}
