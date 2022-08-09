//
//  EventsView.swift
//  StubhubTask
//
//  Created by Hesham Donia on 09/08/2022.
//

import SwiftUI

struct EventsView: View {
    @ObservedObject var viewModel = EventsInjector.provideEventsViewModel()
    @State private var cityName: String = ""
    @State private var price: String = ""
    @State private var andBackgroundColor = Color.white
    @State private var andForegroundColor = Color.blue
    @State private var orBackgroundColor = Color.blue
    @State private var orForegroundColor = Color.white
    
    init() {
        viewModel.getEvents()
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8, content: {
            HStack {
                Spacer().frame(width: 16)
                TextField("Filter by city name", text: $cityName)
                    .textFieldStyle(.roundedBorder)
                Spacer().frame(width: 16)
            }
            
            HStack {
                Spacer().frame(width: 16)
                TextField("Filter by price", text: $price)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                Spacer().frame(width: 16)
            }
            HStack(spacing: 8.0) {
                Spacer().frame(width: 16)
                Text("Operation type:")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    viewModel.filterOperation = .AND
                    changeButtonsColors()
                }, label: {
                    HStack {
                            Spacer()
                            Text("AND")
                            Spacer()
                          }
                })
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(andBackgroundColor)
                .foregroundColor(andForegroundColor)
                
                Button(action: {
                    viewModel.filterOperation = .OR
                    changeButtonsColors()
                }, label: {
                    HStack {
                            Spacer()
                            Text("OR")
                            Spacer()
                          }
                })
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(orBackgroundColor)
                .foregroundColor(orForegroundColor)
                Spacer().frame(width: 16)
            }
            
            HStack(spacing: 8.0) {
                Spacer().frame(width: 16)
                Button(action: {
                    viewModel.applyFilters(city: cityName, price: price)
                }, label: {
                    HStack {
                            Spacer()
                            Text("Apply Filter")
                            Spacer()
                          }
                })
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    viewModel.clearFilter()
                    cityName = ""
                    price = ""
                }, label: {
                    HStack {
                            Spacer()
                            Text("Clear Filter")
                            Spacer()
                          }
                })
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(width: 16)
            }
            List(viewModel.isFilterApplied ? viewModel.filteredEvents : viewModel.events) { event in
                EventCellView(event: event)
            }
        })
          
    }
    
    func changeButtonsColors() {
        if viewModel.filterOperation == .AND {
            andBackgroundColor = .blue
            andForegroundColor = .white
            orBackgroundColor = .white
            orForegroundColor = .blue
        } else {
            orBackgroundColor = .blue
            orForegroundColor = .white
            andBackgroundColor = .white
            andForegroundColor = .blue
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
