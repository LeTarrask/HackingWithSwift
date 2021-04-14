//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Alex Luna on 14/04/2021.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects

    @State private var isShowingScanner = false

    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter: FilterType

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }

    enum sortType {
        case name, recent
    }

    let sortPreference: sortType = .recent

    var sortedProspects: [Prospect] {
        switch sortPreference {
        case .name:
            return filteredProspects.sorted { $0.name > $1.name }
        case .recent:
            return filteredProspects
        }
    }

    @State var chooseSortPresent: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                        if filter == .none && prospect.isContacted {
                            Image("person.fill.checkmark")
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                            prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                           Button("Remind Me") {
                              addNotification(for: prospect)
                           }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing: Button(action: {
                isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
        }
        .actionSheet(isPresented: $chooseSortPresent) {
            ActionSheet(
                title: Text("Sort your contacts"),
                message: Text(""),
                buttons: [
                    .cancel(),
                    .default(Text("Recently Added")) {},
                    .default(Text("By Name")) {}
                ]
            )
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr],
                            simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
                            completion: handleScan)
        }
    }

    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed because: \(error)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //          let trigger = UNCalendarNotificationTrigger(dateMatching:
            //    dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval:
                                                                5, repeats: false) // This trigger for 5 seconds is just for testing purposes, the app should run with the one that's right before this line, which run tomorrow at 9.

            let request = UNNotificationRequest(identifier:
                                                    UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
