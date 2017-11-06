class IndexController < ApplicationController
  def create
    render :json => {
      result: "true"
    }.to_json
  end

  def delete
    render :json => {
      result: "true"
    }.to_json
  end

  def list
    render :json => {
      result: "true"
    }.to_json
  end
end
