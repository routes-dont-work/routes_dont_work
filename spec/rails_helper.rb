require 'spec_helper'

require 'action_controller'
require 'action_view'
require 'rails'

require 'support/rails_app/config/environment'

# Rails normally handles this, not sure what we're missing in our fake app that makes us handle it.
require 'support/rails_app/app/controllers/resources_controller'
ResourcesController.view_paths = 'spec/support/rails_app/app/views'

require 'rspec/rails'

require 'routes_dont_work'
