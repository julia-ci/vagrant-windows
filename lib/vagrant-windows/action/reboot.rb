module VagrantPlugins
  module Windows
    module Action
      class Reboot
        def initialize(app, env)
            @app = app
        end
        
        def call(env)
            @app.call(env)
            
            env[:vm].guest.reboot!
        end
      end
    end
  end
end
        
