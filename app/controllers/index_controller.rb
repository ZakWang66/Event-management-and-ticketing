class IndexController < ApplicationController
    skip_before_action :authorized, only: [:show]
    
    def show
    end
end
