//
//  ViewController.swift
//  MyTrainingApp
//
//  Created by yasudamasato on 2021/11/10.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    static func makeFromStoryboard() -> HomeViewController {
        let homeVC = UIStoryboard.homeViewController
        return homeVC
    }

    @IBOutlet private weak var timelineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    private func setupTableView() {
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        timelineTableView.register(TimelineCell.nib, forCellReuseIdentifier: TimelineCell.identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timelineTableView.dequeueReusableCell(withIdentifier: TimelineCell.identifier, for: indexPath) as! TimelineCell
        return cell
    }
}
