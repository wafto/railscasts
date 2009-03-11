require File.dirname(__FILE__) + '/../spec_helper'

describe SpamReportsController, "as guest" do
  it_should_require_admin_for_actions :index, :show, :create, :destroy, :confirm
end

describe SpamReportsController, "as admin" do
  fixtures :all
  integrate_views
  
  before(:each) do
    session[:admin] = true
  end
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "index action should render show template" do
    get :show, :id => SpamReport.first
    response.should render_template(:show)
  end
  
  it "create action should redirect when model is valid" do
    SpamReport.any_instance.stubs(:valid?).returns(true)
    post :create, :comment_id => Comment.first
    response.should redirect_to(spam_reports_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    spam_report = SpamReport.first
    delete :destroy, :id => spam_report
    response.should redirect_to(spam_reports_url)
    SpamReport.exists?(spam_report.id).should be_false
  end
  
  it "confirm action should mark as confirmed model and redirect to index action" do
    spam_report = SpamReport.first
    spam_report.confirmed_at.should be_nil
    delete :confirm, :id => spam_report
    response.should redirect_to(spam_reports_url)
    spam_report.reload.confirmed_at.should_not be_nil
  end
end