//
//  SearchbarViewMockController.swift
//  Magnum OpusTests
//
//  Created by Cem Kılıç on 2.05.2022.
//

import Foundation
@testable import Magnum_Opus

final class SearchbarViewController: SearchResultViewControllerProtocol {

    func reloadData() {
        
    }
    
    var isInvokedShowLoading = false
    var isInvokedHideLoading = false
    
    func showLoadingView() {
        self.isInvokedShowLoading = true
    }
    
    func hideLoadingView() {
        self.isInvokedHideLoading = true
    }
    
}
