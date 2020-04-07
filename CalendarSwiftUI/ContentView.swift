//
//  ContentView.swift
//  CalendarSwiftUI
//
//  Created by Francesco Palumbo on 07/04/2020.
//  Copyright © 2020 Francesco Palumbo. All rights reserved.
//

import SwiftUI
import Combine

// COLORS
var cClouds = Color(UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.00))
var cBlue   = Color(UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.00))
var cGreen  = Color(UIColor(red:0.10, green:0.74, blue:0.61, alpha:1.00))
var cCalendar = Color(UIColor(red:0.247, green:0.248, blue:0.252, alpha:1.00))

struct ContentView: View {
    @State private var maxGlass: Int = 16
    var calendarObj = CalendarManager()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            Text("Calendar")
                .font(.system(size: 30))
                .foregroundColor(cClouds)
                .bold()
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 35)
                    .fill(cClouds)
                    .frame(height: 450)
                    .padding()
                VStack{
                    CalendarView()
                        .padding(.horizontal)
                        .environmentObject(calendarObj)
                    VStack{
                        
                        Divider()
                            .padding(.horizontal)
                        Spacer()
                            .frame(height: 30)
                        HStack{
                            Text("Francesco Palumbo")
                                .bold()
                                .foregroundColor(Color.black)
                                .font(.system(size: 17))
                                .padding(.horizontal)
                            Spacer()
                        }
                    }.padding(.horizontal,30)
                        .frame(alignment: .topLeading)
                }
            }
            Spacer()
        }.background(cBlue)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class CalendarManager : ObservableObject {
    
    let didChangeSelectedDate = PassthroughSubject<Date,Never>()
    
    @Published var calendar : Calendar = .current
    @Published var selectedDate : Date = Date() {
        didSet {
            didChangeSelectedDate.send(selectedDate)
        }
    }
    @Published var selectedDates : [Date] = []
    @Published var pageManager = PageManager()
    @Published var date : Date = Date()
    
    var anyCancellable: AnyCancellable? = nil
    
    init() {
        anyCancellable = pageManager.objectWillChange.sink(receiveValue: { value in
            self.objectWillChange.send()
        })
    }
}
