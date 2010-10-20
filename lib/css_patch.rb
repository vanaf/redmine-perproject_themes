require_dependency 'redmine/themes'

module CSSPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
 
    base.class_eval do
      alias_method_chain :path_to_stylesheet, :perproject
    end
  end
  
  module InstanceMethods
    # Adds a rates tab to the user administration page
    def path_to_stylesheet_with_perproject(source)

      th = String.new(Setting.ui_theme)
      if not @project.nil?
        projecttheme = "#{RAILS_ROOT}/public/themes/#{@project.identifier}"
        if File.exists?(projecttheme)
          th = @project.identifier
        end
      end
      @current_theme ||= Redmine::Themes.theme(th)
      stylesheet_path((@current_theme && @current_theme.stylesheets.include?(source)) ?
        "/themes/#{@current_theme.dir}/stylesheets/#{source}" : source)

    end
    
  end
end


ApplicationHelper.send(:include, CSSPatch)