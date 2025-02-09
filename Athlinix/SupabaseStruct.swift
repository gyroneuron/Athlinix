import Foundation


enum Role: String, Codable, CaseIterable {
    case athlete
    case coach
}

struct Usertable: Codable, Equatable {
    let userID: UUID
    let createdAt: String
    let username: String
    let name: String
    let email: String
    let password: String
    let profilePicture: String?
    let coverPicture: String?
    let bio: String?
    let dateJoined: String
    let lastLogin: String
    let role: Role
}

enum positions: String, Codable, CaseIterable {
       case pointGuard = "Point Guard"
       case shootingGuard = "Shooting Guard"
       case smallForward = "Small Forward"
       case powerForward = "Power Forward"
       case center = "Centre"
}

struct AthleteProfileUpdate: Encodable {
    var position: String?
    var height: Int?
    var weight: Int?
}

struct AthleteProfileTable : Codable, Equatable{
    let athleteID : UUID
    let height : Float
    let weight: Float
    let experience: Int8
    let position: positions
    let averagePointsPerGame: Float
    let averageReboundsPerGame: Float
    let averageAssistsPerGame: Float
    
}

struct TeamTable: Codable, Equatable {
    let teamID: UUID
    let dateCreated: String
    let teamName: String
    let teamMotto: String?
    let teamLogo: String?
    let createdBy: UUID
}

struct TeamMembershipTable: Codable, Equatable {
    let membershipID: UUID
    let teamID: UUID
    let userID: UUID
    let roleInTeam: Role
    let dateJoined: String
}

struct GameLogtable: Codable, Equatable {
    let logID: UUID
    let gameID: UUID
    let teamID: UUID
    let playerID: UUID
    var points2: Int
    var points3: Int
    var freeThrows: Int
    var rebounds: Int
    var assists: Int
    var steals: Int
    var fouls: Int
    var missed2Points: Int
    var missed3Points: Int
    var totalPoints: Int {
        return points2 * 2 + points3 * 3
    }
}


struct GameTable: Codable, Equatable{
    let gameID: UUID
    
    var team1ID: UUID
    var team2ID: UUID
    var dateOfGame: String
    var venue: String
    var team1finalScore: Int
    var team2finalScore: Int
}

struct PostsTable:Codable, Equatable{
    let postID: UUID
    let createdBy: UUID // User ID
    var content: String?
    var image1: String
    var image2: String
    var image3: String
    var linkedGameID: UUID? // Nullable
    var likes: Int
}

struct Player {
    var name: String
    var reb: Int // Rebounds
    var ast: Int // Assists
    var stl: Int // Steals
    var foul: Int // Fouls
    var pts: Int // Points
}

struct Team {
    var name: String
    var players: [Player]
}
