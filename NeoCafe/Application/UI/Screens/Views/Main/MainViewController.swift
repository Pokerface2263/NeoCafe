//
//  MainViewController.swift
//  NeoCafe
//
//  Created by Pokerface on 04.06.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var popularProducts: [Product] = [Product(id: 24, title: "Шоколадные маффины", category: 2, imageURL: "https://res.cloudinary.com/neomedtech/image/upload/v1/media/products/%D0%BC%D0%B0%D1%84%D1%84%D0%B8%D0%BD%D1%8B_xbs9ox", quantity: 1, price: 235.00),
                                      Product(id: 25, title: "Улитка по бургундски", category: 2, imageURL: "https://res.cloudinary.com/neomedtech/image/upload/v1/media/products/-vinogradnye-ulitki-vinogradnye-ulitki-po-burgundski_1497358991_1_max_vn8qxv", quantity: 1, price: 250.00),
                                      Product(id: 26, title: "Бланкет из телятины", category: 2, imageURL: "https://res.cloudinary.com/neomedtech/image/upload/v1/media/products/blanquette-de-veau-parfumee-au-citron-601x601_lk8gai", quantity: 1, price: 280.00)]
    var promotions: [Promotion] = [Promotion(id: 1, title: "Свежая выпечка", promotionTitle: "Комбо Кофе+выпечка!", imageURL: "https://res.cloudinary.com/neomedtech/image/upload/v1/media/coffeshop/promotion/30419ab090fca9898364f54c7641bd96_1_g9ggod"),
    Promotion(id: 2, title: "Летние напитки", promotionTitle: "Акция 1+1=3", imageURL: "https://res.cloudinary.com/neomedtech/image/upload/v1/media/coffeshop/promotion/%D0%BB%D0%B5%D1%82%D0%BD%D0%B8%D0%B5_%D0%BA%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8_bmaned"),
    Promotion(id: 3, title: "Круассан", promotionTitle: "Комбо кофе+круассан!", imageURL: "https://res.cloudinary.com/neomedtech/image/upload/v1/media/coffeshop/promotion/%D0%9A%D0%BE%D1%84%D0%B5_%D1%81_%D0%BA%D1%80%D1%83%D0%B0%D1%81%D1%81%D0%B0%D0%BD%D0%BE%D0%BC_1200_bfcybj")]
    var branchList: [Branch] = [Branch(title: "ФМ Технопарк", imageURL: "https://res.cloudinary.com/neomedtech/image/upload/v1/media/coffeshop/branch/techno_park_ry91ad", address: "ул. Алматинская 123", startTime: "10:00", endTime: "22:00", status: "Открыто", latitude: 42.871927, longitude: 74.708494),
                                Branch(title: "Бишкек Парк", imageURL: "https://res.cloudinary.com/neomedtech/image/upload/v1/media/coffeshop/branch/bishkek_park_jwfuuk", address: "ул. Киевская 148", startTime: "10:00", endTime: "22:00", status: "Открыто", latitude: 42.871927, longitude: 74.708494),
                                Branch(title: "Гостиница Бишкек", imageURL: "https://res.cloudinary.com/neomedtech/image/upload/v1/media/coffeshop/branch/%D0%93%D0%BE%D1%81%D1%82%D0%B8%D0%BD%D0%B8%D1%86%D0%B0_%D0%91%D0%B8%D1%88%D0%BA%D0%B5%D0%BA_xaasjd", address: "ул. Орозбекова 110/1", startTime: "10:00", endTime: "22:00", status: "Открыто", latitude: 42.871927, longitude: 74.708494)]
    
    private var mainCollectionView: UICollectionView = {
       let layout = UICollectionViewLayout()
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionView.backgroundColor = .none
       collectionView.bounces = false
       collectionView.register(BonusCell.self, forCellWithReuseIdentifier: BonusCell.reuseIdentifier)
       collectionView.register(PopularProductCell.self, forCellWithReuseIdentifier: PopularProductCell.reuseIdentifier)
       collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: PromotionCell.reuseIdentifier)
       collectionView.register(BranchCell.self, forCellWithReuseIdentifier: BranchCell.reuseIdentifier)
       collectionView.register(SectionHeaderView.self,
                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                               withReuseIdentifier: SectionHeaderView.reuseIdentifier)
       return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
}

//MARK: - View private methods
private extension MainViewController {
    private func configureView() {
        view.backgroundColor = .white
        setupUI()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        let layout = createLayout()
        layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: "background")
        mainCollectionView.collectionViewLayout = layout
    }
}

//MARK: - Create Layout
private extension MainViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            
            guard let self else {return nil}
            switch sectionIndex {
            case 0:
                return self.createBonusSection()
            case 1:
                return self.createPopularProductsSection()
            case 2:
                return self.createPromotionsSection()
            case 3:
                return self.createBranchesSection()
            default:
                return nil
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem]) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }

    func createBonusSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.12))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: Constants.Values.mediumOffset, bottom: Constants.Values.bigOffset, trailing: Constants.Values.mediumOffset)
        
        return section
    }
    
    func createPopularProductsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.05))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        sectionBackgroundDecoration.contentInsets = .init(top: 0, leading: Constants.Values.mediumOffset, bottom: Constants.Values.mediumOffset, trailing: Constants.Values.mediumOffset)
        
        section.decorationItems = [sectionBackgroundDecoration]
        
        section.contentInsets = .init(top: Constants.Values.smallOffset, leading: Constants.Values.bigOffset, bottom: Constants.Values.mediumOffset, trailing: Constants.Values.bigOffset)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }

    
    func createPromotionsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: Constants.Values.smallOffset, bottom: 0, trailing: Constants.Values.smallOffset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .fractionalHeight(0.05))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: Constants.Values.mediumOffset, leading: Constants.Values.mediumOffset, bottom: Constants.Values.bigOffset, trailing: Constants.Values.mediumOffset)

        return section
    }
    
    func createBranchesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.21))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .fractionalHeight(0.05))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        sectionBackgroundDecoration.contentInsets = .init(top: 0, leading: Constants.Values.mediumOffset, bottom: 0, trailing: Constants.Values.mediumOffset)
        
        section.decorationItems = [sectionBackgroundDecoration]
        
        section.contentInsets = .init(top: Constants.Values.mediumOffset, leading: Constants.Values.bigOffset, bottom: 0, trailing: Constants.Values.bigOffset)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }

}

//MARK: - CollectionView delegate methods
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
}

//MARK: - CollectionView datasource methods
extension MainViewController: UICollectionViewDataSource {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return popularProducts.count
        case 2:
            return promotions.count
        case 3:
            return branchList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BonusCell.reuseIdentifier, for: indexPath) as! BonusCell
            cell.configure(with: 1990200)
            cell.layer.cornerRadius = 12
            cell.clipsToBounds = true
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularProductCell.reuseIdentifier, for: indexPath) as! PopularProductCell
            cell.configure(with: popularProducts[indexPath.item])
            cell.layer.cornerRadius = 16
            cell.clipsToBounds = true
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCell.reuseIdentifier, for: indexPath) as! PromotionCell
            cell.configure(with: promotions[indexPath.item], indexPath: indexPath.item)
            cell.layer.cornerRadius = 12
            cell.clipsToBounds = true
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BranchCell.reuseIdentifier, for: indexPath) as! BranchCell
            cell.configure(with: branchList[indexPath.item])
            cell.layer.cornerRadius = 12
            cell.clipsToBounds = true
            return cell
        default:
            fatalError("Unknown section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                                                                             for: indexPath) as! SectionHeaderView
            switch indexPath.section {
            case 1:
                headerView.configure(with: "Популярные", buttonHandler: {
                    print("Популярные")
                })
            case 2:
                headerView.configure(with: "Акции") {
                    print("Акции")
                }
            case 3:
                headerView.configure(with: "Наши филиалы") {
                    print("Наши филиалы")
                }
            default:
                return UICollectionReusableView()
            }
            return headerView
        }
        
        return UICollectionReusableView()
    }
}

//MARK: - Setup views and constraints methods
private extension MainViewController {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(mainCollectionView)
    }
    
    func setupConstraints() {
        mainCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
