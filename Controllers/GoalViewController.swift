//
//  GoalViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 19/01/2024.
//

import UIKit

class GoalViewController: UIViewController {
    var nutrition: [Nutrition] = []
    var vegeterian: [Nutrition] = []
    var noMilk: [Nutrition] = []
    var Dessert: [Nutrition] = []
    var keto: [Nutrition] = []
    var dessertsugar: [Nutrition] = []

    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in return GoalViewController.createSectionLayout(section: sectionIndex)
        
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        title = "Nutrition"
       
        
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DesertsWithoutSugarCollectionViewCell.self, forCellWithReuseIdentifier: DesertsWithoutSugarCollectionViewCell.identifier)
        collectionView.register(KetoCollectionViewCell.self, forCellWithReuseIdentifier: KetoCollectionViewCell.identifier)
        collectionView.register(DessertsCollectionViewCell.self, forCellWithReuseIdentifier: DessertsCollectionViewCell.identifier)
        collectionView.register(WithoutMilkCollectionViewCell.self, forCellWithReuseIdentifier: WithoutMilkCollectionViewCell.identifier)
        collectionView.register(UniversalCollectionViewCell.self, forCellWithReuseIdentifier: UniversalCollectionViewCell.identifier)
        collectionView.register(VegetarianCollectionViewCell.self, forCellWithReuseIdentifier: VegetarianCollectionViewCell.identifier)
        
    }
    override  func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }
    
    
    private func fetchData() {
        APICaller.shared.getUniversal { [weak self] result in
            switch result {
            case.success(let nutritionData):
                DispatchQueue.main.async {
                self?.nutrition = nutritionData.nutrition
                    self?.collectionView.reloadData()
                    print("Raw JSON Data: \(nutritionData)")
                   // print("Fetched data successfully. Number of nutrition items: \(self?.nutrition.count ?? 0)")
                }
               
               
            case.failure(let error):
                print("Error fetching universal data: \(error)")
            }
        }
        
        APICaller.shared.getVegetarian { [weak self] result in
            switch result {
            case.success(let veg):
                DispatchQueue.main.async {
                    self?.vegeterian = veg.nutrition
                    self?.collectionView.reloadData()
                
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        APICaller.shared.getDessertsWithoutSugar { [weak self] result in
            switch result {
            case .success(let dessert):
                DispatchQueue.main.async {
                    print("Raw API Response: \(dessert)")
                    self?.dessertsugar = dessert.nutrition
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching desserts without sugar data: \(error)")
                if let underlyingError = (error as NSError).userInfo[NSUnderlyingErrorKey] as? Error {
                    print("Underlying error: \(underlyingError)")
                }
            }
        }


        APICaller.shared.getKeto { [weak self] result in
            switch result {
            case.success(let keto):
                DispatchQueue.main.async {
                    self?.keto = keto.nutrition
                    self?.collectionView.reloadData()
                    print(keto.nutrition)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        APICaller.shared.getDessert { [weak self] result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.Dessert = model.nutrition
                    self?.collectionView.reloadData()
                    print(model.nutrition)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        APICaller.shared.getNoMilk { [weak self] result in
            switch result {
            case.success(let milk):
                DispatchQueue.main.async {
                    self?.noMilk = milk.nutrition
                    self?.collectionView.reloadData()
                    print(milk.nutrition)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
   
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        case 1:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        case 2:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        case 3:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        case 4:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        case 5:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
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
  
extension GoalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return nutrition.count
        case 1:
            return vegeterian.count
        case 2:
            return dessertsugar.count
        case 3:
            return keto.count
        case 4:
            return Dessert.count
        case 5:
            return noMilk.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversalCollectionViewCell.identifier, for: indexPath) as? UniversalCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = nutrition[indexPath.row]
            cell.configure(viewModel: viewModel)
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VegetarianCollectionViewCell.identifier, for: indexPath) as? VegetarianCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = vegeterian[indexPath.row]
            cell.configure(vege: viewModel)
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DesertsWithoutSugarCollectionViewCell.identifier, for: indexPath) as? DesertsWithoutSugarCollectionViewCell else {
                return UICollectionViewCell()
            }
            let dessert = dessertsugar[indexPath.row]
            cell.configure(viewModel: dessert)
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KetoCollectionViewCell.identifier, for: indexPath) as? KetoCollectionViewCell else {
                return UICollectionViewCell()
            }
            let keto = keto[indexPath.row]
            cell.configure(viewModel: keto)
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DessertsCollectionViewCell.identifier, for: indexPath) as? DessertsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = Dessert[indexPath.row]
            cell.configure(viewModel: viewModel)
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WithoutMilkCollectionViewCell.identifier, for: indexPath) as? WithoutMilkCollectionViewCell else {
                return UICollectionViewCell()
            }
            let milk = noMilk[indexPath.row]
            cell.configure(viewModel: milk)
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
      
            
       
            
       
            
      
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = RecipesViewController()
        var selectedFood: [Nutrition] = []
        let section  = indexPath.section
        switch section {
        case 0:
            selectedFood = [nutrition[indexPath.row]]
        case 1:
            selectedFood = [vegeterian[indexPath.row]]
        case 2:
            selectedFood = [dessertsugar[indexPath.row]]
        case 3:
            selectedFood = [keto[indexPath.row]]
        case 4:
            selectedFood = [Dessert[indexPath.row]]
        case 5:
            selectedFood = [noMilk[indexPath.row]]
        default:
            break
        }
        vc.selectedFood = selectedFood.first?.foods
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black] // Example color, adjust as needed
                
       
    }


    
    
}
