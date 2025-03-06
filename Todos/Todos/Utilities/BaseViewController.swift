//
//  BaseViewController.swift
//  Todos
//
//  Created by admin on 3/4/25.
//

import Foundation
import UIKit
import Combine

class BaseViewController: UIViewController {
    var cancelables = Set<AnyCancellable>()
    
    lazy var errorView: UILabel = {
        let view = UILabel(frame: .init(x: 10, y: 0, width: self.view.frame.width-20, height: 70))
        view.font = .systemFont(ofSize: 18)
        view.text = "Something went wrong"
        view.textAlignment = .center
        view.backgroundColor = .launchScreen
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        
        NotificationCenter.default.publisher(for: .failedUploadData)
            .sink {[weak self] not in
                let title = not.object as? String
                self?.errorView.text = title ?? "Something went wrong"
                            self?.errorView.frame.origin.y = 60
                            self?.errorView.isHidden = false
                            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                                UIView.animate(withDuration: 2) {
                                    self?.errorView.frame.origin.y = -100
                                } completion: { _ in
                                    self?.errorView.isHidden = true
                                }
                
                
                
                            }
                        }
            .store(in: &cancelables)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(errorView)
        

    }
    
}

extension UIViewController {
    
}
