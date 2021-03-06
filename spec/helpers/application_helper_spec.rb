require 'spec_helper'

describe ApplicationHelper, '#dynamic_link_to' do
  it "appends an image icon to an external link" do
    url = 'http://www.google.com'
    title = 'outside'
    helper.dynamic_link_to(title, url).should eq ext_link_to(title, url)
  end

  it "does not append an image icon to an internal link" do
    url = '/internal/path.html'
    title = 'inside'
    helper.dynamic_link_to(title, url).should eq link_to(title, url)
  end
end

describe ApplicationHelper, '#ext_link_to' do
  it "appends an image icon to the link" do
    url = 'http://www.google.com'
    title = 'google'
    helper.ext_link_to(title, url).should eq link_to(title, url) + icon('share')
  end
end

describe ApplicationHelper, '#icon' do
  before :each do
    @flag_content = 'flag content'
  end

  it "returns correct markup when given a block" do
    icon_val = helper.icon( :flag ) do
      @flag_content
    end

    helper.content_tag( :i, @flag_content, class: 'icon-flag' ).should eq icon_val
  end

  it "returns correct markup when given a content string" do
    helper.icon( :flag, @flag_content ).should eq helper.content_tag( :i, @flag_content, class: 'icon-flag' )
  end

  it "merges class attributes correctly" do
    helper.icon( :flag, class: 'test' ).should eq helper.content_tag( :i, nil, class: ['test', 'icon-flag'] )
  end
end

describe ApplicationHelper, '#tx' do
  before :each do
    @test_text = 'test'
    @test_key = 'text'
    EXTERNAL_STRINGS['test_action'] = { @test_key => @test_text }
    params = { 'action' => 'test_action' }
    helper.stub( :params ).and_return( params )
  end

  it "should lookup the correct hash value based on action and key" do
    helper.tx( @test_key ).should eq @test_text
  end

  it "should return an html_safe string (unescaped)" do
    helper.tx( @test_key ).should be_html_safe
  end
end

describe ApplicationHelper, '#to' do
  before :each do
    @test_obj = [ 1, 2 ,3 ]
    @test_key = 'text'
    EXTERNAL_STRINGS['test_action'] = { @test_key => @test_obj }
    params = { 'action' => 'test_action' }
    helper.stub( :params ).and_return( params )
  end

  it "should lookup the correct hash value based on action and key" do
    helper.to( @test_key ).should eq @test_obj
  end
end

describe ApplicationHelper, '#label' do
  it 'should create a span with <label-given_class> and label as the classes' do
    helper.label('this is a success label').should  eq('<span class="label label-success">this is a success label</span>')
    helper.label('this is a warning label', 'warning').should  eq('<span class="label label-warning">this is a warning label</span>')
  end

  it 'should create html safe content' do
    helper.label('this is a success label').should  be_html_safe
  end
end

describe ApplicationHelper, '#unread_news_badge' do
  it 'should create the appropriate span if given true' do
    helper.unread_news_badge(true).should eq('<span class="badge badge-important">!</span>')
  end

  it 'should create nothing if given false or default' do
    helper.unread_news_badge(false).should eq(nil)
    helper.unread_news_badge.should eq(nil)
  end
end
