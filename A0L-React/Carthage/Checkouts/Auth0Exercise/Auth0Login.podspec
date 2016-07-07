Pod::Spec.new do |s|
  s.name         = "Auth0Login"
  s.version      = "1.0.2"
  s.summary      = "Two flavors of Auth0 Login"

  s.description  = <<-DESC
  	The Auth0Login exercise simply implements two Auth0 user authentication approaches. One is a simple username/password 		login; the other uses Auth0's Passwordless to authenticate users with an email address and a passcode. The interface allows toggling of two different color schemes and two different font sizes. 
                   DESC
  s.homepage     = "https://github.com/weien/Auth0Exercise"
  s.license      = { :type => "MIT", :file => "License.md" }
  s.author             = { "Weien Wang" => "weienw@gmail.com" }
  s.social_media_url   = "http://twitter.com/weienw"
  s.platform     = :ios,  "9.3"
  s.source       = { :git => "https://github.com/weien/Auth0Exercise.git", :tag => "1.0.2" }
  s.source_files  = "Auth0Login/Auth0Login"
  s.resources = "Auth0Login/Auth0Login/Assets.xcassets"
  s.requires_arc = true

end
