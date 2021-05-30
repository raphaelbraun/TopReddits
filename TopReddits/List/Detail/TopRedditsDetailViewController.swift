//
//  TopRedditsDetailDetailViewController.swift
//  TopRedditsDetail
//
//  Created by Raphael Braun on 30/05/21.
//

import UIKit

final class TopRedditsDetailViewController: UIViewController {
  private(set) lazy var baseView: TopRedditsDetailView = {
    let view = TopRedditsDetailView()
    return view
  }()
  let viewModel: TopRedditsDetailViewModelProtocol

  init(viewModel: TopRedditsDetailViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: .main)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life Cycle

  override func loadView() {
    super.loadView()

    view = baseView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupBinds()
  }

  private func setupBinds() {
    title = viewModel.navigationTitle

    baseView.redditImageView.loadThumbnail(from: viewModel.reddit.url)
    baseView.titleLabel.text = viewModel.reddit.title
    baseView.postDataStackView.configView(viewModel.reddit)
    baseView.awardsStackView.configView(viewModel.reddit.allAwardings)
    baseView.saveRedditButton.addTarget(self, action: #selector(saveReddit), for: .touchUpInside)
  }

  @objc func saveReddit() {
    guard let image = baseView.redditImageView.image else { return }
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }

  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    viewModel.saveToLibrary(error: error)
  }
}
