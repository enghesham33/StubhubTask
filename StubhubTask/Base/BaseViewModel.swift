//
//  BaseViewModel.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//

import Foundation

class BaseViewModel {
    var loading: Observable<Bool> = Observable(false)
    var error: Observable<String> = Observable("")
}
