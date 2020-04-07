//
//  CalendarWeekBar.swift
//  CalendarSwiftUI
//
//  Created by Francesco Palumbo on 07/04/2020.
//  Copyright © 2020 Francesco Palumbo. All rights reserved.
//

import SwiftUI

struct CalendarWeekBar: View {
    
    @EnvironmentObject var CalendarManager : CalendarManager
    
    var color : Color = Color.gray
    
    var body: some View {
        HStack {
            ForEach(self.weeks(),id:\.self) { week in
                HStack {
                    Spacer()
                    Text(week)
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(self.color)
                    Spacer()
                }
            }
        }
    }
    
    func weeks() -> [String] {
        return CalendarManager.calendar.veryShortWeekdaySymbols
    }
}

struct CalendarWeekBar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWeekBar().environmentObject(CalendarManager())
    }
}
