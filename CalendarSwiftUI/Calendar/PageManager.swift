//
//  PageManager.swift
//  CalendarSwiftUI
//
//  Created by Francesco Palumbo on 07/04/2020.
//  Copyright © 2020 Francesco Palumbo. All rights reserved.
//

import SwiftUI
import Combine

class PageManager : ObservableObject {
    
    @Published var currentPage : Int = 0 {
        willSet {
            if newValue >= currentPage {
                direction = .forward
            } else {
                direction = .reverse
            }
            objectWillChange.send()
        }
        
        didSet {
            onPageChange?(currentPage,direction)
        }
    }
    
    var direction : UIPageViewController.NavigationDirection = .forward
    
    var onPageChange: ((Int,UIPageViewController.NavigationDirection)->Void)?
}
