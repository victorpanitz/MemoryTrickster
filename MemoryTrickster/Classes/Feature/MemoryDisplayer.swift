import Foundation
import UIKit

protocol MemoryDisplayLogic: AnyObject {
    func updateRemainingMemory(with memory: String)
    func updateUsedMemory(with memory: String)
    func updateInjectedMemory(with memory: String)
    func updateViewVisibility()
}

final class MemoryDisplayer {
    private var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }
    
    private let memoryTricksterView = MemoryTricksterView()
    private let presenter: MemoryPresenter
    
    init(presenter: MemoryPresenter) {
        self.presenter = presenter
        
        memoryTricksterView.delegate = self
    }
}

extension MemoryDisplayer: MemoryDisplayLogic {
    func updateRemainingMemory(with memory: String) {
        memoryTricksterView.freeMemorySizeLabel.text = memory
    }
    
    func updateUsedMemory(with memory: String) {
        memoryTricksterView.usedMemorySizeLabel.text = memory
    }
    
    func updateInjectedMemory(with memory: String) {
        memoryTricksterView.injectedMemorySizeLabel.text = memory
    }
    
    func updateViewVisibility() {
        if topViewController?.view.subviews.contains(memoryTricksterView) == true {
            topViewController?.view.bringSubview(toFront: memoryTricksterView)
        } else {
            memoryTricksterView.removeFromSuperview()
            topViewController?.view.addSubview(memoryTricksterView)
        }
    }
}

extension MemoryDisplayer: MemoryTricksterViewDelegate{
    func didTouchMemoryModifierButton(_ modifier: MemoryModifier) {
        presenter.memoryModificationTriggered(with: modifier)
    }
    
    func didTriggerQuickActions() {
        let alert = UIAlertController(
            title: Strings.alertTitle,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let clearBufferAction = UIAlertAction(
            title: Strings.alertActionCMB,
            style: .default
        ) { [presenter] _ in
            presenter.clearMemoryTriggered()
        }
        
        let removeTricksterAction = UIAlertAction(
            title: Strings.alertActionCMT,
            style: .default
        ) { [presenter, memoryTricksterView] _ in
            memoryTricksterView.removeFromSuperview()
            presenter.stopMemoryTrickster()
        }

        let cancelAction = UIAlertAction(
            title: Strings.alertActionCancel,
            style: .cancel,
            handler: nil
        )
        
        alert.addAction(clearBufferAction)
        alert.addAction(removeTricksterAction)
        alert.addAction(cancelAction)
        
        topViewController?.present(alert, animated: true, completion: nil)
    }
}
