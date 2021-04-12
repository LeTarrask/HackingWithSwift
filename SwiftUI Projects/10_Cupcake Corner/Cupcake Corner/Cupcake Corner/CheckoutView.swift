//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    Button("Place Order") {
                        placeOrder()
                    }
                    .padding() }
            }
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }

    func placeOrder() {
        // Encodes our order class into JSON
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        // Creates a request to a testing website that will answer with our exact data
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        // Sends the request
        URLSession.shared.dataTask(with: request) { data, response,
                                                    error in
            // and handle the result here.
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            if let decodedOrder = try? JSONDecoder().decode(Order.self,
            from: data) {
               confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
               showingConfirmation = true
            } else {
               print("Invalid response from server")
                confirmationMessage = "We apologize for the inconvencience but your order failed."
                showingConfirmation = true
            }
        }.resume()
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
