//
//  ListViewMockController.swift
//  Magnum OpusTests
//
//  Created by Cem Kılıç on 2.05.2022.
//

import Foundation
@testable import Magnum_Opus

final class ListViewMockController: ListViewControllerProtocol {
    
    
    var isInvokedSetupViews = false
    var isInvokedShowLoading = false
    var isInvokedHideLoading = false
    
    func showLoadingView() {
        self.isInvokedShowLoading = true
    }
    
    func hideLoadingView() {
        self.isInvokedHideLoading = true
    }
    
    func reloadData() {}
    
    func setupViews() {
        self.isInvokedSetupViews = true
    }
    
    func reloadSlider() {}
}
