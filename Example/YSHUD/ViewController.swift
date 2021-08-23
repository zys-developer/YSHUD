//
//  ViewController.swift
//  YSHUD
//
//  Created by zys-developer on 08/21/2021.
//  Copyright (c) 2021 zys-developer. All rights reserved.
//

import UIKit
import YSHUD

class ViewController: UIViewController {
    
    let datas = ["showLoading", "showMessage", "showSucceed", "showWarned", "showFailed", "showProgressRound"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 创建列表
        let tableView = UITableView(frame: .zero, style: .plain)
        // 背景色
        tableView.backgroundColor = .white
        // 分割线样式
        tableView.separatorStyle = .none
        // 注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        // 添加到视图上
        view.addSubview(tableView)
        tableView.frame = view.bounds
        // 设置数据源和代理
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            HUD.showLoading("HUD.showLoading")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                HUD.hide()
            }
        case 1:
            HUD.showMessage("HUD.showMessage")
        case 2:
            HUD.showSucceed("HUD.showSucceed")
        case 3:
            HUD.showWarned("HUD.showWarned") {
                print("HUD.showWarned")
            }
        case 4:
            HUD.showFailed("HUD.showFailed")
        case 5:
            var progress = 0
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                progress += 1
                HUD.showProgressRound("\(progress)%", Float(progress) / 100)
                if progress >= 100 {
                    timer.invalidate()
                }
            }
        default:
            break
        }
    }
}
