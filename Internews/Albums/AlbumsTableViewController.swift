//
//  AlbumsTableViewController.swift
//  Internews
//
//  Created by Evgeny Yagrushkin on 2020-12-01.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    let networkManager: NetworkManagerProtocol
    private var albums = [Album]()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        reloadData()
    }

    private func setupView() {
        title = "Albums"
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.cellIdentifier)
    }
    
    private func reloadData() {
        networkManager.getAlbums() { albums, error in
            DispatchQueue.main.async {
                self.albums = albums
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.cellIdentifier, for: indexPath)
        
        guard indexPath.row < albums.count else {
            return cell
        }
        
        cell.textLabel?.text = albums[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < albums.count else {
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)

        let albumId = albums[indexPath.row].id
        let layout = PhotosFlowLayout()
        let photoViewController = PhotosCollectionViewController(collectionViewLayout: layout, albumId: albumId, networkManager: networkManager)
        navigationController?.pushViewController(photoViewController, animated: true)
    }
    
}
