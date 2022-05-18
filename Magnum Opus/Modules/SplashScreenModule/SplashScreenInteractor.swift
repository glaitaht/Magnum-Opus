//
//  SplashScreenInteractor.swift
//  CIViperGenerator
//
//  Created by Cem KILIÇ on 30.04.2022.
//  Copyright © 2022 Cem KILIÇ. All rights reserved.
//

import Foundation

protocol SplashScreenInteractorProtocol: AnyObject {

}

final class SplashScreenInteractor {
    weak var presenter: SplashScreenPresenterProtocol?
}

extension SplashScreenInteractor: SplashScreenInteractorProtocol {

}
