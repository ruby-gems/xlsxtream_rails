module XlsxtreamRails
  class Railtie < ::Rails::Railtie
    initializer "xlsxtream_rails.initialization" do
      ActiveSupport.on_load(:action_controller) do
        require "xlsxtream_rails/action_controller"
      end
    end
  end
end
