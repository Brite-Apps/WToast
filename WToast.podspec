#
#  Be sure to run `pod spec lint WToast.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "WToast"
  s.version      = "1.0"
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
  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/Brite-Apps/WToast.git", :tag => "1.0" }
  s.source_files  = "WToast"

  s.requires_arc = true

end
