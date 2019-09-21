//
//  CollectionView.swift
//  OrderNow
//
//  Created by admin on 9/17/19.
//  Copyright © 2019 ForLearn. All rights reserved.
//

import UIKit
import WWLayout
import Firebase

class CollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        return cell
    }
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("MonAn/mon: 01")
        ref.observeSingleEvent(of: .value) { (DataSnapshot) in
            print(DataSnapshot.value!)
        }
        let layoutcv = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutcv)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        layoutcv.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layoutcv.minimumInteritemSpacing = 0
        layoutcv.minimumLineSpacing = 0
        layoutcv.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        view.addSubview(collectionView)
        view.backgroundColor = .white
        collectionView.layout.fill(view)
        collectionView.backgroundColor = .white
    }
    

}
