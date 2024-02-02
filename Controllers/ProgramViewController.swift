//
//  ProgramViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 10/12/2023.
//

import UIKit



class ProgramViewController: UIViewController {
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in return ProgramViewController.createSectionLayout(section: sectionIndex)
        
    })
    
    var combinedData: [Exercises] = []
    private var filteredData: [Exercises] = []
    
    var selectedCategory: String?
    
    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.0 // Set the border width
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.backgroundColor = .systemGray5
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        if title == selectedCategory {
               button.backgroundColor = .green // Set the background color to green for the selected button
           }
        return button
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(collectionView)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        title = "Program"
        collectionView.register(NewWorkoutCollectionViewCell.self, forCellWithReuseIdentifier: NewWorkoutCollectionViewCell.identifier)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
        fetchData()
        let buttonCell = ButtonCollectionViewCell()
        buttonCell.configure(with: [
            createButton(title: "All Types", action: #selector(AlltypeButtonTapped)),
            createButton(title: "Shoulders", action: #selector(shoulderButtonTapped)),
            createButton(title: "Arms", action: #selector(armButtonTapped)),
            createButton(title: "Cardio", action: #selector(cardioButtonTapped)),
            createButton(title: "Chest", action: #selector(chestButtonTapped))
        ]) { selectedCategory in
            self.selectedCategory = selectedCategory
            self.updateUI()
            
        }
        
        
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
  
  
    
    @objc private func shoulderButtonTapped() {
        selectedCategory = "Shoulder"
        updateUI()
        
    }
    
    @objc private func armButtonTapped() {
        selectedCategory = "Arm"
        updateUI()
        
    }
    @objc private func AlltypeButtonTapped () {
        selectedCategory = "All types"
        updateUI()
        
    }
    @objc private func cardioButtonTapped () {
        selectedCategory = "Cardio"
        updateUI()
        
    }
    
    @objc private func chestButtonTapped () {
        selectedCategory = "Chest"
        updateUI()
        
    }
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        
        switch section {
        case 0:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(0.7))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 2, trailing: 2)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(55)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
            
            
            
            
            return section
            
        case 1:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 10, trailing: 10)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
            
            
            
            
            return section
        default:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), repeatingSubitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
    }
    
    
    
    
    
    private func fetchData() {
        APICaller.shared.fetchProgramms { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    
                    self?.combinedData = model.exercises
                    self?.collectionView.reloadData()
                    self?.updateUI()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateUI() {
        switch selectedCategory {
        case  "Shoulder":
            APICaller.shared.getShoulders { [weak self] result in
                self?.handleAPIResult(result)
                print(result)
            }
        case "Arm":
            APICaller.shared.getArms { [weak self] result in
                self?.handleAPIResult(result)
            }
            
        case "Cardio":
            APICaller.shared.getCardio { [weak self] result in
                self?.handleAPIResult(result)
            }
        case "Chest":
            APICaller.shared.getChest { [weak self] result in
                self?.handleAPIResult(result)
            }
            
        case "All types":
            APICaller.shared.getAlltypes { [weak self] result in
                self?.handleAPIResult(result)
            }
            
            
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    private func handleAPIResult(_ result: Result<ExerciseData, Error>) {
        switch result {
        case .success(let model):
            DispatchQueue.main.async {
                self.combinedData = model.exercises
                self.collectionView.reloadData()
                
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

   
extension ProgramViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return combinedData.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            // ButtonCollectionViewCell
            guard let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as? ButtonCollectionViewCell else {
                fatalError("Unable to dequeue ButtonCollectionViewCell")
            }
            buttonCell.configure(with: [
                createButton(title: "All Types", action: #selector(AlltypeButtonTapped)),
                createButton(title: "Shoulders", action: #selector(shoulderButtonTapped)),
                createButton(title: "Arms", action: #selector(armButtonTapped)),
                createButton(title: "Cardio", action: #selector(cardioButtonTapped)),
                createButton(title: "Chest", action: #selector(chestButtonTapped))
            ]) { selectedCategory in
                self.selectedCategory = selectedCategory
                self.updateUI()
            }
            return buttonCell
        case 1:
            // NewWorkoutCollectionViewCell
            guard let workoutCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewWorkoutCollectionViewCell.identifier, for: indexPath) as? NewWorkoutCollectionViewCell else {
                fatalError("Unable to dequeue NewWorkoutCollectionViewCell")
            }
            let data = combinedData[indexPath.item]
            // Configure your NewWorkoutCollectionViewCell with the data
            workoutCell.configure(viewModel: data)
            return workoutCell
            
        default:
            fatalError("Invalid section")
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectExercises = combinedData[indexPath.item]
       
        navigateToExerciseDetails(exercise: selectExercises, combinedData: selectExercises)
      
    }
    private func navigateToExerciseDetails(exercise: Exercises, combinedData: Exercises) {
        let exerciseDetailsViewController = HomeDetailViewController(exercise: [exercise], combinedData: [combinedData], selectedCategory: selectedCategory)

            
              navigationController?.pushViewController(exerciseDetailsViewController, animated: true)
              navigationItem.largeTitleDisplayMode = .never
             
      
        }
}
    


