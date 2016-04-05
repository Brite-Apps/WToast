Pod::Spec.new do |s|
  s.name         = "WToast"
  s.version      = "2.0.1"
  s.summary      = "Simple info box for iOS inspired by Android Toast."

  s.description  = <<-DESC
                   WToast is a simple info box for iOS inspired by Android Toast.

                   - Show toast object with custom text
				   - Show toast object with custom image
                   DESC

  s.homepage     = "https://github.com/Brite-Apps/WToast"
  s.license      = { :type => "Public Domain (Unlicense)", :file => "UNLICENSE" }

  s.author             = { "Nik Dyonin" => "nik@brite-apps.com" }

  s.platform     = :ios
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/Brite-Apps/WToast.git", :tag => "2.0.1" }
  s.source_files  = "WToast"

  s.requires_arc = true

end
