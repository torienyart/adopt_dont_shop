class AdminController < ApplicationController

  def index
    @shelters = Shelter.reverse_alphabetical
  end
end