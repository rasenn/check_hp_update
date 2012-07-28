# -*- coding: utf-8 -*-

require "open-uri"

class ProcessHTML
  @encoding = "UTF-8"

  def initialize(encode="UTF-8")
    @encoding = encode
  end

  # ソースコードの取得
  def get_source(url,encoding=nil)
    encoding = @encoding unless encoding
    source = nil
    
    # ソースの取得(エンコード指定)
    open(url) do  |io|
      source = io.read
      p source.encoding
      p encoding , io.charset
      source = source.encode(encoding,io.charset)

    end
    puts source
    return source
  end

  # ソースコードのタグ・コメント削除
  def get_source_without_tags_and_comments(source)
    # タグ・コメントの削除。
    # jsを最初に削除するため、<!-- -->を始めに削除
    source = source.gsub(/<!\-\-.+?\-\->/m ,"")
    source = source.gsub(/<.+?>/,"")
    # 改行の削除
    source = source.gsub(/\s/m,"")
    return source
  end
  
  # 指定URLのサニタイズした（タグ・コメントを除いた）ソースを取得
  def get_sanitize_source(url)
    source = get_source(url)
    return get_source_without_tags_and_comments(source)
  end

  # 指定URLからタイトルと、サニタイズしたソースを取得
  def get_title_and_sanitize_source(url)
    source = get_source(url)
    sanitize_source = get_source_without_tags_and_comments(source)
    title = get_title(source)
    return [title,sanitize_source]
  end

  def get_title(source)
    if /<title>(.*)<\/title>/i =~ source
      return $&
    end
    return nil
  end



end


if __FILE__ == $0
  url = "http://galaxyheavyblow.web.fc2.com/"
  process = ProcessHTML.new
  puts process.get_title_and_sanitize_source(url)

end
