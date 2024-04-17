//
//  MovieDetailsViewController.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

//import UIKit
//
//class DetailsViewController: UIViewController {
//    @IBOutlet weak var posterImageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var subtitleLabel: UILabel!
//    
//    var movie: Movie?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        showMovieData()
//    }
//    
//    private func showMovieData() {
//        guard let movie = movie else { return }
//        
//        title = movie.title
//        posterImageView.load(path: movie.posterPath)
//        titleLabel.text = movie.originalTitle
//        subtitleLabel.text = movie.overview
//    }
//}

import UIKit

struct MovieDetailsSection {
    let type: MovieDetailsSectionType
//    let items: [ProfileCellType]
}

class MCVMovieDetailsViewController: UITableViewController {
    
    var movie: Movie?
    
    private var movieDetailsSections: [MovieDetailsSection] = [
        .init(type: .overview),
        .init(type: .cast),
        .init(type: .trailer)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
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
        switch section.type {
        case .overview:
            let cell = UITableViewCell()
            cell.textLabel?.text = movie?.overview
            cell.textLabel?.numberOfLines = 0
            return cell
        case .cast:
            let cell = tableView.dequeue(CastDetailCell.self, forIndexPath: indexPath)
            cell.setupCell()
            return cell
        case .trailer:
            let cell = tableView.dequeue(CastDetailCell.self, forIndexPath: indexPath)
            cell.setupCell()
            return cell
        }
    }
    
    private func setupHeader() {
        let headerSize = CGSize(width: view.frame.width, height: 250)
        let detailsHeaderView = DetailsHeaderView(frame: .init(origin: .zero, size: headerSize))
        tableView.tableHeaderView = detailsHeaderView
    }
    
    private func registerCells() {
        tableView.registerFromNib(CastDetailCell.self)
//        tableView.registerFromNib(ConnectTableViewCell.self)
    }
}

