# -*- coding: utf-8 -*-
require "date"

class User < ActiveRecord::Base
  has_many :check_history
  has_and_belongs_to_many :urls

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def add_urls(urls)
    urls.each_line do |line|
      line = line.chomp
      if line.size > 0
        add_url(line)
      end
    end
  end

  # URLの追加
  def add_url(url)
    url = remove_last_slash(url)
    
    begin
      ActiveRecord::Base::transaction() do
        db_url = Url.find(:first , :conditions => [" url = ?", url])
	
        now = DateTime.now

        process_html = ProcessHTML.new("UTF-8")
        title,source = process_html.get_title_and_sanitize_source(url)
        # DB中にurlが存在しなければ追加
	unless db_url
          db_url = Url.create! :url => url, :context => source , 
	  	 :last_update => now , :last_crawl => now	  
	end

	# チェックリストにすでになければ、チェックリストに追加
 	ch = CheckHistory.find(:first , :conditions => [" user_id=? and url_id=? ",self.id,db_url.id ])
	unless ch
	  CheckHistory.create! :last_check => (now - Rational(1, 24 * 60 * 60) ) ,
	  		       :user_id =>  self.id , :url_id => db_url.id ,  
		 	       :title => title
	end
      end
    rescue
      raise
      return false
    end
  end

  def remove_url(id)
    ch = CheckHistory.find(id)
    ch.destroy
#    url = remove_last_slash(url)
#    db_url = url.find(:first,:conditions => ["url=?",url])
#    ch = CheckHistory.find(:first,:conditions => ["user_id=? and url_id",self.id,db_url.id])
#    ch.delete!

  end

  # 削除用URLリストの取得
  def get_delete_list
    return CheckHistory.find(:all , :conditions => ["user_id=?",self.id])
  end

  # URLリストの取得
  def get_lists
    return CheckHistory.select("check_histories.* , urls.* ").
    	      where("check_histories.user_id="+self.id.to_s).
	      joins("INNER JOIN urls on check_histories.url_id=urls.id ").
	      order("urls.last_update desc")
	      #order(" CAST(CONVERT(VARCHAR,urls.last_update) as INT - CAST(CONVERT(VARCHAR( check_histories.last_check ) )) AS INT " )
  end

  def update_check(url_id)
    begin
      ActiveRecord::Base::transaction() do
        now = DateTime.now
        history = CheckHistory.find(:first , :conditions => ["url_id=? and user_id=?",url_id.to_s,self.id.to_s])
	history[:last_check] = (now - Rational(1, 24 * 60 * 60) ).to_s
	history.save!
      end   
    rescue
        raise      
    end
  end


private 
  def remove_last_slash(url)
    url = url.gsub(/\/$/,"")
  end

end
