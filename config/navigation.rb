# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'selected active'
  navigation.active_leaf_class = 'active'
  # navigation.autogenerate_item_ids = false
  #
  navigation.items do |primary|
    li_class = 'v-btn ripple'
    search_class = "search_save"
    about_class = request.url == root_url ? "selected active" : ""

    # puts "params[:search] #{params[:search]}"
    s_params = {}
    s_params[:search] = params[:search] if params[:search].present?

    primary.item :about, 'План', schedule_index_path, html: {class: "#{li_class}"} if is_admin?
    primary.item :about, 'Обо мне', static_index_path, html: {class: "#{search_class} #{about_class} #{li_class}"}
    primary.item :posts, 'Блог', blogs_path, html: {class: "li_class"}, link_html: {class: "my_a_class"}
    primary.item :contact, 'Контакты', contacts_index_path
    #
    #
    #
    # if current_user.has_role?(:manager)
    #   primary.item :options,  content_tag(:span), options_path, html: {class: 'li-right options', title: 'Настройки'}
    # end
    #
    # if current_user.admin?
    #   # primary.item :options,  content_tag(:span), options_path, html: {class: 'li-right options', title: 'Настройки'}
    #   primary.item :develops, content_tag(:span), develops_path, html: {class: 'li-right develops',title: 'Разработка', }
    #   primary.item :charts1,  content_tag(:span), statistics_path, html: {class: 'li-right', title: 'Статистика'}
    #   primary.item :history,  content_tag(:span), history_index_path, html: {class: 'li-right', title: 'История'}
    # end

    primary.dom_class = 'nav'
  end
end

