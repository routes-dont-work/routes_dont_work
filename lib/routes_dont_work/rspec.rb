require 'routes_dont_work/route_checker'

RSpec.shared_examples "routes_dont_work" do
  it 'has no broken routes' do
    expect(RoutesDontWork::RouteChecker.get_broken_routes(Rails.application)).to be_empty
  end
end