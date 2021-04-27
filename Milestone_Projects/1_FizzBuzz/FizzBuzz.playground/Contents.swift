import UIKit

func fizzbuzz(number: Int) -> String {
    switch (number % 3 == 0, number % 5 == 0) {
        case (true, false):
        return "Fizz"
        case (false, true):
        return "Buzz"
        case (true, true):
        return "Fizz Buzz"
        default:
        return String(describing: number)
    }
}

fizzbuzz(number: 3)
fizzbuzz(number: 5)
fizzbuzz(number: 15)
fizzbuzz(number: 16)
