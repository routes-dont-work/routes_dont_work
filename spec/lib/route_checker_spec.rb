require 'rails_helper'

describe RoutesDontWork::RouteChecker do

  context 'non-RESTful actions' do
    context 'route to an action defined in the controller' do
      before do
        RailsApp::Application.routes.draw do
          get 'controller_defined_action' => 'resources#controller_defined_action'
        end
      end

      it 'does not flag it as broken' do
        expect(described_class.get_broken_routes(RailsApp::Application)).to be_empty
      end
    end

    context 'route to a view-only action' do
      before do
        RailsApp::Application.routes.draw do
          get 'view_defined_action' => 'resources#view_defined_action'
        end
      end

      it 'does not flag it as broken' do
        expect(described_class.get_broken_routes(RailsApp::Application)).to be_empty
      end
    end

    context 'route to an action not defined by the controller or a view' do
      before do
        RailsApp::Application.routes.draw do
          get 'undefined_action' => 'resources#undefined_action'
        end
      end

      it 'does flag it as broken' do
        expect(described_class.get_broken_routes(RailsApp::Application)).to_not be_empty
      end
    end
  end

  context 'RESTful actions' do
    context 'route to an action defined in the controller' do
      before do
        RailsApp::Application.routes.draw do
          resources :resources, only: :show
        end
      end

      it 'does not flag it as broken' do
        expect(described_class.get_broken_routes(RailsApp::Application)).to be_empty
      end
    end

    context 'route to a view-only action' do
      before do
        RailsApp::Application.routes.draw do
          resources :resources, only: :edit
        end
      end

      it 'does not flag it as broken' do
        expect(described_class.get_broken_routes(RailsApp::Application)).to be_empty
      end
    end

    context 'route to an action not defined by the controller or a view' do
      before do
        RailsApp::Application.routes.draw do
          resources :resources, only: :index
        end
      end

      it 'does flag it as broken' do
        expect(described_class.get_broken_routes(RailsApp::Application)).to_not be_empty
      end
    end
  end
end
