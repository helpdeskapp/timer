require 'rails_helper'

describe ApplicationHelper do
  it '#page_title' do
    expect(helper.page_title).to eq I18n.t('page_title.test')
  end

  it '#document_title' do
    expect(helper.document_title).to eq "#{I18n.t('page_title.test')} / #{I18n.t('site_name')}"
  end
end
