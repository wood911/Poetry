//
//  PoetryMainViewController.swift
//  SwiftCase
//
//  Created by 伍腾飞 on 2017/5/21.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit

protocol PoetryKindItemDelegate {
    func delete(kindName: String)
}

class PoetryKindItem: UICollectionViewCell {
    
    var delegate: PoetryKindItemDelegate?
    
    @IBOutlet weak var kindName: UILabel!
    @IBOutlet weak var delete: UIButton!
    
    @IBAction func deleteKind(_ sender: UIButton) {
        if let text = self.kindName.text {
            delegate?.delete(kindName: text)
        }
    }
}

class PoetryMainViewController: UIViewController, UICollectionViewDataSource, PoetryKindItemDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var isKindEditing: Bool = false
    
    var poetryKinds: [PoetryKind] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // 添加编辑按钮
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editKind(_:)))
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "poetry_background")!)
        collectionView.backgroundColor = UIColor.clear
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: UIScreen.main.bounds.width * 0.5 - 30, height: UIScreen.main.bounds.width * 0.25)
        
        // 加载数据
        loadPoetryKinds()
    }
    
    func loadPoetryKinds() {
        if let kinds = PoetryDBManager.getPoetryKinds() {
            poetryKinds = kinds
        }
    }
    
    func editKind(_ sender: Any) {
        isKindEditing = !isKindEditing
        collectionView.reloadData()
    }
    

    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poetryKinds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "poetryKind", for: indexPath) as! PoetryKindItem
        cell.delegate = self
        cell.kindName.text = poetryKinds[indexPath.item].kindName
        cell.delete.alpha = isKindEditing ? 1 : 0
        return cell
    }
    
    // MARK: - PoetryKindItemDelegate
    func delete(kindName: String) {
        // 确认提示
        let alert = UIAlertController(title: "温馨提示", message: "删除后将不可恢复", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            // 删除后不可恢复
            if PoetryDBManager.deletePoetry(byKindName: kindName) {
                self.view.showMessage("\(kindName) 已被移除")
                self.isKindEditing = !self.isKindEditing
                // 删除后重新加载commit后的数据
                self.loadPoetryKinds()
            } else {
                self.view.showMessage("操作失败")
            }
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let list = segue.destination as? PoetryListViewController {
            list.kindName = (sender as? PoetryKindItem)?.kindName.text
        }
    }

}
