//
//  InstructionViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 30/01/2024.
//

import UIKit
import PanModal

class InstructionViewController: UIViewController {
    var selectedFoodItem: [Food]?
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in return InstructionViewController.createSectionLayout(section: sectionIndex)
        
    })
        
        
  

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        collectionView.register(InstructionCollectionViewCell.self, forCellWithReuseIdentifier: InstructionCollectionViewCell.identifier)
        collectionView.register(IngredientCollectionViewCell.self, forCellWithReuseIdentifier: IngredientCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        if let selectedFood = selectedFoodItem {
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
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
            
            
            
            
            return section
        case 1:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                  item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                  let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7)), subitems: [item])
                  let section = NSCollectionLayoutSection(group: group)
                  item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                  
                  return section
                  
        default:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), repeatingSubitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryViews
            
            return section
        }
            
        }
    

   
}

extension InstructionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return selectedFoodItem?.count ?? 0
        case 1:
            return selectedFoodItem?.count ?? 0
            

            
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
           case 0:
               // Dequeue your custom cell for the first section
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstructionCollectionViewCell.identifier, for: indexPath) as? InstructionCollectionViewCell else {
                   return UICollectionViewCell()
               }
            if let selectedFood = selectedFoodItem {
                let foodItem = selectedFood[indexPath.item]
                cell.configure(viewModel: foodItem)
            }
               return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.identifier, for: indexPath) as? IngredientCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let selectedFood = selectedFoodItem {
                let foodItem = selectedFood[indexPath.item]
                cell.configure(viewModel: foodItem)
            }
               return cell
            

           default:
               // For other sections, you can use a generic cell or customize as needed
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
               cell.backgroundColor = .red
               return cell
           }
    }
    
    
}

extension InstructionViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(700)
    }
}
