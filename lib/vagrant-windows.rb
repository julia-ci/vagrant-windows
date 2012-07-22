require "vagrant"

module VagrantPlugins
  module GuestWindows
    class Plugin < Vagrant.plugin("1")
    name "Windows guest"
    description "Support Windows guests and WinRM comm channel"  
      
    #Add Windows Guest Defintion  
    guest("windows") do
        require File.expand_path("../vagrant-windows/guest/windows", __FILE__)
        VagrantPlugins::Windows::Guest::Windows
    end
    
    #Add Configuration Items
    config("windows") do
        require File.expand_path("../vagrant-windows/config/windows", __FILE__)
        Vagrant::Config::Windows
    end
    config("winrm") do
        require File.expand_path("../vagrant-windows/config/winrm", __FILE__)
        Vagrant::Config::WinRM
    end
    
    action_hook(:up) do |seq|
        require File.expand_path("../vagrant-windows/action/reboot", __FILE__)
        seq.insert(Vagrant::Action::VM::HostName,VagrantPlugins::Windows::Action::Reboot)
    end

    # Add WinRM Communication Channel
    require File.expand_path('../vagrant-windows/communication/winrm',__FILE__)

    #Monkey Patch the VM object to support multiple channels
    require File.expand_path('../vagrant-windows/monkey_patches/vm',__FILE__)

    #Monkey Patch the driver to support returning a mapping of mac addresses to nics
    require File.expand_path('../vagrant-windows/monkey_patches/driver',__FILE__)

    require File.expand_path('../vagrant-windows/winrm',__FILE__)

    #Errors are good
    require File.expand_path('../vagrant-windows/errors',__FILE__)
    end
  end
end
