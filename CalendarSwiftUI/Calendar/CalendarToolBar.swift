//
//  CalendarToolBar.swift
//  CalendarSwiftUI
//
//  Created by Francesco Palumbo on 07/04/2020.
//  Copyright © 2020 Francesco Palumbo. All rights reserved.
//

import SwiftUI

struct CalendarToolBar: View {
    
    @EnvironmentObject var CalendarManager : CalendarManager
    
    var components : DateComponents {
        return CalendarManager.calendar.dateComponents([.year,.month,.day], from: CalendarManager.date)
    }
    
    var year : Int  {
        return components.year!
    }
    
    var month : Int {
        return components.month!
    }
    
    var shortMonthSymbols : String {
        return CalendarManager.calendar.monthSymbols[month - 1]
    }
    
    var yearSymbols : String {
        return "\(year)"
    }
    
    var foreColor : Color = .gray
    
    var body: some View {
        HStack {
            HStack {
                HStack(spacing: 30){
                    Text("\(shortMonthSymbols)")
                        .bold()
                        .padding()
                        .foregroundColor(Color.black)
                        .font(.system(size: 17, weight: .regular))
                    
                    
                    Text("\(yearSymbols)")
                        .foregroundColor(Color.black)
                        .font(.system(size: 17, weight: .regular))
                        .bold()
                }
            }            
            Spacer()
            HStack(spacing:5) {
                Button(action: {
                    self.CalendarManager.date = self.CalendarManager.date.addMonth(by:-1)                    
                    self.CalendarManager.pageManager.currentPage -= 1
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10, height: 15, alignment: .center)
                        .padding(15)
                        .foregroundColor(Color.white)
                        .background(cCalendar.opacity(0.2))
                        .clipShape(Circle())
                }
                .frame(width: 50, height: 40)
                Button(action: {
                    self.CalendarManager.date = self.CalendarManager.date.addMonth(by:1)
                    self.CalendarManager.pageManager.currentPage += 1
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10, height: 15, alignment: .center)
                        .padding(15)
                        .foregroundColor(Color.white)
                        .background(cCalendar.opacity(0.2))
                        .clipShape(Circle())
                }
                .frame(width: 50, height: 40)
            }
        }.foregroundColor(foreColor)
    }
}

struct CalendarToolBar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarToolBar().environmentObject(CalendarManager())
    }
}
