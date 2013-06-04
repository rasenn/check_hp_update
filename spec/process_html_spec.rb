# coding : utf-8
require 'spec_helper'

describe ProcessHTML do
  frame_url = "http://www.htmq.com/html/sample/frame.htm"
  iframe_url = "http://www.scollabo.com/banban/ref/sample/sample_61.html"
  google_url = "http://google.co.jp"
  ninja_tools_url = "http://ryama.zatunen.com/"

  context "when get_source" do 
    it "can get source" do 
      subject.get_source(google_url).should_not be_nil
    end
  end

  context "when get_frame_sources" do
    describe " at page have iframe page" do 
      it "can get some source" do
        source = subject.get_source(iframe_url)
        source.should_not be_nil
        pages = subject.get_frame_sources(iframe_url,source)
        pages.size.should_not == 0
      end
    end

    describe " at page have frame page" do 
      it "can get some source" do
        source = subject.get_source(frame_url)
        source.should_not be_nil
        pages = subject.get_frame_sources(frame_url,source)
        pages.size.should_not == 0
      end
    end

    describe " at page have ninja tools" do
      it "can remove ninja tools" do
        origin_source1 = subject.get_source(ninja_tools_url)
        origin_source2 = subject.get_source(ninja_tools_url)
        origin_source1.should_not == origin_source2

        sanitized_source1 = subject.get_title_and_sanitize_source(ninja_tools_url)
        sanitized_source2 = subject.get_title_and_sanitize_source(ninja_tools_url)
        sanitized_source1.should == sanitized_source2
      end
    end
  end
  
  context "" do
  end
end
