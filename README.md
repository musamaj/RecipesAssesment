# 🍽️ Recipe App (SwiftUI + Async/Await + MVVM)

## 📸 Summary

This SwiftUI app displays a list of recipes fetched from a remote API. It supports:

- Pull-to-refresh for reloading recipes
- Graceful handling of empty and malformed data responses
- Custom disk image caching (no URLCache or third-party libs)
- MVVM architecture with `async/await`
- Unit testing for core logic (`RecipeService`, ViewModel)

### Screenshots

| List View | Error State | Empty State |
|-----------|-------------|-------------|
| <img src="https://github.com/user-attachments/assets/e9441f39-c630-4c07-aff6-1ec0004e817f" width="250"/> | <img src="https://github.com/user-attachments/assets/97c48741-9ec3-4ed4-af33-889994eeb831" width="250"/> | <img src="https://github.com/user-attachments/assets/597c38c7-49fa-4cbf-a5bf-0c2e08d5a6ee" width="250"/> |



## 🎯 Focus Areas

I prioritized:

- ✅ **Async/Await Networking**: All API calls are built using structured concurrency.
- ✅ **Disk Image Caching**: Images are cached manually to disk to minimize bandwidth, not relying on `URLCache`.
- ✅ **Error Handling**: The app discards all recipes if the JSON is malformed and gracefully shows an error.
- ✅ **MVVM Architecture**: Separates UI, business logic, and networking for testability and clarity.
- ✅ **Testability**: Focused unit tests on `RecipeService`, ViewModel behavior

---

## ⏱ Time Spent

**Total: ~5-6 hours**

| Task | Time Allocation |
|------|-----------------|
| Core features (UI, networking, state mgmt) | ~2 hrs |
| Custom image caching logic | ~2 hrs |
| Error handling + malformed/empty data scenarios | ~1.5 hrs |
| Unit testing (service + caching + ViewModel) | ~1 hrs |

---

## ⚖️ Trade-offs and Decisions

- ❌ Did not implement pagination or search to keep the scope aligned with core requirements.
- ✅ Used `@StateObject` and `.task` with flags to avoid repeated API calls on re-render.

---

## ❗️Weakest Part of the Project

- The **custom image caching** implementation is functional but basic. It could be improved further with:
  - LRU cache strategy
  - Better directory management
- UI is minimal — no animations or advanced layout enhancements due to time scope.

---

## 🔍 Additional Information

- **SwiftUI Lifecycle**: Used `.task` with a local flag (`hasLoaded`) to avoid multiple API calls during view re-renders.
- **Test Endpoints**:
  - Malformed: gracefully discards and shows error
  - Empty: shows a user-friendly message
- **No External Libraries** were used, per the assignment guideline.
- **Platform**: macOS 14+, iOS 17+

---
