//
//  DashboardView.swift
//  Basic-Car-Maintenance
//
//  Created by Mikaela Caron on 8/19/23.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var isShowingAddView = false
    
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.events) { event in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(event.title)
                            .font(.title3)
                        
                        Text("\(event.date.formatted(date: .abbreviated, time: .omitted))")
                        
                        Text(event.notes)
                            .lineLimit(0)
                    }
                }
                .listStyle(.inset)
            }
            .navigationTitle(Text("Dashboard"))
            .onAppear {
                viewModel.events.append(MaintenanceEvent(id: UUID().uuidString, title: "Oil Change", date: Date(), notes: "oil changed by me"))
                viewModel.events.append(MaintenanceEvent(id: UUID().uuidString, title: "Oil Change", date: Date(), notes: "oil changed by me"))
                viewModel.events.append(MaintenanceEvent(id: UUID().uuidString, title: "Oil Change", date: Date(), notes: "oil changed by me"))
                viewModel.events.append(MaintenanceEvent(id: UUID().uuidString, title: "Oil Change", date: Date(), notes: "oil changed by me"))
            }
            .sheet(isPresented: $isShowingAddView) {
                AddMaintenanceView() { event in
                    Task {
                        try? await viewModel.addEvent(event)
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
