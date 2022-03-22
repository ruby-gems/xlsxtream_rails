module XlsxtreamRails
  class Railtie < ::Rails::Railtie
    initializer "xlsxtream_rails.initialization" do
      ActiveSupport.on_load(:action_view) do
        require "xlsxtream_rails/template_handler"
        ActionView::Template.register_template_handler :xrb, ActionView::Template::Handlers::XrbBuilder.new
      end

      ActiveSupport.on_load(:action_controller) do
        require "xlsxtream_rails/action_controller"
      end
    end
  end
end
