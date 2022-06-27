//
//  ViewController.swift
//  Photo HW14
//
//  Created by Sergey Kykhov on 27.06.2022.
//

import UIKit

class ViewController: UIViewController {
    private lazy var dataSource = createDiffableDataSource()
    var myAlbumsSection = [ScreenPhoto]()
    var peopleAndPlacesSection = [ScreenPhoto]()
    var mediaFileTypesSection = [ScreenPhoto]()
    var otherImageSection = [ScreenPhoto]()

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        title = "Альбомы"
        settingsCollectionView()
        createSections()
        applySnapshot()
    }

    private func settingsCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositialLayout())
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        collectionView.delegate = self
        collectionView.register(HeaderSections.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSections.identifier)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.identifier)
        view.addSubview(collectionView)

    }

    private func createSections() {
        myAlbumsSection.append(contentsOf:
                                createModel(images: ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo10", "photo11"],
                                            names: ["Недавние", "Избранное", "GoPro", "Природа", "Instagram", "WhatsApp", "Природа Дикая", "Деревня", "Велосипед", "Спорт", "Сноубординг"],
                                            count: [2878, 334, 598, 134, 433, 398, 45, 654, 65, 67, 84]))
        peopleAndPlacesSection.append(contentsOf:
                                        createModel(images: ["photo12", "photo13"],
                                                    names: ["Люди", "Места"],
                                                    count: [467, 5909]))

        mediaFileTypesSection.append(contentsOf:
                                        createModel(images: ["video", "person.crop.square", "circle.circle", "cube", "camera.viewfinder"],
                                                    names: ["Видео", "Селфи", "Фото Live Photos", "Портреты", "Снимки экрана"],
                                                    count: [61, 13, 81, 108, 373]))

        otherImageSection.append(contentsOf:
                                    createModel(images: ["square.and.arrow.down", "eye.slash", "trash"],
                                                names: ["Импортированные", "Скрытые", "Недавно удаленные"],
                                                count: [1, 0, 14]))
    }

    private func createModel(images: [String], names: [String], count: [Int]) -> [ScreenPhoto] {
        var models = [ScreenPhoto]()
        guard !images.isEmpty else { return models }
        for (index, name) in names.enumerated() {
            let model = ScreenPhoto(nameImage: images[index], nameFooter: name, imageCount: count[index])
            models.append(model)
        }
        return models
    }

    @objc private func addBarButtonTapped(_ sender: UIBarButtonItem) {
        print("Add tapped")
    }
}

extension ViewController {
    private func createCompositialLayout() ->  UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Section not found")
            }
            switch section {
            case .myAlbums:
                return self.createAlbumsSection()
            case .peopleAndPlaces:
                return self.createPeopleAndPlaces()
            case .mediaFileTypes:
                return self.createTypesOfFiles()
            case .otherImage:
                return self.createTypesOfFiles()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }

    private func createAlbumsSection() -> NSCollectionLayoutSection {
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)

        topItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.46), heightDimension: .fractionalWidth(1.2))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: topItem, count: 2)
        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = 0
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous

        let sectionHeader = createHeader()

        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    private func createPeopleAndPlaces() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let topItem = NSCollectionLayoutItem(layoutSize: itemSize)

        topItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92),
                                               heightDimension: .fractionalWidth(0.6))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: topItem, count: 2)
        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .paging

        let sectionHeader = createHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }

    private func createTypesOfFiles() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)

        let sectionHeader = createHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.contentInsets.leading = CGFloat(10)

        return sectionHeader
    }
}

extension ViewController {
    private func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Section, ScreenPhoto> {
        let dataSource = UICollectionViewDiffableDataSource<Section, ScreenPhoto>(collectionView: collectionView) { collectionView, indexPath, info in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("No section")
            }
            switch section {
            case .myAlbums:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
                cell.containerViewSettings(image: info.nameImage, nameFooter: info.nameFooter, imageCount: info.imageCount)
                return cell
            case .peopleAndPlaces:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
                cell.containerViewSettings(image: info.nameImage, nameFooter: info.nameFooter, imageCount: info.imageCount)
                return cell
            case .mediaFileTypes:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.identifier, for: indexPath) as! TextCell
                cell.containerViewSettings(image: info.nameImage, leftLabel: info.nameFooter, imageCount: info.imageCount)

                if indexPath.item == self.otherImageSection.count + 1 {
                    cell.lineGray.isHidden = true
                }

                return cell
            case .otherImage:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.identifier, for: indexPath) as! TextCell
                cell.containerViewSettings(image: info.nameImage, leftLabel: info.nameFooter, imageCount: info.imageCount)

                if indexPath.item == self.otherImageSection.count + 1 {
                    cell.lineGray.isHidden = true
                }
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSections.identifier, for: indexPath) as? HeaderSections else { fatalError("can't create new section header")}
            guard let section = Section(rawValue: indexPath.section) else { fatalError("No section kind") }
            sectionHeader.containerViewSettings(text: section.createHeaderSection(), textColor: .black, font: .systemFont(ofSize: 24, weight: .bold))
            return sectionHeader
        }

        return dataSource
    }

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ScreenPhoto>()
        snapshot.appendSections([.myAlbums, .peopleAndPlaces, .mediaFileTypes, .otherImage])
        snapshot.appendItems(myAlbumsSection, toSection: .myAlbums)
        snapshot.appendItems(peopleAndPlacesSection, toSection: .peopleAndPlaces)
        snapshot.appendItems(mediaFileTypesSection, toSection: .mediaFileTypes)
        snapshot.appendItems(otherImageSection, toSection: .otherImage)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("No section")
        }
        collectionView.deselectItem(at: indexPath, animated: true)
        switch section {
        case .myAlbums:
            let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
            print(cell.nameFooter.text!)
        case .peopleAndPlaces:
            let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
            print(cell.nameFooter.text!)
        case .mediaFileTypes:
            let cell = collectionView.cellForItem(at: indexPath) as! TextCell
            print(cell.leftLabel.text!)
        case .otherImage:
            let cell = collectionView.cellForItem(at: indexPath) as! TextCell
            print(cell.leftLabel.text!)
        }
    }
}
