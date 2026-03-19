class Kafein < Formula
  desc "Minimalist macOS menu bar app to prevent sleep"
  homepage "https://github.com/ohtufan/kafein"
  url "https://github.com/ohtufan/kafein/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "f7b29175d476b0f04e90219a150bc3aeb66aabb2f35bad3e7b4981ab566d3d10"
  license "MIT"

  depends_on xcode: ["15.0", :build]
  depends_on macos: :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    app_bundle = "#{prefix}/Kafein.app/Contents"
    mkdir_p "#{app_bundle}/MacOS"
    mkdir_p "#{app_bundle}/Resources"

    cp ".build/release/Kafein", "#{app_bundle}/MacOS/Kafein"
    cp "Resources/Info.plist", "#{app_bundle}/"
    cp "Resources/AppIcon.icns", "#{app_bundle}/Resources/"
  end

  def caveats
    <<~EOS
      Kafein is an unsigned app. On first launch:
        Right-click Kafein.app → Open → Open

      To start Kafein:
        open #{prefix}/Kafein.app
    EOS
  end

  test do
    system "swift", "build"
  end
end
