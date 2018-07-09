class RequestsController < ApplicationController
  def new
    pass = params[:password]
    account = Account.where(ip: params[:ip]).first

    user = User.find account.user_id
    if user.password != pass 
      render inline: 'window.alert("sai pass");' and return
    end

    # if account.off?
    #   result = ''
    #   result += Slot.find_by(key: :variables).value
    #   result += 'delete $pages;'
    #   result += 'delete $this;'
    #   result += '$pages={};'
    #
    #   result += '$this={};'
    #   Standard.all.each do |c|
    #     result += "$this['#{c.key}']= #{c.value};"
    #   end
    #
    #   result += Slot.find_by(key: :run_loop).value
    #
    #   render :inline => result
    #
    #   return
    # end

    result = ''
    result += "$email='#{account.email}';"
    result += "$cheapcaptcha_api_key='#{account.cheapcaptcha_api_key}';"
    result += "$anticaptcha_api_key='#{account.anticaptcha_api_key}';"
    result += "$_2captcha_api_key='#{account._2captcha_api_key}';"
    result += "$username='#{account.username}';"
    result += "$pass='#{account.password}';"
    result += "$wallet_bitcoin='#{account.bitcoin}';"
    result += "$wallet_dogecoin='#{account.dogecoin}';"

    result += "$wallet_litecoin='#{account.litecoin}';"
    result += "$wallet_ethereum='#{account.ethereum}';"
    result += "$wallet_bitcoin_cash='#{account.bitcoin_cash}';"
    result += "$wallet_blackcoin='#{account.blackcoin}';"
    result += "$wallet_dashcoin='#{account.dashcoin}';"
    result += "$wallet_peercoin='#{account.peercoin}';"
    result += "$wallet_primecoin='#{account.primecoin}';"
    result += "$wallet_potcoin='#{account.potcoin}';"
    result += "$wallet_kb3coin='#{account.kb3coin}';"
    if account.info
      cc = account.info.gsub("\r\n",',');
      result += "$info='#{cc}';"
    end
    if account.info2
      cc = account.info2.gsub("\r\n",',');
      result += "$info2='#{cc}';"
    end

    list = Account.where(ip: params[:ip]).first
    if list
      result += Slot.find_by(key: :variables).value

      result += 'delete $pages;'
      result += 'delete $this;'

      result += '$pages={};'
      list = list.list.split(',').map{|p| p.to_i}
      pages = Page.where("id in (?)", list).where(status: :on).order :id
      pages.each do |p|
        result += "$pages['#{p.name}']={code: #{p.content}, time: #{p.time}, id: #{p.id}};"
      end


      result += '$this={};'
      Standard.all.each do |c|
        result += "$this['#{c.key}']= #{c.value};"
      end

      result += Slot.find_by(key: :run_loop).value

      render :inline => result
    else
      render html: 'error'
    end
  end

  def update
    pass = params[:password] || nil
    account = Account.where(ip: params[:ip]).first

    user = User.find account.user_id
    if user.password != pass 
      (render inline: 'window.close();' and return)
    end

    # if account.off?
    #   result = ''
    #   result += 'delete $pages;'
    #   result += '$pages={};'
    #
    #   render :inline => result
    #
    #   return
    # end

    result = ''
    result += "$email='#{account.email}';"
    result += "$cheapcaptcha_api_key='#{account.cheapcaptcha_api_key}';"
    result += "$anticaptcha_api_key='#{account.anticaptcha_api_key}';"
    result += "$_2captcha_api_key='#{account._2captcha_api_key}';"
    result += "$username='#{account.username}';"
    result += "$pass='#{account.password}';"
    result += "$wallet_bitcoin='#{account.bitcoin}';"
    result += "$wallet_dogecoin='#{account.dogecoin}';"

    result += "$wallet_litecoin='#{account.litecoin}';"
    result += "$wallet_ethereum='#{account.ethereum}';"
    result += "$wallet_bitcoin_cash='#{account.bitcoin_cash}';"
    result += "$wallet_blackcoin='#{account.blackcoin}';"
    result += "$wallet_dashcoin='#{account.dashcoin}';"
    result += "$wallet_peercoin='#{account.peercoin}';"
    result += "$wallet_primecoin='#{account.primecoin}';"
    result += "$wallet_potcoin='#{account.potcoin}';"
    result += "$wallet_kb3coin='#{account.kb3coin}';"

    list = Account.where(ip: params[:ip]).first
    if list

      result += 'delete $pages;'
      result += 'delete $this;'
      # result += Settings.variables
      result += '$pages={};'
      list = list.list.split(',').map{|p| p.to_i}
      pages = Page.where("id in (?)", list).where(status: :on).order :id
      pages.each do |p|
        result += "$pages['#{p.name}']={code: #{p.content}, time: #{p.time}, id: #{p.id}};"
      end


      result += '$this={};'
      Standard.all.each do |c|
        result += "$this['#{c.key}']= #{c.value};"
      end

      render :inline => result
    else
      render html: 'error'
    end
  end

  def report
    if params[:type] == 'no_balance'
      page = Page.find_by id: params[:id]
      page.off!
      page.save

      render html: 'iimDisplay("report done")'
    end
  end

  def data
    if params[:type] == 'baymack'
      result = '{"lvc":"lvc"'
      datas = Slot.where("key LIKE ?", "baymack_%")
      datas.each do |b|
        result = result + ',' + b.value
      end
      result = result + '}'
      render inline: "#{result}"
    elsif params[:type] == 'except_baymack'
      result = '{"lvc":"lvc"'
      datas = Slot.where("key LIKE ?", "except_baymack_%")
      datas.each do |b|
        result = result + ',' + b.value
      end
      result = result + '}'
      render inline: "#{result}"
    else
      render inline: ""
    end
  end

  def add_data
    slot = Slot.find_by(key: params[:type])
    if slot
      data = slot.value
      add = '"'+params[:href]+'": '+'"'+params[:value]+'"'
      data = data + ',' + add
      slot.update value: data
    else
      data = '"'+params[:href]+'": '+'"'+params[:value]+'"'
      Slot.create(key: params[:type], value: data)
    end

    render inline: ''
  end

  def add_data_account
    pass = params[:password]
    account = Account.where(ip: params[:ip]).first
    user = User.find account.user_id
    if user.password != pass
      render inline: 'window.alert("sai pass");' and return
    end
    type = params[:key]
    if type == 'status'
      if params[:value] == 'true'
        account.on!
      elsif params[:value] == 'false'
        account.off!
      elsif params[:value] == 'die'
        account.die!
      end
    else
      temp = account[type]
      data = temp || '' + params[:value]
      account.update "#{type}": data
    end
    render inline: ''
  end

  def info_flamzy_account
    accounts = Account.where('ip LIKE ?', "flamzy%").where(status: :off);
    result = nil
    accounts.each do |a|
      if a.info != ""
        content = a.info.gsub!("F", "f_")
        if result == nil
          result = content
        else
          result = result + ',' + content
        end
      end
    end
    render :inline => result || ''
  end

  def info_2flamzy_account
    accounts = Account.where('ip LIKE ?', "2flamzy%").where(status: :off);
    result = nil
    accounts.each do |a|
      if a.info != ""
        content = a.info.gsub!("F", "f_")
        if result == nil
          result = content
        else
          result = result + ',' + content
        end
      end
    end
    render :inline => result || ''
  end

  def info_skylom_account
    accounts = Account.where('ip LIKE ?', "skylom%").where(status: :off);
    result = nil
    accounts.each do |a|
      if a.info != ""
        content = a.info.gsub!("S", "s_")
        if result == nil
          result = content
        else
          result = result + ',' + content
        end
      end
    end
    render :inline => result || ''
  end

  def info_baymack_account
    accounts = Account.where('ip LIKE ?', "baymack%").where(status: :off);
    result = nil
    accounts.each do |a|
      if a.info != ""
        content = a.info.gsub!("B", "b_")
        if result == nil
          result = content
        else
          result = result + ',' + content
        end
      end
    end
    render :inline => result || ''
  end

  def page
    username = params[:username]
    user = User.find_by(username: username)
    unless user
      render inline: 'window.alert("sai pass");' and return
    end
    id = params[:id]
    page = Page.find_by(id: id)
    render inline: page.content
  end
end
