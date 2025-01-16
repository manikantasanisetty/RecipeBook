import SwiftUI

struct CachedImageView: View {
    @State private var uiImage: UIImage? = nil

    let url: URL
    
    var body: some View {
        ZStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .onAppear(perform: loadImage)
    }

    private func loadImage() {
        if let cachedImage = ImageCache.shared.image(for: url) {
            uiImage = cachedImage
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    ImageCache.shared.setImage(image, for: url)
                    DispatchQueue.main.async {
                        self.uiImage = image
                    }
                }
            } catch {
                print("Error loading image: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Loaded image
        CachedImageView(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!)
            .frame(width: 150, height: 150)

        // Invalid URL (placeholder image)
        CachedImageView(url: URL(string: "https://invalid.url.com")!)
            .frame(width: 150, height: 150)
    }
    .padding()
}
