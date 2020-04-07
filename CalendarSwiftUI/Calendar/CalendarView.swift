//
//  CalendarView.swift
//  CalendarSwiftUI
//
//  Created by Francesco Palumbo on 07/04/2020.
//  Copyright © 2020 Francesco Palumbo. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var CalendarManager : CalendarManager
    
    var body: some View {
        VStack {
            CalendarToolBar()
            CalendarWeekBar()
            CalendarDateCollectionView()
        }.padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(CalendarManager())
    }
}
