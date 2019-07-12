Pod::Spec.new do |s|
s.name        = 'CTool'
s.version     = '1.1.4'
s.authors     = { 'CYC666' => '13705038428@163.com@163.com' }
s.homepage    = 'https://github.com/CYC666/CTool'
s.summary     = 'a tool for CYC666'
s.source      = { :git => 'https://github.com/CYC666/CTool.git', :tag => s.version }
s.license     = { :type => "MIT", :file => "LICENSE" }

s.platform = :ios, '11.0'
s.requires_arc = true
s.source_files = 'CTool'
s.public_header_files = 'CTool/*.h'

s.ios.deployment_target = '7.0'


s.resources = 'CTool/CToolImages.bundle'


end
