require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do
    
    it "should have the content 'App'" do
      visit root_path
      page.should have_content('App')
    end
  end
  
  describe "Contact page" do
    
    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: "Contact")
    end
  end
  
  describe "About us page" do
    
    it "should have the h1 'About us" do
      visit about_path
      page.should have_selector('h1', text: "About us")
    end
  end
  
  describe "Press page" do
    
    it "should have the h1 'Press'" do
      visit press_path
      page.should have_selector('h1', text: "Press")
    end
  end
  
  describe "Team page" do
    
    it "should have the h1 'Team'" do
      visit team_path
      page.should have_selector('h1', text: "Team")
    end
  end
  
end
