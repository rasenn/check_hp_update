# -*- coding: utf-8 -*-
require "kconv"
require "open-uri"
require "uri"

class ProcessHTML
  @encoding = "UTF-8"

  def initialize(encode="UTF-8")
    @encoding = encode
  end

  # ソースコードの取得
  def get_source(url,source_encoding=nil)
    source_encoding = @encoding unless source_encoding
    source = nil
    
    # ソースの取得(エンコード指定)
    open(url) do  |io|
      source = io.read.toutf8
    end
    return source
  end

  # ソースコードのタグ・コメント削除
  def get_source_without_tags_and_comments(source)
    # タグ・コメントの削除。
    # jsを最初に削除するため、<!-- -->を始めに削除
    source = source.gsub(/<!\-\-.+?\-\->/m ,"")
    source = source.gsub(/<script.*?>.+?<script>/im,"")
    source = source.gsub(/<.+?>/,"")
    # 改行の削除
    source = source.gsub(/\s/m,"")
    return source
  end
  
  # 指定URLのサニタイズした（タグ・コメントを除いた）ソースを取得
  def get_sanitize_source(url)
    title,source = get_title_and_sanitize_source(url)
    return source
  end

  # 指定URLからタイトルと、サニタイズしたソースを取得
  def get_title_and_sanitize_source(url)
    # ソースとタイトルを取得
    source = get_source(url)
    title = get_title(source)
    
    # フレームを含む場合のソースの取得
    additional_sources = get_frame_sources(url,source)
    source += additional_sources.join if additional_sources.size > 0

    # ninja toolsを削除
    source = remove_ninja_tools(source)

    # ソースをサニタイズ
    sanitize_source = get_source_without_tags_and_comments(source)
    return [title,sanitize_source]
  end

  def get_title(source)
    if /<title.*?>(.*)<\/title>/i =~ source
      return $1
    else
      return nil
    end
  end

  # フレームを使っていた場合にソースの配列を返す
  # ない場合には空配列
  def get_frame_sources(url,source)
    results = []
    # 相対パスから絶対パスを求める用
    merge_uri = URI.parse(url)

    # iframeのフレーム内情報の取得
    srcs = source.scan(/<i?frame.*?src=["'](.+?)["'].*?>/m)
    srcs.each do |src|
      get_url = merge_uri.merge(src[0]).to_s
      results.push get_source(get_url)
    end

    return results
  end

  
  def remove_ninja_tools(source)
    source = source.gsub(/<!-- shinobi ct2 -->(.*?)<!-- shinobi ct2 -->/m,"")
    source = source.gsub(/<noscript>.*?<\/noscript>/m,"")
    source = source.gsub(/<ul class="tdftad".*?<\/ul>/m,"")
    source = source.gsub(/<div class="tdftdiv".*?<\/div>/m,"")
    return source
  end


end


if __FILE__ == $0
  frame_url = "http://www.htmq.com/html/sample/frame.htm"
  iframe_url = "http://www.scollabo.com/banban/ref/sample/sample_61.html"

  process = ProcessHTML.new
  f_source  = process.get_source frame_url
  if_source = process.get_source iframe_url

  p process.get_frame_sources(frame_url, f_source).size
  p process.get_frame_sources(iframe_url, if_source).size

end
