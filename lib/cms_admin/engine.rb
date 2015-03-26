require 'devise'
module CmsAdmin
  class Engine < ::Rails::Engine
    isolate_namespace CmsAdmin
  end
end
