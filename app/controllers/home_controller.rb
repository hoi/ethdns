class HomeController < ApplicationController

  def index
    if params[:search].present?
      @search = params[:search]
      if EthAddress.is_address(params[:search])
        eth_address = EthAddress.find_by(address: params[:search])
      else
        eth_address = EthAddress.find_by(name: params[:search])
      end

      if eth_address.present?
        @url = "http://localhost:3000/s/#{eth_address.name}"
        @link = "https://etherscan.io/address/#{eth_address.address}"
      else
        @error = "No results"
      end
    end
  end


  def show
    eth_address = EthAddress.find_by(name: params[:name])

    if eth_address.nil?
      redirect_to '/' and return
    else
      redirect_to "https://etherscan.io/address/#{eth_address.address}" and return
    end
  end


  def new
    name = URI.escape(params[:name])
    eth_address_by_name = EthAddress.find_by(name: name)
    if eth_address_by_name.present?
      redirect_to "/?error=#{params[:name]} is taken" and return
    end

    if !EthAddress.is_address(params[:address])
      redirect_to '/?error=Not a valid address' and return
    end

    eth_address_by_address = EthAddress.find_by(address: params[:address])
    if eth_address_by_address.present?
      redirect_to "/?search=#{params[:address]}&error=Address already has nickname" and return
    end

    EthAddress.create!(name: params[:name], address: params[:address])
    redirect_to "/?search=#{params[:address]}" and return
  end


  def search
    redirect_to "/?search=#{params[:search]}" and return
  end

end
