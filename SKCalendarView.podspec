Pod::Spec.new do |s|
  s.name         = "SKCalendarView"
  s.version      = "0.0.6"
  s.summary      = "a custom calendarView"
  s.description  = <<-DESC
                  a custom calendarView on iOS
                   DESC
  s.homepage     = "https://github.com/shevakuilin/SKCalendarView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "ShevaKuilin" => "shevakuilin@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/shevakuilin/SKCalendarView.git", :tag => "0.0.6" }
  s.source_files  = "Source/SKCalendarView/**/*.{h,m}"
  s.dependency "Masonry", "~> 1.0.1"

end
