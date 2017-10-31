class PvController < ApplicationController

  def get
    render :json => {result: "testdesu"}.to_json
  end
end
