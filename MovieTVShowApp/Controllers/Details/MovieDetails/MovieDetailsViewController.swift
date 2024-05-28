//
//  MovieDetailsViewController.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit
import YouTubeiOSPlayerHelper

enum MovieDetailsSectionType: String, CaseIterable {
    case overview
    case cast
    case trailer
    
    var title: String {
        return rawValue.uppercased()
    }
}

struct MovieDetailsSection {
    let type: MovieDetailsSectionType
}

class MovieDetailsViewController: UITableViewController {
    
    private let networkService = NetworkService()
    private var movieDetails: MovieDetails?
    private var coordinator: Coordinator?
    var movieId: Int?
    
    private var movieDetailsSections: [MovieDetailsSection] = [
        .init(type: .overview),
        .init(type: .trailer),
        .init(type: .cast)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetails()
        registerCells()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return movieDetailsSections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieDetailsSections[section].type.title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = movieDetailsSections[indexPath.section]
        guard movieDetails != nil else {
            return UITableViewCell()
        }
        switch section.type {
        case .overview:
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//            cell.textLabel?.textColor = UIColor.systemGray
            cell.textLabel?.text = movieDetails?.tagline
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.detailTextLabel?.textColor = UIColor.systemGray
            cell.detailTextLabel?.text = movieDetails?.overview
            cell.detailTextLabel?.numberOfLines = 0
            return cell
        case.cast:
            let cell = UITableViewCell()
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.textLabel?.textColor = UIColor.systemGray
            cell.textLabel?.text = movieDetails?.actors
            cell.textLabel?.numberOfLines = 0
            return cell
        case .trailer:
            let cell = tableView.dequeue(TrailerDetailCell.self, forIndexPath: indexPath)
            if let videoKey = movieDetails?.videoKey {
                cell.youTubePlayer.load(withVideoId: videoKey)
            }
            return cell
        }
    }
    
    private func fetchMovieDetails() {
        guard let movieId = movieId else { return }
        networkService.getMovieDetails(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let movieDetails):
                self?.movieDetails = movieDetails
                self?.title = movieDetails.title
                self?.setupHeader()
                self?.tableView.reloadData()
            case .failure(let error):
                self?.coordinator?.showError(error)
            }
        }
    }
    
    private func setupHeader() {
        let headerSize = CGSize(width: view.frame.width, height: 300)
        let detailsHeaderView = DetailsHeaderView(frame: .init(origin: .zero, size: headerSize))
        if let movieDetails = movieDetails {
            detailsHeaderView.content = .movieDetails(movieDetails)
        }
        tableView.tableHeaderView = detailsHeaderView
    }
    
    private func registerCells() {
        tableView.registerFromNib(TrailerDetailCell.self)
    }
}

