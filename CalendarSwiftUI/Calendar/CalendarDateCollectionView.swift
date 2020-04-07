//
//  CalendarDateCollectionView.swift
//  CalendarSwiftUI
//
//  Created by Francesco Palumbo on 07/04/2020.
//  Copyright © 2020 Francesco Palumbo. All rights reserved.
//

import SwiftUI

struct CalendarDateCollectionView: View {
    
    var cClouds = Color(UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.00))
    
    @EnvironmentObject var obj : CalendarManager
    @State private var state : CalendarCell.CellState = .normal    
    var body: some View {
        PageView(pageManager: self.obj.pageManager, views:[self.page()])
            .frame(height: 47 * 5)
    }
    
    func page() -> some View {
        VStack {
            VStack {
                ForEach(self.datesArray(),id: \.self) { rows in
                    HStack(spacing:0) {
                        ForEach(rows,id: \.self) { column in
                            HStack {
                                Spacer(minLength: 0)
                                CalendarCell(holderDate: column)
                                Spacer(minLength: 0)
                            }
                        }
                    }
                }
            }.font(.system(size: 15))
            Spacer(minLength: 0)
        } .background(cClouds)
    }
    
    // Combine row and column for collectionView
    func datesArray() -> [[HolderDate]] {
        var rowArray : [[HolderDate]] = []
        let columns = numberOfColumns()
        let rows = numberOfRows()
        let days = self.obj.date.allDays()
        let placeholder = HolderDate(date: nil)
        let offset = dayOffset()
        
        for row in 0..<rows {
            var columnArray : [HolderDate] = []
            for column in 0..<columns {
                let index = row * columns + column
                if index < offset || days.count <= (index - offset) {
                    columnArray.append(placeholder)
                } else {
                    let d = days[index - offset]
                    columnArray.append(HolderDate(date: d))
                }
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    // Rows in specified month
    func numberOfRows() -> Int {
        let actualDays = obj.date.numberOfDays()
        let offset = dayOffset()
        let days = actualDays + offset
        let columns = numberOfColumns()
        let number = days % columns
        if number == 0 {
            return days / columns
        } else {
            return days / columns + 1
        }
    }
    // Column in specified month
    func numberOfColumns() -> Int {
        return 7
    }
    
    func dayOffset() -> Int {
        return obj.date.firstDayOfWeek() - 1
    }
}

struct HolderDate : Hashable {
    let date : Date?
}

struct CalendarDateCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarDateCollectionView()
                .environmentObject(CalendarManager())
        }
    }
}
