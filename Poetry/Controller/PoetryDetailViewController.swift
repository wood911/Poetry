//
//  PoetryDetailViewController.swift
//  SwiftCase
//
//  Created by 伍腾飞 on 2017/5/21.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit
import AVFoundation

class PoetryDetailViewController: UIViewController, AVSpeechSynthesizerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    // 内容以换行符拆分成一行一行的文字
    var contents: [String]!
    var poetry: Poetry! {
        didSet {
            contents = poetry.content.components(separatedBy: "\n")
        }
    }
    // 朗诵诗词
    lazy var speech: AVSpeechSynthesizer = {
        let speech = AVSpeechSynthesizer()
        speech.delegate = self
        return speech
    }()
    var speechItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "poetry_background")!)
        tableView.backgroundColor = UIColor.clear
        self.title = poetry.title
        
        // 添加朗诵按钮
        speechItem = UIBarButtonItem(title: "朗诵", style: .plain, target: self, action: #selector(speechPoetry(_:)))
        self.navigationItem.rightBarButtonItem = speechItem
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if speech.isSpeaking {
            speech.stopSpeaking(at: .immediate)
        }
    }
    
    func speechPoetry(_ sender: UIBarButtonItem) {
        if speech.isSpeaking {
            speech.stopSpeaking(at: .immediate)
        } else {
            let utt = AVSpeechUtterance(string: poetry.content)
            utt.voice = AVSpeechSynthesisVoice(language: "zh-CN")
            speech.speak(utt)
        }
    }
    
    // MARK: - AVSpeechSynthesizerDelegate
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        speechItem.title = "停止"
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speechItem.title = "朗读"
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        speechItem.title = "朗读"
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        // 标题、作者、诗词、注释
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return contents.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "poetryTitle", for: indexPath)
            (cell.contentView.subviews[0] as! UILabel).text = poetry.title
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "poetryAuthor", for: indexPath)
            (cell.contentView.subviews[0] as! UILabel).text = poetry.author
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "poetryContent", for: indexPath)
            (cell.contentView.subviews[0] as! UILabel).text = contents[indexPath.row]
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "poetryDesc", for: indexPath)
            (cell.contentView.subviews[0] as! UILabel).text = poetry.desc
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 64
        case 1:
            return 20
        case 2:
            return 54
        case 3:
            return UITableViewAutomaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 {
            return 100
        }
        return 54
    }

}
