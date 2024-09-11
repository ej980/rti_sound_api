require 'sinatra'
require 'json'
require 'sinatra/cors'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*' 
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :delete, :options, :head]
  end
end

get '/' do
  content_type :json
  { message: 'Welcome to Sinatra API!' }.to_json
end




  months = [
    { id: 1, name: '一月', img: 'https://meee.com.tw/CRwcteT.jpg' },
    {id: 2, name: '二月', img: 'https://meee.com.tw/CRwcteT.jpg'},
    {id: 3, name: '三月', img: 'https://i.meee.com.tw/CRwcteT.jpg'},
    {id: 4, name: '四月', img: 'https://meee.com.tw/CRwcteT'},
    {id: 5, name: '五月', img: 'https://meee.com.tw/CRwcteT'},
    {id: 6, name: '六月', img: 'https://meee.com.tw/CRwcteT'},
    {id: 7, name: '七月', img: 'https://meee.com.tw/CRwcteT'},
    {id: 8, name: '八月', img: 'https://meee.com.tw/CRwcteT'},
    {id: 9, name: '九月', img: 'https://meee.com.tw/CRwcteT'},
    {id: 10, name: '十月', img: 'https://meee.com.tw/CRwcteT'},
    {id: 11, name: '十一月', img: 'https://meee.com.tw/CRwcteT'},
    {id: 12, name: '十二月', img: 'https://meee.com.tw/CRwcteT'}
  ]
get '/months/list' do
  content_type :json
  months.to_json
end
 
