# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index, layout: 'widgets' }
    end
  end
end
