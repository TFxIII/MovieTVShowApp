//
//  TVShowDetailsViewController.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 10.04.2024.
//

import UIKit
import YouTubeiOSPlayerHelper

enum TVShowDetailsSectionType: String, CaseIterable {
    case overview
    case trailer
    
    var title: String {
        return rawValue.uppercased()
    }
}

struct TVShowDetailsSection {
    let type: TVShowDetailsSectionType
}

class TVShowDetailsViewController: UITableViewController {
    
    private let networkService = NetworkService()
    private var tvShowDetails: TVShowDetails?
    private var coordinator: Coordinator?
    var tvShowId: Int?
      
    private var tvShowDetailsSections: [TVShowDetailsSection] = [
        .init(type: .overview),
        .init(type: .trailer)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTVShowDetails()
        setupHeader()
        registerCells()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tvShowDetailsSections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tvShowDetailsSections[section].type.title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = tvShowDetailsSections[indexPath.section]
        guard let tvShow = tvShowDetails else {
            return UITableViewCell()
        }
        switch section.type {
        case .overview:
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = tvShowDetails?.tagline
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.text = tvShowDetails?.overview
            cell.detailTextLabel?.numberOfLines = 0
            return cell
        case .trailer:
            let cell = tableView.dequeue(TrailerDetailCell.self, forIndexPath: indexPath)
            if let videoKey = tvShowDetails?.videoKey {
                cell.youTubePlayer.load(withVideoId: videoKey)
            }
            return cell
        }
    }
    
    private func fetchTVShowDetails() {
        guard let tvShowId = tvShowId else { return }
        networkService.getTVShowDetails(tvShowId: tvShowId) { [weak self] result in
                switch result {
                case .success(let tvShowDetails):
                    self?.tvShowDetails = tvShowDetails
                    self?.title = tvShowDetails.title
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
        let roundedVoteAverage = String(format: "%.1f", tvShowDetails?.voteAverage ?? "...")
        
        detailsHeaderView.posterImageView.load(path: tvShowDetails?.backdropPath)
        
        detailsHeaderView.realeaseDateLabel.text = "First Air Date: \(tvShowDetails?.firstAirDate ?? "...")"
        
        detailsHeaderView.voteCountImageView.image = UIImage(systemName: "person.fill")
        detailsHeaderView.voteCountImageView.tintColor = .systemBlue
        
        detailsHeaderView.voteCountLabel.text = "\(tvShowDetails?.voteCount ?? 0)"
        
        detailsHeaderView.voteIconImageView.image = UIImage(systemName: "star.fill")
        detailsHeaderView.voteIconImageView.tintColor = .systemOrange
        detailsHeaderView.voteAverageLabel.text = roundedVoteAverage
        
        tableView.tableHeaderView = detailsHeaderView
    }
    
    private func registerCells() {
        tableView.registerFromNib(TrailerDetailCell.self)
    }
}


