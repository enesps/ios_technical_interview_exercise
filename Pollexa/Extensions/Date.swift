import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 1 // En büyük zaman birimini göster

        let now = Date()
        let timeInterval = now.timeIntervalSince(self)
        
        guard let timeString = formatter.string(from: timeInterval) else { return "Just now" }
        
        return timeString + " ago"
    }
    
    static func fromString(_ dateString: String, format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
}
