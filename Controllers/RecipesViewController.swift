//
//  RecipesViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 27/01/2024.
//

import UIKit

class RecipesViewController: UIViewController {
    var selectedFood: [Food]? = []
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
           let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
           
           item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
           
           let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)), subitems: [item])
           let section = NSCollectionLayoutSection(group: group)
           return section
           
       }))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(RecipiesCollectionViewCell.self, forCellWithReuseIdentifier: RecipiesCollectionViewCell.idenifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        if let selectedFood = selectedFood {
            for foodItem in selectedFood {
                print("Food Name: \(foodItem.name)")
                print("Description: \(foodItem.description)")
                // ... other properties
            }
            collectionView.reloadData()
        }
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    
    
}

extension RecipesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedFood?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipiesCollectionViewCell.idenifier, for: indexPath) as? RecipiesCollectionViewCell else {
            fatalError("Unable to dequeue RecipiesCollectionViewCell")
        }

        // Assuming selectedFood is an array of Food objects
        if let selectedFood = selectedFood {
            let foodItem = selectedFood[indexPath.item]
            cell.configure(viewmodel: foodItem)
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedFood = selectedFood, indexPath.item < selectedFood.count else {
            return
        }

        let selectedFoodItem = [selectedFood[indexPath.item]]  // Wrap it in an array

        let instructionViewController = InstructionViewController()
        instructionViewController.selectedFoodItem = selectedFoodItem

        // Present InstructionViewController
        presentPanModal(instructionViewController)
    }

   }
    
    


