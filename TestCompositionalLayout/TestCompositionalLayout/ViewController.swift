//
//  ViewController.swift
//  TestCompositionalLayout
//
//  Created by RoyLi on 2022/3/14.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TestCollectionViewCell.self))
        collectionView.register(TestCollectionViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TestCollectionViewSectionHeader.self))
        collectionView.register(TestCollectionViewCellHeader.self, forSupplementaryViewOfKind: TestCollectionViewCellHeader.elementKind, withReuseIdentifier: String(describing: TestCollectionViewCellHeader.self))
        collectionView.register(TestBadgeView.self, forSupplementaryViewOfKind: TestBadgeView.elementKind, withReuseIdentifier: TestBadgeView.reuseID)
        return collectionView
    }()
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(5.0))
        let containerAnchor = NSCollectionLayoutAnchor(edges: [.bottom], absoluteOffset: CGPoint(x: 0.0, y: 5.0))
        let itemHeaderItem = NSCollectionLayoutSupplementaryItem(layoutSize: itemHeaderSize, elementKind: TestCollectionViewCellHeader.elementKind, containerAnchor: containerAnchor)
        
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(15.0), heightDimension: .absolute(15.0))
        let badgeContainterAnchor = NSCollectionLayoutAnchor(edges: [.leading, .top], absoluteOffset: CGPoint(x: -5.0, y: -5.0))
        let badgeItem = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: TestBadgeView.elementKind, containerAnchor: badgeContainterAnchor)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [itemHeaderItem, badgeItem])
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(360.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(15.0)
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40.0))
        let sectionHeaderItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [sectionHeaderItem]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        layout.configuration = config
        
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureConstraints()
    }

    private func configureConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ViewController: UICollectionViewDelegate {}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: TestCollectionViewSectionHeader.self), for: indexPath)
            return headerView
        case TestCollectionViewCellHeader.elementKind:
            let itemHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: TestCollectionViewCellHeader.self), for: indexPath)
            return itemHeaderView
        case TestBadgeView.elementKind:
            let badgeView = collectionView.dequeueReusableSupplementaryView(ofKind: TestBadgeView.elementKind, withReuseIdentifier: TestBadgeView.reuseID, for: indexPath)
            return badgeView
        default:
            fatalError("Invalid element of kind.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TestCollectionViewCell.self), for: indexPath) as? TestCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.message = "到底會不會正常？"
        return cell
    }
}

class TestCollectionViewSectionHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .red
    }
}

class TestCollectionViewCellHeader: UICollectionReusableView {
    
    static var elementKind: String {
        String(describing: TestCollectionViewCellHeader.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .green
    }
}

class TestCollectionViewCell: UICollectionViewCell {
    
    var message: String? {
        didSet {
            label.text = message
        }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .gray
    }
    
    private func configureConstraints() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class TestBadgeView: UICollectionReusableView {
    
    static var elementKind: String {
        String(describing: TestBadgeView.self)
    }
    
    static var reuseID: String {
        String(describing: TestBadgeView.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .blue
    }
}
