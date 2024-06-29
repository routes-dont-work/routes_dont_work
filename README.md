**Rails 7.1 has added `rails routes --unused` which does the same thing as routes_dont_work. We suggest you use that instead now.**

---

routes_dont_work provides a test to ensure that all the routes in your Rails app actually route to something. In
particular, it tests that:

- The referenced controller exists.
- The controller has a public method named the same as the action, or a view exists in the view lookup path for that
controller.

A very common case of broken routes is the use of RESTful routes without defining all the actions (index, show, new, create, edit, update, and destroy). If you don't need all of these actions, you can use the [`only` and `except` options of the `resources` block](http://guides.rubyonrails.org/routing.html#restricting-the-routes-created).

After routes_dont_work identifies these routes, you should fix or remove them. Be careful if removing, because if, for example, you have a view that generates a link with the broken route, removing the route without removing the reference will make the view raise an exception.

## Usage

Include routes_dont_work in your Gemfile in the 'test' group.
```ruby
group :test do
  gem 'routes_dont_work'
end
```

For rspec, include the 'routes_dont_work' shared example in one of your tests, for example:

```ruby
require 'spec_helper'
require 'routes_dont_work/rspec'

describe 'routes' do
  include_examples 'routes_dont_work'
end
```

If this was in routes.rb,

```ruby
  get 'this_doesnt_exist' => 'fake_controller/fake_action'
```

your test suite would fail with:

```
Failures:

  1) routes has no broken routes
     Failure/Error: expect(RoutesDontWork::RouteChecker.get_broken_routes(Rails.application)).to be_empty
       expected `[{:action=>"this_doesnt_exist", :controller=>"fake_controller/fake_action", :path=>"/this_doesnt_exist(.:format)"}].empty?` to return true, got false
     Shared Example Group: "routes_dont_work" called from ./spec/controllers/routes_spec.rb:5
     # ~/routes_dont_work/lib/routes_dont_work/rspec.rb:5:in `block (2 levels) in <top (required)>'
```


## Limitations

- routes_dont_work will only check the existence of the controller/action/view. It will not guarantee that any request for
the routes will succeed.
- Your app may have special dynamic craziness that can confuse routes_dont_work. You should verify that what
routes_dont_work says is true.
- routes_dont_work currently only works with rspec. Feel free to contribute changes to support other frameworks.
