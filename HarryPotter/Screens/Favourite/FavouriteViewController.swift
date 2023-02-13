//
//  FavouriteViewController.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 28/09/2022.
//

import UIKit
import CoreData

final class FavouriteViewController: UITableViewController {
    
    //MARK: - Properties
    
    private var favouriteViewModel: FavouriteViewModelProtocol
    
    //MARK: - Lifecycle
    
    init(favouriteViewModel: FavouriteViewModelProtocol) {
        self.favouriteViewModel = favouriteViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableRegister()
        headerRegister()
        tableView.backgroundView = favouriteViewModel.backgroundView
        performFetch()
    }
    
    //MARK: - Private
    
    private func tableRegister() {
        tableView.register(FavouriteMemberCell.self, forCellReuseIdentifier: favouriteViewModel.cellId)
    }
    
    private func headerRegister() {
        tableView.register(FavouriteHeader.self, forHeaderFooterViewReuseIdentifier: favouriteViewModel.headerId)
    }
    
    private func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    private lazy var fetchedResultsController: NSFetchedResultsController<CharacterDB> = {
        
        let fetchRequest: NSFetchRequest<CharacterDB> = CharacterDB.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: favouriteViewModel.dependencies.dataController.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
}

extension FavouriteViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        if sectionInfo.numberOfObjects > 0 {
            
            return sectionInfo.numberOfObjects
            
        } else {
             print("error")
            return 0
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favouriteViewModel.cellId, for: indexPath) as! FavouriteMemberCell
        let object = self.fetchedResultsController.object(at: indexPath)
        
        cell.backgroundColor = favouriteViewModel.backgroundColor
        cell.memberLabel.text = object.name
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: favouriteViewModel.headerId) as! FavouriteHeader
        return headerView
    }
}

extension FavouriteViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
