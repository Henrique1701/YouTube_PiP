//
//  ViewController.swift
//  YouTubePiP
//
//  Created by José Henrique Fernandes Silva on 09/02/22.
//

import UIKit
import youtube_ios_player_helper

class ViewController: UIViewController {
    
    // MARK: - UI
    private lazy var loadVideoButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .borderedProminent()
        button.setTitle("carregar vídeo", for: .normal)
        let loadVideoAction = UIAction(handler: { [weak self] _ in
            self?.tappedLoadVideoButton()
        })
        button.addAction(loadVideoAction, for: .touchUpInside)
        return button
    }()
    
    private lazy var playerView: YTPlayerView = {
        let playerView = YTPlayerView(frame: .zero)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.load(withVideoId: "5qap5aO4i9A")
        return playerView
    }()
    
    private lazy var startPipButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .borderedProminent()
        button.setTitle("iniciar pip", for: .normal)
        let startPipAction = UIAction(handler: { [weak self] _ in
            self?.tappedStartPipButton()
        })
        button.addAction(startPipAction, for: .touchUpInside)
        return button
    }()

    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchyView()
        setupConstraints()
    }

    // MARK: - PRIVATE FUNCTIONS
    private func setupHierarchyView() {
        view.addSubview(playerView)
        view.addSubview(startPipButton)
        view.addSubview(loadVideoButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            playerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerView.heightAnchor.constraint(equalToConstant: view.bounds.width),
            
            loadVideoButton.bottomAnchor.constraint(equalTo: playerView.topAnchor, constant: -32),
            loadVideoButton.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 16),
            loadVideoButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -16),
            
            startPipButton.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 32),
            startPipButton.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 16),
            startPipButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -16),
        ])
    }
    
    private func tappedStartPipButton() {
        playerView.pictureInPicture()
    }
    
    private func tappedLoadVideoButton() {
        showAlertView()
    }
    
    private func showAlertView() {
        let alert = UIAlertController(title: "Carregar Vídeo", message: "Copie e cole o link para o vídeo do YouTube que você deseja assistir", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let alertButton = UIAlertAction(title: "carregar", style: .default) { [weak self] _ in
            guard let self = self,
                  let textFields = alert.textFields,
                  let link = textFields[0].text,
                  let videoId = self.getVideoIdFrom(link) else { return }
            self.loadVideoFromId(videoId)
        }
        
        alert.addAction(alertButton)
        present(alert, animated: true, completion: nil)
    }
    
    private func loadVideoFromId(_ id: String) {
        playerView.load(withVideoId: id, playerVars: ["autoplay" : 1, "playsinline" : 1])
    }
    
    private func getVideoIdFrom(_ link: String) -> String? {
        if link.contains("www.youtube.com/embed/") || link.contains("youtu.be/") {
            let linkComponents = link.components(separatedBy: "/")
            return linkComponents.last
        } else if link.contains("www.youtube.com/watch?v=") {
            let linkComponents = link.components(separatedBy: "=")
            return linkComponents.last
        }
        return nil
    }

}

