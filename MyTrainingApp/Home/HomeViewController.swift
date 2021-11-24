//
//  ViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    static func makeFromStoryboard() -> HomeViewController {
        let vc = UIStoryboard.homeViewController
        return vc
    }

    @IBOutlet private weak var timelineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStatusBarbackgroundColor(.green)
        setupTableView()
    }

    private func setupTableView() {
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        timelineTableView.register(timelineCell.nib, forCellReuseIdentifier: timelineCell.identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timelineTableView.dequeueReusableCell(withIdentifier: timelineCell.identifier, for: indexPath) as! timelineCell
        cell.setCell()
        return cell
    }
}

