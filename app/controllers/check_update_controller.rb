# -*- coding: utf-8 -*-
class CheckUpdateController < ApplicationController
  before_filter :authenticate_user! , :except => [:check_updates, :index, :redirect, :ranking]
  INDEX_POPULAR_LIMIT = 10
  INDEX_PERSONS_LIMIT = 10

  def index
    @populars = Url.get_popular_urls.limit(INDEX_POPULAR_LIMIT).offset(0)
    if current_user
      @histories = current_user.get_lists.limit(INDEX_PERSONS_LIMIT)
      his = current_user.get_lists
      @url_ids = his.map{|hist| hist[:url_id]}
    end
    @url_ids ||= []
  end

  def show
    @histories = current_user.get_lists
  end

  # 指定アドレスへ飛ぶ
  def redirect
    url_id = params[:url_id]
    url = params[:url]
    current_user.update_check(url_id) if current_user
    redirect_to(url)
  end
  
  # 新規URLの入力
  def add_url_for
  end

  # URLの追加
  # FIXME : controllerにコードを書いたらアカンやろ。。。
  def add_url
    current_user.add_urls params[:urls]
    redirect_to :controller => params[:controller], :action => params[:origin_action] || :index
  end

  #　更新のチェック
  def check_updates
    Url.find(:all).each do |url|
      url.check_update
    end
    redirect_to(:controller => :check_update , :action => :index )
  end
  
  def delete_list
    @histories = current_user.get_delete_list
    if current_user
      @histories = current_user.get_lists
      @url_ids = @histories.map{|hist| hist[:url_id]}
    end
  end

  def delete
    current_user.remove_url(params[:id])
    redirect_to(:controller => :check_update , :action => :delete_list )
  end

  # ログアウト
  def logout
    destroy_user_session_path
    redirect_to :action => :index
  end

  def ranking
    @populars = Url.get_popular_urls
    if current_user
      @histories = current_user.get_lists
      @url_ids = @histories.map{|hist| hist[:url_id]}
    end
    @url_ids ||= []
  end

end
