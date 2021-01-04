require 'sinatra'
require 'json'


class Web < Sinatra::Base
  @@user = 'itmo288706'
  @@plain_text = "text/plain; charset=UTF-8"

  result4 = lambda do
    content_type :json
    { message: @@user, "x-result": request.env["HTTP_X_TEST"], "x-body": request.body.read}.to_json
  end

  
  before do
    headers['X-Author'] = @@user
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Allow-Methods'] = "GET,POST,PUT,DELETE,OPTIONS"
    headers['Access-Control-Allow-Headers'] = "x-test,Content-Type,Accept,Access-Control-Allow-Headers"
  end
  
  get /\/?/ do
    headers['Content-Type'] = @@plain_text
    @@user
  end
  get /\/login\/?/ do
    headers['Content-Type'] = @@plain_text
    @@user
  end
  
  get /\/sample\/?/ do
    headers['Content-Type'] = @@plain_text
    "function task(x) {return x * this**2;}"
  end

  get /\/test\/?/ do
    require 'watir'
    require 'webdrivers'
    headers['Content-Type'] = @@plain_text

    Selenium::WebDriver::Chrome.driver_path = "~/chromedriver/chromedriver"
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--disable-popup-blocking')
    options.add_argument('--disable-translate')
    options.add_argument('--headless')

    b = Watir::Browser.new :chrome, options: options 
    b.goto(params["URL"])
    input = b.text_field id: "inp"
    b.button.click
    sleep 5
    val = input.value
    b.close
    return val
  end

  get /\/promise\/?/ do
    headers['Content-Type'] = @@plain_text
    "function task(x){ return new Promise((res, rej) => x < 18 ? res('yes') : rej('no')); }"
  end
  
  get /\/fetch\/?/ do
    erb :index
  end

  get /\/result4\/?/, &result4
  post /\/result4\/?/, &result4
  put /\/result4\/?/, &result4
  delete /\/result4\/?/, &result4
  options /\/result4\/?/, &result4
end