//
//  KeepListViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/11.
//

import UIKit

class KeepListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static func makeFromStoryboard() -> KeepListViewController {
        let vc = UIStoryboard.keepListViewController
        return vc
    }

    @IBOutlet private weak var keepListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setStatusBarbackgroundColor(.green)
        setupTableView()
    }

    private func setupTableView() {
        keepListTableView.dataSource = self
        keepListTableView.delegate = self
        keepListTableView.register(timelineCell.nib, forCellReuseIdentifier: timelineCell.identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = keepListTableView.dequeueReusableCell(withIdentifier: timelineCell.identifier, for: indexPath) as! timelineCell
        cell.setCell()
        return cell
    }

}
