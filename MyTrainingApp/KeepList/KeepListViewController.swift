//
//  KeepListViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/11.
//

import UIKit

class KeepListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static func makeFromStoryboard() -> KeepListViewController {
        let keepListVC = UIStoryboard.keepListViewController
        return keepListVC
    }

    @IBOutlet private weak var keepListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    private func setupTableView() {
        keepListTableView.dataSource = self
        keepListTableView.delegate = self
        keepListTableView.register(TimelineCell.nib, forCellReuseIdentifier: TimelineCell.identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = keepListTableView.dequeueReusableCell(withIdentifier: TimelineCell.identifier, for: indexPath) as! TimelineCell
        cell.setCell()
        return cell
    }

}
