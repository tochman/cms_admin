module CmsAdmin
  module ApplicationHelper
    def nav_link_to(*args, &block)
      a1, a2 = *args
      if block
        link_path = a1
        link_id = a2
        #recognized = Rails.application.routes.recognize_path(link_path)
        #class_name = (recognized[:controller] == params[:controller] && recognized[:action] == params[:action]) ? 'active' : ''
        binding.pry
        class_name = current_page?(link_path) ? 'active' : ''
        content_tag(:li, class: class_name) do
          link_to link_path, {remote: true, id: link_id}, {}, &block
        end
      else
        link_text = a1
        link_path = a2
        class_name = current_page?(link_path) ? 'active' : ''
        content_tag(:li, class: class_name) do
          link_to link_text, link_path, remote: true
        end
      end
    end

  end

end
