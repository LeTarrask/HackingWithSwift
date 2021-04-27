import UIKit

let name = "Sir Tarrask Jr"

for letter in name {
    print(letter)
}


let letter = name[name.index(name.startIndex, offsetBy: 3)]

print(name.isEmpty)

extension String {
    // remove a prefix if it exists
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    // remove a suffix if it exists
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

name.deletingPrefix("Sir ")
name.deletingSuffix("Jr")
name.lowercased()
name.uppercased()
name.capitalized

name.contains("Tarrask")


extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true }
        }
        return false
    }
}

let array = ["Tarrask", "Beholder", "Tiamat"]

name.containsAny(of: array)

// Instead of using this extension above, Swift has this solution
array.contains(where: name.contains)


let string = "Tarrask is learning Swift"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSMutableAttributedString(string: string, attributes: attributes)

attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))


extension String {
    func withPrefix(_ prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        return prefix+self
    }
}

"pet".withPrefix("car")
"carpet".withPrefix("car")


extension String {
    func isNumeric() -> Bool {
        for letter in self {
            if let _ = Double(String(letter)) {
                return true
            }
        }
        return false
    }
}

"2".isNumeric()
"tarrask".isNumeric()
"tarrask2".isNumeric()


extension String {
    func lines() -> [String] {
        var array = [String]()
        for line in self.split(separator: "\n") {
            array.append(String(line))
        }
        return array
    }
}

"this\nis\na\ntest".lines()
