# -*- coding: utf-8 -*-
class CheckUpdateController < ApplicationController
  before_filter :authenticate_user! , :except => [:check_updates, :index, :redirect]
  @index_popular_limit = 10
  @index_persons_limit  = 10

  def index
    @populars = Url.get_popular_urls #(@index_popular_limit,0)
    if current_user
      @histories = current_user.get_lists.limit(@index_persons_limit)
    end
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
  def add_url_form
  end

  # URLの追加
  def add_url
    current_user.add_urls params[:urls]
    redirect_to :controller => :check_update , :action => :index
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

  end

  def delete
    current_user.remove_url(params[:id])
    redirect_to(:controller => :check_update , :action => :delete_list )
  end

  # ログアウト
  def logout
    p current_user
    destroy_user_session_path
    p current_user
    redirect_to :action => :index
  end

end
