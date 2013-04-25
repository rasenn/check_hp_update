class Ranking
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  public
  def Ranking.get_pupular_urls
    return CheckHistory.
      select("check_histories.url_id,count(*) as count,check_histories.title,urls.url as url").
      joins("INNER JOIN urls on check_histories.url_id=urls.id").
      order("count(*)")
  end
end

