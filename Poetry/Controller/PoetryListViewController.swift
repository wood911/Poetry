//
//  PoetryListViewController.swift
//  SwiftCase
//
//  Created by 伍腾飞 on 2017/5/21.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit

class PoetryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var kindName: String?
    var poetries: [Poetry] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "poetry_background")!)
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 54
        self.title = kindName
        
        // 加载数据
        loadPoeries()
    }
    
    func loadPoeries() {
        if let kindName = kindName, let poetries = PoetryDBManager.getPoetries(by: kindName) {
            self.poetries = poetries
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poetries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "poetry") ?? UITableViewCell(style: .default, reuseIdentifier: "poetry")
        cell.backgroundColor = UIColor.clear
        cell.textLabel!.text = poetries[indexPath.row].title
        cell.textLabel!.textColor = UIColor.darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let poetry = poetries[indexPath.row]
        if editingStyle == .delete {
            let alert = UIAlertController(title: "温馨提示", message: "删除后将不可恢复", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
                // 删除后不可恢复
                if PoetryDBManager.deletePoetry(byID: poetry.ID) {
                    self.view.showMessage("\(poetry.title) 已被移除")
                    // 删除后重新加载commit后的数据
                    self.loadPoeries()
                } else {
                    self.view.showMessage("操作失败")
                }
            }))
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 点击可查看完整诗词信息
        let poetry = poetries[indexPath.row]
        if let detailC = storyboard?.instantiateViewController(withIdentifier: "detail") {
            (detailC as! PoetryDetailViewController).poetry = poetry
            self.show(detailC, sender: nil)
        }
    }

}
