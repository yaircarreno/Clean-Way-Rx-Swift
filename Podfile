use_frameworks!
platform :ios, '11.0'

def rxswift
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
end

def testing_rxswift
  pod 'RxBlocking', '~> 5'
  pod 'RxTest', '~> 5'
end

target 'CleanWayRx' do

  # core RxSwift
  rxswift

  target 'CleanWayRxTests' do
    inherit! :search_paths
    # Pods for testing
    testing_rxswift
  end

  target 'CleanWayRxUITests' do
    inherit! :search_paths
    # Pods for testing
    testing_rxswift
  end
end
