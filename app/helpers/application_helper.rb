module ApplicationHelper
  def document_title
    [page_title, I18n.t('site_name')].compact.join(' / ')
  end

  def page_title(title = nil)
    @page_title ||= I18n.t("page_title.#{controller_name}.#{action_name}", :title => title).html_safe
  end
end
