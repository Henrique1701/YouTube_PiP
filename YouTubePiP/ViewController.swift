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
        button.setTitle("start pip", for: .normal)
        let startPipAction = UIAction(handler: { [weak self] _ in
            self?.playerView.pictureInPicture()
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
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            playerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerView.heightAnchor.constraint(equalToConstant: view.bounds.width),
            
            startPipButton.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 32),
            startPipButton.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 16),
            startPipButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -16),
        ])
    }

}

