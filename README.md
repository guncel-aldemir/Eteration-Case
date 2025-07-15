# Eteration-Case
## 🚀 Özellikler

- 🏠 Ana ekranda ürün listeleme (infinite scroll ile)
- 🔍 Filtreleme (çoklu seçimli marka & model)
- ⭐ Ürün favorileme & favori ekranı
- 🛒 Sepet işlemleri (ekle, azalt, sil)
- 📦 Detay ekranından sepete ekleme
- 📳 NotificationCenter ile canlı veri güncellemesi
- 🧪 Unit Test desteğiyle güvenilir kod tabanı

---

## 🧱 Kullanılan Mimariler & Tasarım Kalıpları

- **MVVM (Model-View-ViewModel)**
- **Coordinator Pattern** (navigasyonun merkezi yönetimi)
- **UseCase & Repository Pattern** (iş katmanı ayrımı)
- **CoreData** (offline veri saklama)
- **NotificationCenter** (event tabanlı iletişim)
- **Dependency Injection** (ScreenFactory & AppFactory üzerinden)

---

## 🧪 Test Altyapısı

Uygulama, aşağıdaki ViewModel’lere özel **unit test** yapıları içerir:

- ✅ `HomeViewModelTests`
- ✅ `DetailViewModelTests`
- ✅ `CartViewModelTests`

Tüm UseCase katmanları **Mock** ve **Dummy** sınıflar üzerinden test edilebilir hâle getirilmiştir. `@testable import` ve `MockProductRepository`, `MockProductCoreDataRepository` gibi örneklerle kolayca genişletilebilir.

