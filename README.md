# SwiftUI Tetris Oyunu

Bu proje, Swift ve SwiftUI kullanılarak geliştirilen klasik Tetris oyununun modern bir versiyonudur. iOS cihazlar için tasarlanmış olup, dokunmatik kontroller ve şık bir kullanıcı arayüzüne sahiptir.

## Özellikler

- Modern SwiftUI arayüzü
- Klasik Tetris parçalarının tamamı (I, J, L, O, S, T, Z)
- Parça döndürme ve hareket ettirme
- Seviye sistemi ve hızlanma mekanizması
- Tamamlanan satırları temizleme
- Skor takibi
- Duraklatma ve devam ettirme
- Oyun sonu ekranı
- Yeniden başlatma seçeneği

## Gereksinimler

- iOS 15.0 veya üzeri
- Xcode 13.0 veya üzeri
- Swift 5.5 veya üzeri

## Kurulum

1. Bu repository'yi klonlayın:
   ```bash
   git clone https://github.com/esersolmaz/Tetris.git
   ```

2. Xcode'da projeyi açın:
   ```bash
   cd Tetris
   open Tetris.xcodeproj
   ```

3. Projeyi derleyin ve çalıştırın:
   - Xcode içinde ▶️ (Play) butonuna tıklayın
   - Veya ⌘+R tuş kombinasyonunu kullanın

## Nasıl Oynanır

1. Oyunu başlattığınızda, rastgele bir Tetris parçası ekranın üst kısmında görünecektir.
2. Parçayı hareket ettirmek için:
   - Sol/Sağ butonları: Parçayı yatay hareket ettirir
   - Aşağı butonu: Parçayı daha hızlı düşürür
   - Döndürme butonu: Parçayı saat yönünde döndürür
   - Hızlı düşürme butonu: Parçayı hemen en alt konuma düşürür
3. Parçalar, altlarındaki dolu hücrelerde veya oyun tahtasının alt kısmında durur.
4. Bir satır tamamen dolduğunda, o satır temizlenir ve üzerindeki tüm bloklar bir satır aşağı iner.
5. Satır temizledikçe skor kazanırsınız ve belirli bir satır sayısına ulaştığınızda seviye atlarsınız.
6. Seviye yükseldikçe, parçalar daha hızlı düşmeye başlar.
7. Parçalar ekranın üst kısmına ulaştığında oyun sona erer.

## Proje Yapısı

Proje aşağıdaki ana bileşenlerden oluşur:

- **TetrisApp**: Uygulamanın giriş noktası
- **ContentView**: Ana oyun görünümü
- **TetrisGameModel**: Oyun mantığını içeren model
- **BlockPosition**: Blok konumlarını temsil eden veri yapısı
- **TetrominoType**: Tetris parçası tiplerini ve özelliklerini tanımlayan enum
- **Tetromino**: Aktif Tetris parçasını temsil eden yapı
- **GameBoardView**: Oyun tahtasını gösteren görünüm

## Özelleştirme

Oyunu kendi zevkinize göre aşağıdaki şekillerde özelleştirebilirsiniz:

1. Oyun tahtası boyutlarını değiştirmek için:
   ```swift
   static let boardWidth = 10 // İstediğiniz genişlik
   static let boardHeight = 20 // İstediğiniz yükseklik
   ```

2. Parça renklerini değiştirmek için:
   ```swift
   var color: Color {
       switch self {
       case .i: return .cyan // İstediğiniz rengi kullanabilirsiniz
       // Diğer parçalar için...
       }
   }
   ```

3. Düşüş hızını değiştirmek için:
   ```swift
   dropInterval = max(0.1, 1.0 - Double(level - 1) * 0.1) // Katsayıları değiştirebilirsiniz
   ```

## Bilinen Sorunlar

- iOS simülatöründe veya bazı fiziksel cihazlarda beyaz ekran sorunu oluşabilmektedir. Bu durum araştırılmaktadır.
- Yüksek skor henüz yerel olarak kaydedilmemektedir.

## Gelecek Güncellemeler

- Ses efektleri ve müzik
- Yüksek skor tablosu
- Tema seçenekleri (Koyu/Açık mod)
- Gelişmiş animasyonlar
- Daha fazla oyun modu

## Katkıda Bulunma

1. Bu repository'yi fork edin
2. Kendi branch'inizi oluşturun: `git checkout -b yeni-ozellik`
3. Değişikliklerinizi commit edin: `git commit -m 'Yeni özellik eklendi'`
4. Branch'inizi push edin: `git push origin yeni-ozellik`
5. Bir Pull Request oluşturun

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Daha fazla bilgi için `LICENSE` dosyasına bakın.

## İletişim

Sorularınız veya geri bildirimleriniz için [GitHub Issues](https://github.com/esersolmaz/Tetris/issues) üzerinden iletişime geçebilirsiniz.

---

Geliştirici: [İsminiz]  
Tarih: [Geliştirme Tarihi]

*Not: Bu proje, klasik Tetris oyununun modern bir versiyonunu oluşturmak amacıyla Swift ve SwiftUI öğrenmek için yapılmıştır.*
