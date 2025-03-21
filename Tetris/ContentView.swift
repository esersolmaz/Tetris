import SwiftUI

@main
struct TetrisApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Blok pozisyonu
struct BlockPosition: Hashable {
    var row: Int
    var column: Int
}

// Tetromino (Tetris Parçası) Tipi
enum TetrominoType: CaseIterable {
    case i, j, l, o, s, t, z
    
    // Renk atama
    var color: Color {
        switch self {
        case .i: return .cyan
        case .j: return .blue
        case .l: return .orange
        case .o: return .yellow
        case .s: return .green
        case .t: return .purple
        case .z: return .red
        }
    }
    
    // Şekil bileşenleri
    func blockOffsets(rotation: Int) -> [BlockPosition] {
        let normalizedRotation = ((rotation % 4) + 4) % 4 // 0-3 arasında rotasyon
        
        switch self {
        case .i:
            switch normalizedRotation {
            case 0, 2:
                return [BlockPosition(row: 0, column: 0),
                       BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 0, column: 2),
                       BlockPosition(row: 0, column: 3)]
            case 1, 3:
                return [BlockPosition(row: 0, column: 0),
                       BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 2, column: 0),
                       BlockPosition(row: 3, column: 0)]
            default:
                return []
            }
        case .j:
            switch normalizedRotation {
            case 0:
                return [BlockPosition(row: 0, column: 0),
                       BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 1, column: 2)]
            case 1:
                return [BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 0, column: 2),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 2, column: 1)]
            case 2:
                return [BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 1, column: 2),
                       BlockPosition(row: 2, column: 2)]
            case 3:
                return [BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 2, column: 0),
                       BlockPosition(row: 2, column: 1)]
            default:
                return []
            }
        case .l:
            switch normalizedRotation {
            case 0:
                return [BlockPosition(row: 0, column: 2),
                       BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 1, column: 2)]
            case 1:
                return [BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 2, column: 1),
                       BlockPosition(row: 2, column: 2)]
            case 2:
                return [BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 1, column: 2),
                       BlockPosition(row: 2, column: 0)]
            case 3:
                return [BlockPosition(row: 0, column: 0),
                       BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 2, column: 1)]
            default:
                return []
            }
        case .o:
            return [BlockPosition(row: 0, column: 0),
                   BlockPosition(row: 0, column: 1),
                   BlockPosition(row: 1, column: 0),
                   BlockPosition(row: 1, column: 1)]
        case .s:
            switch normalizedRotation {
            case 0, 2:
                return [BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 0, column: 2),
                       BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1)]
            case 1, 3:
                return [BlockPosition(row: 0, column: 0),
                       BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 2, column: 1)]
            default:
                return []
            }
        case .t:
            switch normalizedRotation {
            case 0:
                return [BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 1, column: 2)]
            case 1:
                return [BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 1, column: 2),
                       BlockPosition(row: 2, column: 1)]
            case 2:
                return [BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 1, column: 2),
                       BlockPosition(row: 2, column: 1)]
            case 3:
                return [BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 2, column: 1)]
            default:
                return []
            }
        case .z:
            switch normalizedRotation {
            case 0, 2:
                return [BlockPosition(row: 0, column: 0),
                       BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 1, column: 2)]
            case 1, 3:
                return [BlockPosition(row: 0, column: 1),
                       BlockPosition(row: 1, column: 0),
                       BlockPosition(row: 1, column: 1),
                       BlockPosition(row: 2, column: 0)]
            default:
                return []
            }
        }
    }
}

// Aktif tetris parçası
struct Tetromino {
    var type: TetrominoType
    var position: BlockPosition
    var rotation: Int = 0
    
    var blockPositions: [BlockPosition] {
        return type.blockOffsets(rotation: rotation).map { offset in
            BlockPosition(
                row: offset.row + position.row,
                column: offset.column + position.column
            )
        }
    }
    
    // Sola hareket
    func moveLeft() -> Tetromino {
        return Tetromino(
            type: type,
            position: BlockPosition(
                row: position.row,
                column: position.column - 1
            ),
            rotation: rotation
        )
    }
    
    // Sağa hareket
    func moveRight() -> Tetromino {
        return Tetromino(
            type: type,
            position: BlockPosition(
                row: position.row,
                column: position.column + 1
            ),
            rotation: rotation
        )
    }
    
    // Aşağı hareket
    func moveDown() -> Tetromino {
        return Tetromino(
            type: type,
            position: BlockPosition(
                row: position.row + 1,
                column: position.column
            ),
            rotation: rotation
        )
    }
    
    // Döndür
    func rotate() -> Tetromino {
        return Tetromino(
            type: type,
            position: position,
            rotation: rotation + 1
        )
    }
}

// Basit Tetris modeli
class TetrisGameModel: ObservableObject {
    static let boardWidth = 10
    static let boardHeight = 20
    
    @Published var gameBoard: [[Color?]] = Array(repeating: Array(repeating: nil, count: boardWidth), count: boardHeight)
    @Published var activePiece: Tetromino?
    @Published var score = 0
    @Published var level = 1
    @Published var linesCleared = 0
    @Published var gameOver = false
    @Published var isPaused = false
    
    private var timer: Timer?
    private var dropInterval: TimeInterval = 1.0
    
    init() {
        resetGame()
    }
    
    // Oyunu sıfırla
    func resetGame() {
        gameBoard = Array(repeating: Array(repeating: nil, count: Self.boardWidth), count: Self.boardHeight)
        score = 0
        level = 1
        linesCleared = 0
        gameOver = false
        isPaused = false
        
        createNewPiece()
        startTimer()
    }
    
    // Zamanlayıcıyı başlat
    private func startTimer() {
        timer?.invalidate()
        
        dropInterval = max(0.1, 1.0 - Double(level - 1) * 0.1)
        
        timer = Timer.scheduledTimer(withTimeInterval: dropInterval, repeats: true) { [weak self] _ in
            guard let self = self, !self.isPaused, !self.gameOver else { return }
            self.moveDown()
        }
    }
    
    func togglePause() {
        isPaused.toggle()
    }
    
    // Yeni parça oluştur
    func createNewPiece() {
        let randomType = TetrominoType.allCases.randomElement()!
        let startPosition = BlockPosition(
            row: 0,
            column: Self.boardWidth / 2 - 2
        )
        
        activePiece = Tetromino(type: randomType, position: startPosition)
        
        // Oyun bitti mi kontrol et
        if !canPlacePiece() {
            gameOver = true
            timer?.invalidate()
        }
    }
    
    // Parçanın geçerli bir konumda olup olmadığını kontrol et
    func canPlacePiece() -> Bool {
        guard let activePiece = activePiece else { return false }
        
        for position in activePiece.blockPositions {
            // Tahta sınırları dışında mı?
            if position.row < 0 || position.row >= Self.boardHeight ||
               position.column < 0 || position.column >= Self.boardWidth {
                return false
            }
            
            // Başka bir blokla çakışıyor mu?
            if position.row >= 0 && gameBoard[position.row][position.column] != nil {
                return false
            }
        }
        
        return true
    }
    
    // Parçayı sola hareket ettir
    func moveLeft() {
        guard !gameOver, !isPaused, let piece = activePiece else { return }
        
        let newPiece = piece.moveLeft()
        activePiece = newPiece
        
        if !canPlacePiece() {
            activePiece = piece // Geri al
        }
    }
    
    // Parçayı sağa hareket ettir
    func moveRight() {
        guard !gameOver, !isPaused, let piece = activePiece else { return }
        
        let newPiece = piece.moveRight()
        activePiece = newPiece
        
        if !canPlacePiece() {
            activePiece = piece // Geri al
        }
    }
    
    // Parçayı aşağı hareket ettir
    func moveDown() {
        guard !gameOver, !isPaused, let piece = activePiece else { return }
        
        let newPiece = piece.moveDown()
        activePiece = newPiece
        
        if !canPlacePiece() {
            activePiece = piece // Geri al
            lockPiece()
            clearLines()
            createNewPiece()
        }
    }
    
    // Parçayı döndür
    func rotatePiece() {
        guard !gameOver, !isPaused, let piece = activePiece else { return }
        
        let rotatedPiece = piece.rotate()
        activePiece = rotatedPiece
        
        if !canPlacePiece() {
            // Duvar tekme mekaniği
            
            // Sağa kaydır
            let kickedRight = Tetromino(
                type: rotatedPiece.type,
                position: BlockPosition(
                    row: rotatedPiece.position.row,
                    column: rotatedPiece.position.column + 1
                ),
                rotation: rotatedPiece.rotation
            )
            
            activePiece = kickedRight
            
            if !canPlacePiece() {
                // Sola kaydır
                let kickedLeft = Tetromino(
                    type: rotatedPiece.type,
                    position: BlockPosition(
                        row: rotatedPiece.position.row,
                        column: rotatedPiece.position.column - 2
                    ),
                    rotation: rotatedPiece.rotation
                )
                
                activePiece = kickedLeft
                
                if !canPlacePiece() {
                    // Yukarı kaydır
                    let kickedUp = Tetromino(
                        type: rotatedPiece.type,
                        position: BlockPosition(
                            row: rotatedPiece.position.row - 1,
                            column: rotatedPiece.position.column + 1
                        ),
                        rotation: rotatedPiece.rotation
                    )
                    
                    activePiece = kickedUp
                    
                    if !canPlacePiece() {
                        // Geri al
                        activePiece = piece
                    }
                }
            }
        }
    }
    
    // Parçayı hızla aşağı düşür
    func hardDrop() {
        guard !gameOver, !isPaused else { return }
        
        while true {
            guard let piece = activePiece else { break }
            
            let newPiece = piece.moveDown()
            activePiece = newPiece
            
            if !canPlacePiece() {
                activePiece = piece // Geri al
                lockPiece()
                clearLines()
                createNewPiece()
                break
            }
        }
    }
    
    // Parçayı sabitle
    private func lockPiece() {
        guard let activePiece = activePiece else { return }
        
        for position in activePiece.blockPositions {
            if position.row >= 0 && position.row < Self.boardHeight &&
               position.column >= 0 && position.column < Self.boardWidth {
                gameBoard[position.row][position.column] = activePiece.type.color
            }
        }
    }
    
    // Tamamlanan satırları temizle
    private func clearLines() {
        var linesCleared = 0
        
        for row in 0..<Self.boardHeight {
            if gameBoard[row].allSatisfy({ $0 != nil }) {
                // Satır dolu, sil
                gameBoard.remove(at: row)
                gameBoard.insert(Array(repeating: nil, count: Self.boardWidth), at: 0)
                
                linesCleared += 1
            }
        }
        
        if linesCleared > 0 {
            // Skor ekle
            let basePoints: Int
            switch linesCleared {
            case 1: basePoints = 100
            case 2: basePoints = 300
            case 3: basePoints = 500
            case 4: basePoints = 800
            default: basePoints = 0
            }
            
            score += basePoints * level
            self.linesCleared += linesCleared
            
            // Seviye kontrolü
            level = (self.linesCleared / 10) + 1
            
            // Hızı güncelle
            startTimer()
        }
    }
}

struct ContentView: View {
    @StateObject private var gameModel = TetrisGameModel()
    
    var body: some View {
        VStack {
            Text("Tetris Oyunu")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding(.vertical, 5)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Skor: \(gameModel.score)")
                        .font(.headline)
                    
                    Text("Seviye: \(gameModel.level)")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Satırlar: \(gameModel.linesCleared)")
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)
            
            // Oyun tahtası görünümü
            GameBoardView(gameModel: gameModel)
                .aspectRatio(CGFloat(TetrisGameModel.boardWidth) / CGFloat(TetrisGameModel.boardHeight), contentMode: .fit)
                .frame(maxWidth: 300)
                .padding()
                .border(Color.gray, width: 2)
                .overlay(
                    Group {
                        if gameModel.gameOver {
                            ZStack {
                                Color.black.opacity(0.5)
                                VStack {
                                    Text("Oyun Bitti!")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text("Skor: \(gameModel.score)")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding(.bottom)
                                    
                                    Button("Yeniden Başlat") {
                                        gameModel.resetGame()
                                    }
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                )
            
            // Üst kontrol düğmeleri
            HStack {
                Button(action: {
                    gameModel.togglePause()
                }) {
                    Text(gameModel.isPaused ? "Devam Et" : "Duraklat")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(gameModel.isPaused ? Color.green : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button(action: {
                    gameModel.rotatePiece()
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.purple)
                }
                
                Spacer()
                
                Button(action: {
                    gameModel.hardDrop()
                }) {
                    Image(systemName: "arrow.down.to.line.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 20)
            
            // Alt kontrol düğmeleri
            HStack {
                Button(action: {
                    gameModel.moveLeft()
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button(action: {
                    gameModel.moveDown()
                }) {
                    Image(systemName: "arrow.down.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button(action: {
                    gameModel.moveRight()
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
        }
        .padding()
    }
}

// Oyun tahtası görünümü
struct GameBoardView: View {
    @ObservedObject var gameModel: TetrisGameModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<TetrisGameModel.boardHeight, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<TetrisGameModel.boardWidth, id: \.self) { column in
                        cellAt(row: row, column: column)
                    }
                }
            }
        }
    }
    
    // Belirli bir hücrenin görünümünü oluştur
    private func cellAt(row: Int, column: Int) -> some View {
        // Sabit bloklar
        if let color = gameModel.gameBoard[row][column] {
            return AnyView(
                Rectangle()
                    .fill(color)
                    .border(Color.black.opacity(0.2), width: 0.5)
            )
        }
        
        // Aktif parça
        if let activePiece = gameModel.activePiece {
            for position in activePiece.blockPositions {
                if position.row == row && position.column == column {
                    return AnyView(
                        Rectangle()
                            .fill(activePiece.type.color)
                            .border(Color.white.opacity(0.2), width: 0.5)
                    )
                }
            }
        }
        
        // Boş hücre
        return AnyView(
            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .border(Color.gray.opacity(0.2), width: 0.5)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
