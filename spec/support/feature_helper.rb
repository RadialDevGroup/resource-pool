module FeatureHelpers
  def sign_out
    click_on "Log out"
  end

  def sign_in user=nil, password="password"
    if user
      visit new_user_session_path
    end
    sign_in_immediately user, password
  end

  def sign_in_immediately(user = nil, password = nil)
    @password = password || @password || Faker::Internet.password(15)
    @user = user

    fill_in "Email", with: @user.email
    fill_in "Password", with: @password

    within 'form' do
      click_button "Log in"
    end
  end

  def switch_user user
    sign_out
    sign_in user
  end

  def current_user
    @user
  end

  alias_method :current_owner, :current_user

  def current_password
    @password
  end

  def fixture_file file_name
    File.expand_path('../fixtures/'+file_name, File.dirname(__FILE__))
  end

  def within_first_content_heading &block
    within (1..6).map {|n| ".container h#{n}" }.join(','), match: :first, &block
  end

  def radio_select choice, options
    name = options.delete :from
    if choice.in? [true, false]
      choice = choice ? 'Yes' : 'No'
    end

    within(:xpath, "//div[input[@name = '#{name}']]") { choose choice }
  end

  module ClassMethods
    def sign_in owner = nil, password = nil
      before do
        sign_in owner, password
      end

      after do
        sign_out
        @owner = nil
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, :type => :feature
end
