# -*- coding: utf-8 -*-
class Url < ActiveRecord::Base
  has_many :check_history
  has_and_belongs_to_many :users
  
  def self.update_all
    urls = self.find(:all)
    urls.each do |url|
      url.check_update
    end
  end

  def self.update_titles
    process_html = ProcessHTML.new
    urls = self.find(:all)
    urls.each do |url|
      begin
        title,source = process_html.get_title_and_sanitize_source(url.url)
        url[:title] = title 
        url.save
      rescue;end
    end
  end

  # 更新をチェックし、last_crawlを更新する
  # 内容が更新されていればURLのsource,last_updateを更新する。
  def check_update
    process_html = ProcessHTML.new
    sani_source = process_html.get_sanitize_source(self.url)
    now = DateTime.now
    self.last_crawl = now - Rational(1, 24 * 60 * 60)
    if sani_source != self.context
      self.last_update = now
      self.context = sani_source
    end
    self.save!
  end


  ## 登録数の多い件数を表示する。
  def Url.get_popular_urls
    return self.
      select("count(*),urls.id,urls.url,urls.title ").
      joins("INNER JOIN check_histories on check_histories.url_id=urls.id").
      group("urls.id").
      order("count(*) desc")
#      CheckHistory.
#      select("check_histories.url_id,count(*) as count,check_histories.title,urls.url as url").
#      joins("INNER JOIN urls on check_histories.url_id=urls.id").
#      order("count(*)")
  end
  
end
