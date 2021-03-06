require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('h1', text: "Sign in") }
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Sign in" }
      
      it { should have_selector('h1', text: 'Sign in') }  
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Sign in" }
        it { should_not have_selector('div.aler.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
    
    
      
      it { should have_link('Account', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link "Sign in" }
      end
    end
  end
  
 describe "authorization" do
   
   describe "for non-signed-in users" do
     let(:user) { FactoryGirl.create(:user) }
     
     describe "When attempting to visit a protected page" do
       before do
         visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('h1', text: 'Update your profile')
          end
        end
      end
     
     describe "in the Users controller" do
       
       describe "visiting the edit page" do
         before { visit edit_user_path(user) }
         it { should have_selector('h1', text: 'Sign in') }
       end
       
       describe "submitting to the update action" do
         before { put user_path(user) }
         specify { response.should redirect_to(signin_path) }
       end
     end
     
     describe "in the Tasks controller" do
       
       describe "submitting to the create action" do
         before { post tasks_path }
         specify { response.should redirect_to(signin_path) }
       end
       
       describe "submitting to the destroy action" do
         before { delete task_path(FactoryGirl.create(:task)) }
         specify { response.should redirect_to(signin_path) }
       end
     end
     
   end
   
   describe "as wrong user" do
     let(:user) { FactoryGirl.create(:user) }
     let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
     before { sign_in user }
     
     describe "visiting Users#edit page" do
       before { visit edit_user_path(wrong_user) }
       it { should_not have_selector('h1', text: 'Edit user') }
     end
     
     describe "submitting a PUT request to the Users#update action" do
       before { put user_path(wrong_user) }
       specify { response.should redirect_to(root_path) }
     end
   end
 end 
  
end






