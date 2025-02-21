Pod::Spec.new do |spec|
    spec.name = 'Ramp'
    spec.version = '2.0.0'
    spec.license = 'proprietary'
    spec.summary = 'Ramp SDK for iOS'
    spec.homepage = 'https://ramp.network/'
    spec.authors = { 'Ramp Network' => 'dev@ramp.network' }
    spec.source = { :git => 'https://github.com/argentlabs/ramp-sdk-ios', :tag => spec.version }
    spec.ios.deployment_target  = '11.0'
    spec.source_files = 'Sources/Ramp/*.swift'
    spec.dependency 'Passbase', '~> 2.7.4'
end
