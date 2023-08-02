//  Created by илья on 02.08.23.

import Foundation

extension Date {
    func getDifferenceFromNowAndDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let targetDate = dateFormatter.date(from: dateString) {
            let currentDate = Date()
            let calendar = Calendar.current

            let components = calendar.dateComponents([.day, .hour, .minute], from: targetDate, to: currentDate)

            if let days = components.day, days > 0 {
                return "\(days) days ago"
            } else if let hours = components.hour, hours > 0 {
                return "\(hours) hours ago"
            } else if let minutes = components.minute, minutes > 0 {
                return "\(minutes) minutes ago"
            } else {
                return "now"
            }
        }
        return nil
    }
}
