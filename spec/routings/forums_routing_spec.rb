require 'spec_helper'

describe ForumsController do

  describe "route generation" do
    it "should be correct routing for forums" do
      { :get    => "/forums"       }.should route_to(:controller => "forums", :action => "index")
      { :get    => "/forums/1"     }.should route_to(:controller => "forums", :action => "show",    :id => "1")    
    end
  end
end
