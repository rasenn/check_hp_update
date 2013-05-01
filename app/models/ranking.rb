# -*- coding: utf-8 -*-
class Ranking
  ## 登録数の多い件数を表示する。
  def Ranking.get_popular_urls
    return Url.
      select("count(*),urls.id,urls.url,urls.title ").
      joins("INNER JOIN check_histories on check_histories.url_id=urls.id").
      group("urls.id").
      order("count(*) desc")
  end

end
