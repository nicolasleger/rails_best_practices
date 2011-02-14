require 'spec_helper'

describe RailsBestPractices::Reviews::MoveCodeIntoHelperReview do
  let(:runner) { RailsBestPractices::Core::Runner.new(:reviews => RailsBestPractices::Reviews::MoveCodeIntoHelperReview.new('array_count' => 2)) }

  it "should move code into helper" do
    content = <<-EOF
    <%= select_tag :state, options_for_select( [[t(:draft), "draft"],
                                                [t(:published), "published"]],
                                               params[:default_state] ) %>
    EOF
    runner.review('app/views/posts/show.html.erb', content)
    runner.should have(1).errors
    runner.errors[0].to_s.should == "app/views/posts/show.html.erb:3 - move code into helper (array_count >= 2)"
  end

  it "should not move code into helper with simple arguments" do
    content = <<-EOF
    <%= select_tag :state, options_for_select( Post.STATES ) %>
    EOF
    runner.review('app/views/posts/show.html.erb', content)
    runner.should have(0).errors
  end
end
