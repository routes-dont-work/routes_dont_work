module RoutesDontWork
  class RouteChecker
    class << self
      def get_broken_routes(app)
        broken_routes = app.routes.routes.select do |r|
          controller_name = r.defaults[:controller].try(:camelize)

          # There's some built-in Rails ones like /assets that have no controller. Ignore those.
          next false if controller_name.nil?

          action_name = r.defaults[:action]

          begin
            controller_class = (controller_name + 'Controller').constantize
          rescue NameError
            # Controller doesn't exist
            next true
          end

          # Controller exists, but action doesn't? Note that this correctly handles cases where there is no method on a
          # controller, but a view exists at the right place.
          next controller_class.new.method_for_action(action_name).nil?
        end

        # Just to get a readable error if it fails
        broken_routes.map!{|r| r.defaults.merge(path: r.path.spec.to_s)}

        return broken_routes
      end
    end
  end
end
