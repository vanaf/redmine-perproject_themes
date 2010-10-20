
require 'redmine'

#require 'application'

class CssAdderHooks  < Redmine::Hook::ViewListener
  ApplicationController.before_filter :user_setup
  def view_layouts_base_html_head(context = { })
    ret=''
    project = context[:project]
    baseurl = url_for(:controller => 'wiki', :action => 'index', :id => project) + '/../../..'
    if not project.nil?
      if not User.current.member_of?(project)
        if File.exists?("#{RAILS_ROOT}/public/themes/#{project.identifier}/stylesheets/non_member.css")
          ret+= stylesheet_link_tag(baseurl + "/themes/#{project.identifier}/stylesheets/non_member.css")
        end
      end
      if File.exists?("#{RAILS_ROOT}/public/themes/#{project.identifier}/js/project.js")
        ret+=javascript_include_tag(baseurl + "/themes/#{project.identifier}/js/project.js")
      end

    end
    return ret
  end

  def view_layouts_base_content(context = { })
    controller = context[:controller]
    if not controller.nil?
      if controller.instance_of?AccountController
	params = controller.params
	action = params[:action]
        if action == 'login'
	  return "<br><center><h4>Для входа рекомендуется использовать аккаунты в домене MAIN.</h4> Если вы студент/стажер/сотрудник СГУ вы можете их получить обратившись в ПРЦНИТ или к администраторам ВЦ. Если же вы не имеете никакого отношения к СГУ вы можете <a href='/redmine/account/register'>зарегистрироваться в Redmine</a></center>"
        end
        if action == 'register'
          return "<br><center><h4>Если у вас есть аккаунт в домене MAIN <a href='/redmine/login'>войдите используя его</a>.</h4> Если вы студент/стажер/сотрудник СГУ вы можете его получить обратившись в ПРЦНИТ или к администраторам ВЦ. Если же вы не имеете никакого отношения к СГУ вы можете тут зарегистрироваться.</center>"
        end

      end
    end
  end


end
