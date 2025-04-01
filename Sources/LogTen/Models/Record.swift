protocol Record: Codable, Sendable {
}

protocol IdentifiableRecord: Record, Identifiable, Hashable, Equatable {
}

extension IdentifiableRecord {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

protocol RecordEnum: RawRepresentable, Codable, Sendable {}
