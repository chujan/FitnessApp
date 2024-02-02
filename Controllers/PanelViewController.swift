//
//  PopoverViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 28/12/2023.
//



import UIKit
import PanModal


class PanelViewController: UIViewController {

    var exercise: [Exercises] = []
    var selectedCategory: String?

    private let selectWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Workout"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 10, trailing: 10)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), repeatingSubitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        return section
    }))

    private var combinedData: [Exercises] = []

    init(combinedData: [Exercises]) {
        self.combinedData = combinedData
        super.init(nibName: nil, bundle: nil)
        // Additional setup if needed
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
        print("Navigation Controller: \(String(describing: navigationController))")

        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationController?.delegate = self

        view.addSubview(collectionView)
        view.addSubview(selectWorkoutLabel)
        collectionView.register(PanelCollectionViewCell.self, forCellWithReuseIdentifier: PanelCollectionViewCell.identifier)

        selectWorkoutLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            selectWorkoutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            selectWorkoutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            selectWorkoutLabel.heightAnchor.constraint(equalToConstant: 20),

            collectionView.topAnchor.constraint(equalTo: selectWorkoutLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
}

extension PanelViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return combinedData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PanelCollectionViewCell.identifier, for: indexPath) as? PanelCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = combinedData[indexPath.row]
        cell.configure(viewModel: viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell at index \(indexPath.row) selected.")
        
        let selectedExercise = combinedData[indexPath.row]
        print("Selected exercise: \(selectedExercise)")
        
        // Instantiate HomeDetailViewController
        let destinationViewController = HomeDetailViewController(exercise: [selectedExercise], combinedData: [selectedExercise], selectedCategory: selectedCategory)
        
        // Set modal presentation style to full screen
        let navigationController = UINavigationController(rootViewController: destinationViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        // Add a back bar button item with an arrow to the destination view controller
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(dismissDetailViewController)
        )
        
        destinationViewController.navigationItem.leftBarButtonItem = backButton
        
        present(navigationController, animated: true, completion: nil)
    }

    @objc private func dismissDetailViewController() {
        dismiss(animated: true, completion: nil)
    }






}

extension PanelViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(600)
    }
}
extension PanelViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Check if the shown view controller is the expected type
        if let homeDetailViewController = viewController as? HomeDetailViewController {
            // Do something with the shown view controller if needed
            print("Did show HomeDetailViewController")
        }
    }
}

