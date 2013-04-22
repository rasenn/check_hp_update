# -*- coding: utf-8 -*-
class CheckUpdateController < ApplicationController
  before_filter :authenticate_user! , :expect => [:check_updates]

  def index
    @histories = current_user.get_lists
  end

  # アドレスへ飛ぶ
  def show
    url_id = params[:url_id]
    url = params[:url]
    current_user.update_check(url_id)
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
    destroy_user_session_path
    render_to :action => :index
  end

end
